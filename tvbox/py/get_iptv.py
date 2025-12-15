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

# 全局锁，用于文件写入（如果需要多线程写入时）
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
                # 忽略空行和以 # 开头的注释行
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
        logger.error(f"模板文件未找到: {template_file}")

    return template_channels

def fetch_channels(url):
    """从URL获取频道列表，支持M3U和TXT格式"""
    channels = OrderedDict()
    session = get_session()
    
    try:
        response = session.get(url, timeout=30)
        response.raise_for_status()
        response.encoding = response.apparent_encoding or "utf-8" # 自动检测编码
        
        lines = [line.strip() for line in response.text.splitlines() if line.strip()]
        if not lines:
            return channels

        # 判断是否为 M3U 格式 (检查前几行)
        is_m3u = any("#EXTINF" in line for line in lines[:10])

        if is_m3u:
            current_category = "默认分类"
            current_name = "未知频道"
            
            # 预编译正则
            re_group = re.compile(r'group-title="([^"]*)"')
            re_name = re.compile(r',([^,]*)$')

            for line in lines:
                if line.startswith("#EXTINF"):
                    # 提取分类
                    group_match = re_group.search(line)
                    if group_match:
                        current_category = group_match.group(1).strip()
                    
                    # 提取名称
                    name_match = re_name.search(line)
                    if name_match:
                        current_name = name_match.group(1).strip()
                
                elif not line.startswith("#") and "://" in line:
                    # 这是一个URL行
                    if current_category not in channels:
                        channels[current_category] = []
                    
                    # 简单过滤无效名称
                    if current_name and current_name != "未知频道":
                        channels[current_category].append((current_name, line))
                    
                    # 重置名称，防止下一次使用旧名称
                    current_name = "未知频道"
        else:
            # TXT 格式处理 (Genre,Name,URL)
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

    except requests.exceptions.RequestException as e:
        logger.error(f"请求 {url} 失败: {e}")
        return OrderedDict()
    except Exception as e:
        logger.error(f"处理 {url} 时发生未知错误: {e}")
        return OrderedDict()

def match_channels(template_channels, all_channels):
    """
    匹配频道逻辑优化版
    """
    matched = OrderedDict()
    unmatched_template = OrderedDict()
    
    # 1. 数据扁平化预处理：将所有源频道放入一个大列表中，避免多层循环
    # 结构: (normalized_name, original_name, url, category)
    # 这里的 normalized_name 用于不区分大小写的比对
    flattened_source_channels = []
    for cat, chans in all_channels.items():
        for name, url in chans:
            flattened_source_channels.append({
                'norm_name': name.lower(),
                'name': name,
                'url': url,
                'cat': cat,
                'key': f"{name}_{url}" # 用于去重的唯一键
            })

    used_channel_keys = set()
    
    # 初始化输出结构
    for cat in template_channels:
        matched[cat] = OrderedDict()
        unmatched_template[cat] = []

    # 2. 匹配逻辑
    for category, tmpl_names in template_channels.items():
        for tmpl_name in tmpl_names:
            # 解析变体: "CCTV1|CCTV-1" -> ["CCTV1", "CCTV-1"]
            variants = [n.strip() for n in tmpl_name.split("|") if n.strip()]
            
            found_for_this_template = False
            
            # 对每个变体进行匹配
            for variant in variants:
                variant_lower = variant.lower()
                
                # 在扁平化的源列表中搜索
                # 优化点：不再使用正则，而是使用字符串包含 (in) 或 精确匹配
                # 如果需要精确匹配优先，可以分两轮；这里保留原逻辑的"包含即匹配"
                
                for src in flattened_source_channels:
                    # 检查是否已使用
                    if src['key'] in used_channel_keys:
                        continue
                        
                    # 核心匹配逻辑：源频道名称 包含 模板变体
                    # 例如：模板 "CCTV-1" 匹配源 "CCTV-1 FHD"
                    if variant_lower in src['norm_name']:
                        if src['name'] not in matched[category]:
                            matched[category][src['name']] = []
                        
                        matched[category][src['name']].append((src['name'], src['url']))
                        used_channel_keys.add(src['key'])
                        found_for_this_template = True
                        
                        # 注意：原代码逻辑没有 break，允许一个变体匹配多个源频道（多线路）
            
            if not found_for_this_template:
                unmatched_template[category].append(tmpl_name)

    # 3. 找出源中完全未被使用的频道
    unmatched_source = OrderedDict()
    for src in flattened_source_channels:
        if src['key'] not in used_channel_keys:
            if src['cat'] not in unmatched_source:
                unmatched_source[src['cat']] = []
            unmatched_source[src['cat']].append((src['name'], src['url']))

    return matched, unmatched_template, unmatched_source

def is_ipv6(url):
    """检测是否为 IPv6 地址"""
    # 简单的 IPv6 URL 检测: http://[2409:...]
    return "://[" in url

