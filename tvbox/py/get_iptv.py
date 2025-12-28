import re
import os
import requests
import logging
import shutil
import threading
from collections import OrderedDict
from datetime import datetime
from concurrent.futures import ThreadPoolExecutor, as_completed
from requests.adapters import HTTPAdapter
from urllib3.util.retry import Retry

# 配置日志
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

# 全局锁，用于文件写入
write_lock = threading.Lock()

def get_session():
    """创建一个带有重试机制的requests Session"""
    session = requests.Session()
    retry = Retry(connect=3, backoff_factor=0.5)
    adapter = HTTPAdapter(max_retries=retry)
    session.mount('http://', adapter)
    session.mount('https://', adapter)
    return session

def load_urls_from_file(file_path):
    """从文本文件加载URL列表"""
    urls = []
    if not os.path.exists(file_path):
        logger.warning(f"URL配置文件未找到: {file_path}")
        return urls

    try:
        with open(file_path, "r", encoding="utf-8") as f:
            for line in f:
                line = line.strip()
                if line and not line.startswith("#"):
                    urls.append(line)
        logger.info(f"从 {file_path} 加载了 {len(urls)} 个源")
    except Exception as e:
        logger.error(f"读取URL文件失败: {e}")
    return urls

def parse_template(template_file):
    """解析模板文件"""
    template_channels = OrderedDict()
    current_category = None

    try:
        with open(template_file, "r", encoding="utf-8") as f:
            for line in f:
                line = line.strip()
                if not line or line.startswith("#"):
                    continue

                if "#genre#" in line:
                    current_category = line.split(",")[0].strip()
                    template_channels[current_category] = []
                elif current_category:
                    channel_name = line.split(",")[0].strip()
                    template_channels[current_category].append(channel_name)
    except FileNotFoundError:
        # 这是一个正常的流程控制，如果文件不存在可能只是没配置测试文件
        logger.warning(f"模板文件未找到: {template_file}")
        return None  # 返回 None 表示失败

    return template_channels

def fetch_channels(url):
    """从URL获取频道列表"""
    channels = OrderedDict()
    session = get_session()

    try:
        response = session.get(url, timeout=30)
        response.raise_for_status()
        response.encoding = response.apparent_encoding or "utf-8"

        lines = [line.strip() for line in response.text.splitlines() if line.strip()]
        if not lines:
            return channels

        is_m3u = any("#EXTINF" in line for line in lines[:10])

        if is_m3u:
            current_category = "默认分类"
            current_name = "未知频道"

            re_group = re.compile(r'group-title="([^"]*)"')
            re_name = re.compile(r',([^,]*)$')

            for line in lines:
                if line.startswith("#EXTINF"):
                    group_match = re_group.search(line)
                    if group_match:
                        current_category = group_match.group(1).strip()
                    name_match = re_name.search(line)
                    if name_match:
                        current_name = name_match.group(1).strip()
                elif not line.startswith("#") and "://" in line:
                    if current_category not in channels:
                        channels[current_category] = []
                    if current_name and current_name != "未知频道":
                        channels[current_category].append((current_name, line))
                    current_name = "未知频道"
        else:
            current_category = None
            for line in lines:
                if "#genre#" in line:
                    current_category = line.split(",")[0].strip()
                    if current_category not in channels:
                        channels[current_category] = []
                elif current_category and "," in line:
                    parts = line.split(",", 1)
                    if len(parts) == 2:
                        name, url = parts
                        if name.strip() and url.strip():
                            channels[current_category].append((name.strip(), url.strip()))

        return channels

    except Exception as e:
        logger.error(f"处理 {url} 时出错: {e}")
        return OrderedDict()

def match_channels(template_channels, all_channels):
    matched = OrderedDict()
    unmatched_template = OrderedDict()

    # 1. 数据扁平化
    flattened_source_channels = []
    for cat, chans in all_channels.items():
        for name, url in chans:
            flattened_source_channels.append({
                'norm_name': name.lower(),
                'name': name,
                'url': url,
                'cat': cat,
                'key': f"{name}_{url}"
            })

    used_channel_keys = set()

    # 初始化
    for cat in template_channels:
        matched[cat] = OrderedDict()
        unmatched_template[cat] = []

    # 2. 匹配逻辑
    for category, tmpl_names in template_channels.items():
        for tmpl_name in tmpl_names:
            
            # 去重并解析变体
            variants_raw = [n.strip() for n in tmpl_name.split("|") if n.strip()]
            variants = list(OrderedDict.fromkeys(variants_raw))

            primary_name = variants[0]

            found_for_this_template = False

            for variant in variants:
                variant_lower = variant.lower()
                
                # 正则：匹配结束($) 或 非字母数字且非加号([^a-z0-9\+])
                # 防止 CCTV5 匹配 CCTV5+
                pattern = re.compile(re.escape(variant_lower) + r'($|[^a-z0-9\+])')

                for src in flattened_source_channels:
                    if src['key'] in used_channel_keys:
                        continue

                    # 使用正则搜索
                    if pattern.search(src['norm_name']):
                        if primary_name not in matched[category]:
                            matched[category][primary_name] = []

                        matched[category][primary_name].append((src['name'], src['url']))

                        used_channel_keys.add(src['key'])
                        found_for_this_template = True

            if not found_for_this_template:
                unmatched_template[category].append(tmpl_name)

    # 3. 找出源中未使用的频道
    unmatched_source = OrderedDict()
    for src in flattened_source_channels:
        if src['key'] not in used_channel_keys:
            if src['cat'] not in unmatched_source:
                unmatched_source[src['cat']] = []
            unmatched_source[src['cat']].append((src['name'], src['url']))

    return matched, unmatched_template, unmatched_source

def is_ipv6(url):
    return "://[" in url

def generate_outputs(channels, template_channels, m3u_path, txt_path):
    """生成文件 - 路径参数化"""
    written_urls = set()

    # 确保输出目录存在
    os.makedirs(os.path.dirname(m3u_path), exist_ok=True)

    try:
        with write_lock:
            with open(m3u_path, "w", encoding="utf-8") as m3u, \
                 open(txt_path, "w", encoding="utf-8") as txt:

                m3u.write("#EXTM3U\n")

                for category in template_channels:
                    if category not in channels or not channels[category]:
                        continue

                    txt.write(f"\n{category},#genre#\n")

                    for channel_key_name, channel_list in channels[category].items():

                        unique_urls = []
                        seen_urls = set()

                        for _, url in channel_list:
                            if url not in seen_urls and url not in written_urls:
                                unique_urls.append(url)
                                seen_urls.add(url)
                                written_urls.add(url)

                        total_lines = len(unique_urls)
                        for idx, url in enumerate(unique_urls, 1):
                            base_url = url.split("$")[0]
                            suffix_name = "IPV6" if is_ipv6(url) else "IPV4"

                            display_name = channel_key_name

                            meta_suffix = f"$LR•{suffix_name}"
                            if total_lines > 1:
                                meta_suffix += f"•{total_lines}『线路{idx}』"

                            final_url = f"{base_url}{meta_suffix}"

                            m3u.write(f'#EXTINF:-1 tvg-name="{display_name}" group-title="{category}",{display_name}\n')
                            m3u.write(f"{final_url}\n")

                            txt.write(f"{display_name},{final_url}\n")

        logger.info(f"输出完成: {m3u_path}, {txt_path}")
    except Exception as e:
        logger.error(f"写入文件失败: {e}")

def generate_unmatched_report(unmatched_template, unmatched_source, report_file):
    """生成未匹配报告 - 路径参数化"""
    # 确保配置目录存在
    os.makedirs(os.path.dirname(report_file), exist_ok=True)
    
    total_template_lost = sum(len(v) for v in unmatched_template.values())

    try:
        with open(report_file, "w", encoding="utf-8") as f:
            f.write(f"# 未匹配报告 {datetime.now()}\n")
            f.write(f"# 模板未匹配数: {total_template_lost}\n\n")
            f.write("## 模板中有但源中无\n")
            for cat, names in unmatched_template.items():
                if names:
                    f.write(f"\n{cat},#genre#\n")
                    for name in list(OrderedDict.fromkeys(names)):
                        f.write(f"{name},\n")

            f.write("\n\n## 源中有但模板无\n")
            for cat, chans in unmatched_source.items():
                if chans:
                    f.write(f"\n{cat},#genre#\n")
                    unique_names = list(OrderedDict.fromkeys([c[0] for c in chans]))
                    for name in unique_names:
                        f.write(f"{name},\n")
        logger.info(f"报告已生成: {report_file}")
        return total_template_lost
    except Exception as e:
        logger.error(f"生成报告失败: {e}")
        return 0