def generate_outputs(channels, template_channels):
    """生成 m3u 和 txt 文件"""
    written_urls = set()
    channel_counter = 1
    
    output_m3u_path = "lib/iptv.m3u"
    output_txt_path = "lib/iptv.txt"

    try:
        with write_lock:
            with open(output_m3u_path, "w", encoding="utf-8") as m3u, \
                 open(output_txt_path, "w", encoding="utf-8") as txt:
                
                m3u.write("#EXTM3U\n")
                
                for category in template_channels:
                    if category not in channels or not channels[category]:
                        continue
                        
                    txt.write(f"\n{category},#genre#\n")
                    
                    # 遍历该分类下的匹配频道
                    for channel_key_name, channel_list in channels[category].items():
                        # 去重逻辑：同一个频道名下，去除 URL 相同的
                        unique_urls = []
                        seen_urls = set()
                        
                        for _, url in channel_list:
                            if url not in seen_urls and url not in written_urls:
                                unique_urls.append(url)
                                seen_urls.add(url)
                                written_urls.add(url)
                        
                        total_lines = len(unique_urls)
                        for idx, url in enumerate(unique_urls, 1):
                            # 生成后缀
                            base_url = url.split("$")[0] # 清理可能已有的后缀
                            suffix_name = "IPV6" if is_ipv6(url) else "IPV4"
                            
                            # 构造显示名称
                            display_name = channel_key_name
                            
                            # 构造最终 URL 标注
                            # 格式：$LR•IPV4•2『线路1』
                            meta_suffix = f"$LR•{suffix_name}"
                            if total_lines > 1:
                                meta_suffix += f"•{total_lines}『线路{idx}』"
                            
                            final_url = f"{base_url}{meta_suffix}"
                            
                            # 写入 M3U
                            m3u.write(f'#EXTINF:-1 tvg-id="{channel_counter}" tvg-name="{channel_key_name}" group-title="{category}",{display_name}\n')
                            m3u.write(f"{final_url}\n")
                            
                            # 写入 TXT
                            txt.write(f"{display_name},{final_url}\n")
                            
                            channel_counter += 1
                            
        logger.info(f"输出完成，共处理 {channel_counter - 1} 个有效频道。")
    except Exception as e:
        logger.error(f"写入文件失败: {e}")

def generate_unmatched_report(unmatched_template, unmatched_source):
    """生成未匹配报告"""
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    report_file = "py/config/iptv_test.txt"
    
    total_template_lost = sum(len(v) for v in unmatched_template.values())
    total_source_lost = sum(len(v) for v in unmatched_source.values())
    
    try:
        with open(report_file, "w", encoding="utf-8") as f:
            f.write(f"# 未匹配频道报告 - {timestamp}\n")
            f.write(f"# 模板未匹配数: {total_template_lost}\n")
            f.write(f"# 源未利用频道数: {total_source_lost}\n\n")
            
            f.write("## 1. 模板中存在但源中未找到的频道 (建议从模板删除)\n")
            for cat, names in unmatched_template.items():
                if names:
                    f.write(f"\n{cat},#genre#\n")
                    # 去重保留顺序
                    for name in list(OrderedDict.fromkeys(names)):
                        f.write(f"{name},\n")
            
            f.write("\n\n## 2. 源中存在但模板未收录的频道 (建议添加到模板)\n")
            for cat, chans in unmatched_source.items():
                if chans:
                    f.write(f"\n{cat},#genre#\n")
                    # 只记录名称
                    unique_names = list(OrderedDict.fromkeys([c[0] for c in chans]))
                    for name in unique_names:
                        f.write(f"{name},\n")
        
        logger.info(f"未匹配报告已生成: {report_file}")
        return total_template_lost
        
    except Exception as e:
        logger.error(f"生成报告失败: {e}")
        return 0

def remove_unmatched_from_template(template_file, unmatched_template):
    """备份并更新模板，移除未匹配项"""
    backup_file = template_file + ".backup"
    try:
        shutil.copy2(template_file, backup_file)
        logger.info(f"备份模板至: {backup_file}")
        
        with open(template_file, "r", encoding="utf-8") as f:
            lines = f.readlines()
            
        new_lines = []
        current_cat = None
        
        # 构建需删除集合以加快查找: {"央视": {"CCTV-99", ...}}
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
                # 检查是否在删除列表中
                # 注意：模板中可能是 "CCTV1|CCTV-1"，未匹配列表中记录的是整串
                if current_cat in to_remove and name in to_remove[current_cat]:
                    logger.info(f"移除无效频道: [{current_cat}] {name}")
                    continue
                new_lines.append(line)
        
        with open(template_file, "w", encoding="utf-8") as f:
            f.writelines(new_lines)
            
        logger.info("模板文件更新完成。")
        
    except Exception as e:
        logger.error(f"更新模板失败: {e}")

def main(template_file, tv_urls):
    # 1. 解析模板
    logger.info("开始解析模板...")
    template = parse_template(template_file)
    
    # 2. 并发获取源数据
    logger.info(f"开始从 {len(tv_urls)} 个源获取数据...")
    all_channels = OrderedDict()
    
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
                    logger.info(f"源 {url} 获取成功: {sum(len(v) for v in data.values())} 个频道")
                else:
                    logger.warning(f"源 {url} 无数据")
            except Exception as e:
                logger.error(f"源 {url} 处理异常: {e}")

    # 3. 核心匹配
    logger.info("开始匹配频道...")
    matched, unmatched_tmpl, unmatched_src = match_channels(template, all_channels)
    
    # 4. 生成结果文件
    logger.info("生成播放列表文件...")
    generate_outputs(matched, template)
    
    # 5. 生成报告
    lost_count = generate_unmatched_report(unmatched_tmpl, unmatched_src)
    
    # 6. (可选) 自动清洗模板
    if lost_count > 0:
        logger.info(f"发现 {lost_count} 个模板频道未匹配，准备从模板中移除...")
        remove_unmatched_from_template(template_file, unmatched_tmpl)
    else:
        logger.info("所有模板频道均匹配成功。")

if __name__ == "__main__":
    # 配置区
    TEMPLATE_FILE = "py/config/iptv.txt"
    URLS_FILE = "py/config/urls.txt"
    
    TV_URLS = load_urls_from_file(URLS_FILE)
    
    main(TEMPLATE_FILE, TV_URLS)