def remove_unmatched_from_template(template_file, unmatched_template):
    backup_file = template_file + ".backup"
    try:
        shutil.copy2(template_file, backup_file)
        with open(template_file, "r", encoding="utf-8") as f:
            lines = f.readlines()

        new_lines = []
        current_cat = None
        to_remove = {cat: set(names) for cat, names in unmatched_template.items()}

        for line in lines:
            stripped = line.strip()
            if not stripped or stripped.startswith("#"):
                new_lines.append(line)
                continue
            if "#genre#" in stripped:
                current_cat = stripped.split(",")[0].strip()
                new_lines.append(line)
                continue
            if current_cat:
                name = stripped.split(",")[0].strip()
                if current_cat in to_remove and name in to_remove[current_cat]:
                    continue
                new_lines.append(line)

        with open(template_file, "w", encoding="utf-8") as f:
            f.writelines(new_lines)
        logger.info(f"已从模板 {template_file} 移除无效频道")
    except Exception as e:
        logger.error(f"更新模板失败: {e}")

def process_iptv_task(template_file, tv_urls, output_m3u, output_txt, report_file, auto_clean=True):
    """
    处理单个IPTV任务的封装函数
    """
    logger.info(f"=== 开始处理任务: {template_file} ===")
    
    template = parse_template(template_file)
    if not template:
        return

    logger.info(f"开始从 {len(tv_urls)} 个源获取数据...")
    all_channels = OrderedDict()

    # 这里使用临时Executor，或者可以将Executor传进来复用
    with ThreadPoolExecutor(max_workers=5) as executor:
        future_to_url = {executor.submit(fetch_channels, url): url for url in tv_urls}
        for future in as_completed(future_to_url):
            url = future_to_url[future]
            try:
                data = future.result()
                if data:
                    for cat, chans in data.items():
                        if cat not in all_channels:
                            all_channels[cat] = []
                        all_channels[cat].extend(chans)
            except Exception as e:
                logger.error(f"源 {url} 异常: {e}")

    logger.info("开始匹配频道...")
    matched, unmatched_tmpl, unmatched_src = match_channels(template, all_channels)

    generate_outputs(matched, template, output_m3u, output_txt)
    lost_count = generate_unmatched_report(unmatched_tmpl, unmatched_src, report_file)

    if auto_clean and lost_count > 0:
        logger.info(f"清理 {lost_count} 个无效频道...")
        remove_unmatched_from_template(template_file, unmatched_tmpl)
    
    logger.info(f"=== 任务完成: {template_file} ===\n")

if __name__ == "__main__":
    # === 配置区 ===
    URLS_FILE = "py/config/urls.txt"
    
    # 1. 加载源
    TV_URLS = load_urls_from_file(URLS_FILE)
    if not TV_URLS:
        logger.warning("未从文件中加载到URL，使用空列表")
        TV_URLS = [] 

    # === 任务1: 主列表 ===
    process_iptv_task(
        template_file="py/config/iptv.txt",
        tv_urls=TV_URLS,
        output_m3u="lib/iptv.m3u",
        output_txt="lib/iptv.txt",
        report_file="py/config/unmatched.txt", # 修改报告名，避免覆盖测试配置
        auto_clean=True
    )

    # === 任务2: 测试列表 (如果配置文件存在) ===
    TEST_TEMPLATE_FILE = "py/config/iptv_test.txt"
    if os.path.exists(TEST_TEMPLATE_FILE):
        process_iptv_task(
            template_file=TEST_TEMPLATE_FILE,
            tv_urls=TV_URLS,
            output_m3u="lib/iptv_test.m3u", # 输出到 lib 目录
            output_txt="lib/iptv_test.txt",
            report_file="py/config/unmatched_test.txt", # 测试的报告单独存放
            auto_clean=False # 测试列表建议不自动删除，方便调试
        )
    else:
        logger.info(f"未检测到测试配置 {TEST_TEMPLATE_FILE}，跳过测试生成。")
