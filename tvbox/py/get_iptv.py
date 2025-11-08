import re
import os
import shutil
import requests
import threading
from collections import OrderedDict
from datetime import datetime
from concurrent.futures import ThreadPoolExecutor, as_completed

# 添加线程锁确保线程安全
write_lock = threading.Lock()

tv_urls = [
    "https://qu.ax/vUBde.txt",
    "https://m3u.ibert.me/fmml_ipv6.m3u",
    "https://raw.githubusercontent.com/Guovin/iptv-api/refs/heads/gd/output/result.m3u",
    "https://raw.githubusercontent.com/zwc456baby/iptv_alive/master/live.m3u",
    "https://raw.githubusercontent.com/BurningC4/Chinese-IPTV/master/TV-IPV4.m3u",
    "https://raw.githubusercontent.com/Wirili/IPTV/refs/heads/main/live.m3u",
    "https://raw.githubusercontent.com/wwb521/live/refs/heads/main/tv.m3u",
    "https://raw.githubusercontent.com/Kimentanm/aptv/master/m3u/iptv.m3u",
    "https://live.zbds.top/tv/iptv4.m3u",
    "https://live.zbds.top/tv/iptv6.m3u",
    "https://raw.githubusercontent.com/wind005/TVlive/refs/heads/main/m3u/%E6%B9%96%E5%8D%97%E7%A7%BB%E5%8A%A8.m3u",
    "https://raw.githubusercontent.com/hanhan8127/TVBox/refs/heads/main/live.txt",
    "https://raw.githubusercontent.com/hujingguang/ChinaIPTV/main/cnTV_AutoUpdate.m3u8",
    "https://raw.githubusercontent.com/suxuang/myIPTV/refs/heads/main/ipv4.m3u",
    "https://raw.githubusercontent.com/suxuang/myIPTV/refs/heads/main/ipv6.m3u",
    "https://raw.githubusercontent.com/Free-TV/IPTV/master/playlist.m3u8",
    "https://live.zbds.top/tv/iptv4.txt",
"https://szyyds.cn/tv/live/x.txt",
"http://47.120.41.246:8899/zb.txt",
"https://live.kilvn.com/iptv.m3u",
"https://raw.githubusercontent.com/PizazzGY/TV/master/output/user_result.m3u",
"https://raw.githubusercontent.com/Guovin/iptv-api/gd/output/result.m3u",
"https://raw.githubusercontent.com/suxuang/myIPTV/refs/heads/main/ipv4.m3u",
"https://raw.githubusercontent.com/suxuang/myIPTV/refs/heads/main/ipv6.m3u",
"https://live.zbds.top/tv/iptv4.m3u",
"https://raw.githubusercontent.com/YueChan/Live/refs/heads/main/APTV.m3u",
"https://raw.githubusercontent.com/BurningC4/Chinese-IPTV/master/TV-IPV4.m3u",
"https://raw.githubusercontent.com/Ftindy/IPTV-URL/main/bestv.m3u",
"https://raw.githubusercontent.com/Ftindy/IPTV-URL/main/cqyx.m3u",
"https://raw.githubusercontent.com/Ftindy/IPTV-URL/main/yqgd.m3u",
"https://raw.githubusercontent.com/Ftindy/IPTV-URL/main/IPTV.m3u",
"https://raw.githubusercontent.com/Ftindy/IPTV-URL/main/hbgd.m3u",
"https://raw.githubusercontent.com/Ftindy/IPTV-URL/main/msp.m3u",
"https://live.zbds.top/tv/iptv6.m3u",
"https://raw.githubusercontent.com/fanmingming/live/main/tv/m3u/ipv6.m3u",
"https://live.fanmingming.cn/tv/m3u/ipv6.m3u",
"https://raw.githubusercontent.com/YueChan/Live/main/IPTV.m3u",
"https://raw.githubusercontent.com/whpsky/iptv/main/chinatv.m3u",
"https://gitee.com/xxy002/zhiboyuan/raw/master/dsy",
"https://raw.githubusercontent.com/kimwang1978/collect-tv-txt/main/merged_output.m3u",
"https://raw.githubusercontent.com/Kimentanm/aptv/master/m3u/iptv.m3u",
"https://raw.githubusercontent.com/BigBigGrandG/IPTV-URL/release/Gather.m3u",
"https://raw.githubusercontent.com/YanG-1989/m3u/main/Gather.m3u",
"https://raw.githubusercontent.com/fanmingming/live/main/tv/m3u/v6.m3u",
"https://epg.pw/test_channels.m3u",
"https://epg.pw/test_channels_hong_kong.m3u",
"https://epg.pw/test_channels_macau.m3u",
"https://epg.pw/test_channels_taiwan.m3u",
"https://iptv-org.github.io/iptv/countries/tw.m3u",
"https://epg.pw/test_channels_singapore.m3u",
"https://epg.pw/test_channels_malaysia.m3u",
"https://raw.githubusercontent.com/Free-TV/IPTV/master/playlist.m3u8",
"https://iptv-org.github.io/iptv/index.m3u",
"http://emby.free.coms.su/diyp/live.php",
"https://live.freetv.top/huyayqk.m3u",
"https://live.freetv.top/douyuyqk.m3u",
"https://www.goodiptv.club/yylunbo.m3u?url=https://lunbo.freetv.top",
"https://www.goodiptv.club/bililive.m3u",
"https://raw.githubusercontent.com/Kimentanm/aptv/master/m3u/ya.m3u",
"https://raw.githubusercontent.com/YanG-1989/m3u/main/yu.m3u",
]

def parse_template(template_file):
    template_channels = OrderedDict()
    current_category = None
    with open(template_file, "r", encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if line and not line.startswith("#"):
                if "#genre#" in line:
                    current_category = line.split(",")[0].strip()
                    template_channels[current_category] = []
                elif current_category:
                    channel_name = line.split(",")[0].strip()
                    template_channels[current_category].append(channel_name)
    return template_channels

def fetch_channels(url):
    channels = OrderedDict()
    try:
        response = requests.get(url, timeout=120)
        response.raise_for_status()
        response.encoding = "utf-8"
        if response.status_code != 200:
            print(f"从 {url} 获取数据失败，状态码: {response.status_code}")
            return OrderedDict()

        lines = response.text.split("\n")
        is_m3u = any("#EXTINF" in line for line in lines[:5])
        current_category = None

        if is_m3u:
            channel_name = ""
            channel_url = ""

            for line in lines:
                line = line.strip()

                if line.startswith("#EXTINF"):
                    # 更健壮的正则表达式匹配
                    group_match = re.search(r'group-title="([^"]*)"', line)
                    name_match = re.search(r',([^,]*)$', line)
                    
                    if group_match:
                        current_category = group_match.group(1).strip()
                    else:
                        # 如果没有group-title，使用默认分类
                        current_category = "默认分类"
                    
                    if name_match:
                        channel_name = name_match.group(1).strip()
                    else:
                        # 如果无法提取频道名称，标记为未知
                        channel_name = "未知频道"

                    if current_category not in channels:
                        channels[current_category] = []

                elif line and not line.startswith("#") and line.startswith("http"):
                    channel_url = line
                    if current_category and channel_name:
                        # 确保频道名称不为空
                        final_name = channel_name if channel_name and channel_name != "未知频道" else f"频道_{len(channels[current_category])}"
                        channels[current_category].append((final_name, channel_url))
                        channel_name = ""
                        channel_url = ""

        else:
            # 非 M3U 格式处理
            for line in lines:
                line = line.strip()
                if "#genre#" in line:
                    current_category = line.split(",")[0].strip()
                    channels[current_category] = []
                elif current_category and line and "," in line:
                    parts = line.split(",", 1)
                    if len(parts) == 2:
                        name, url = parts
                        name = name.strip()
                        url = url.strip()
                        if name and url:
                            channels[current_category].append((name, url))

        return channels

    except requests.exceptions.RequestException as e:
        print(f"请求 {url} 时发生错误: {e}")
        return OrderedDict()
    except Exception as e:
        print(f"处理 {url} 时发生未知错误: {str(e)}")
        return OrderedDict()

def match_channels(template_channels, all_channels):
    matched = OrderedDict()
    used_channels = set()  # 记录已使用的频道，避免重复
    unmatched_template_channels = OrderedDict()  # 记录模板中未匹配的频道
    unmatched_source_channels = OrderedDict()  # 记录源中未匹配的频道
    
    # 初始化未匹配频道结构
    for category in template_channels:
        unmatched_template_channels[category] = []
    
    # 初始化源中未匹配频道结构
    for category in all_channels:
        unmatched_source_channels[category] = []
    
    # 首先匹配模板中的频道
    for category, names in template_channels.items():
        matched[category] = OrderedDict()
        for name in names:
            # 提取所有可能的名称变体
            name_variants = [n.strip() for n in name.split("|") if n.strip()]
            primary_name = name_variants[0] if name_variants else name
            
            found = False
            for src_category, channels in all_channels.items():
                for chan_name, chan_url in channels:
                    # 检查是否已经使用过这个URL
                    channel_key = f"{chan_name}_{chan_url}"
                    if channel_key in used_channels:
                        continue
                    
                    # 使用正则表达式进行更精确的匹配
                    # 对于每个名称变体，创建一个正则表达式模式
                    for variant in name_variants:
                        # 将变体转换为正则表达式模式，允许名称中的一些变化
                        pattern = re.compile(re.escape(variant), re.IGNORECASE)
                        if pattern.search(chan_name):
                            # 使用源中的频道名称作为键，而不是模板中的主名称
                            if chan_name not in matched[category]:
                                matched[category][chan_name] = []
                            matched[category][chan_name].append((chan_name, chan_url))
                            used_channels.add(channel_key)
                            found = True
                            break
                    # 注意：这里不break，让同一个模板频道可以匹配多个源频道（多个线路）
            
            # 如果没有找到匹配，记录到未匹配列表
            if not found:
                unmatched_template_channels[category].append(name)
    
    # 然后找出源中未匹配的频道
    for src_category, channels in all_channels.items():
        for chan_name, chan_url in channels:
            channel_key = f"{chan_name}_{chan_url}"
            if channel_key not in used_channels:
                if src_category not in unmatched_source_channels:
                    unmatched_source_channels[src_category] = []
                unmatched_source_channels[src_category].append((chan_name, chan_url))

    return matched, unmatched_template_channels, unmatched_source_channels

def is_ipv6(url):
    return re.match(r"^http:\/\/\[[0-9a-fA-F:]+\]", url) is not None

def generate_outputs(channels, template_channels, unmatched_template_channels, unmatched_source_channels):
    written_urls = set()
    channel_counter = 0

    with write_lock:
        with open("lib/iptv.m3u", "w", encoding="utf-8") as m3u, \
             open("lib/iptv.txt", "w", encoding="utf-8") as txt:

            # 写入M3U头
            m3u.write("#EXTM3U\n")

            for category in template_channels:
                if category not in channels:
                    continue

                # 在txt文件中写入分类标题
                txt.write(f"\n{category},#genre#\n")
                
                # 遍历匹配到的所有频道名称
                for chan_name in channels[category]:
                    channel_data = channels[category][chan_name]
                    
                    if not channel_data:
                        continue

                    # 去重处理 - 只去除完全相同的频道名称和URL组合
                    unique_channels = []
                    seen_channel_keys = set()
                    
                    for chan_name_inner, chan_url in channel_data:
                        channel_key = f"{chan_name_inner}_{chan_url}"
                        if channel_key not in seen_channel_keys and chan_url not in written_urls:
                            unique_channels.append((chan_name_inner, chan_url))
                            seen_channel_keys.add(channel_key)
                            written_urls.add(chan_url)

                    if not unique_channels:
                        continue

                    # 为每个频道生成输出 - 每个频道名称单独计算线路数
                    total = len(unique_channels)
                    for idx, (display_name, chan_url) in enumerate(unique_channels, 1):
                        base_url = chan_url.split("$")[0]
                        suffix = "$LR•" + ("IPV6" if is_ipv6(chan_url) else "IPV4")
                        if total > 1:
                            suffix += f"•{total}『线路{idx}』"
                        final_url = f"{base_url}{suffix}"

                        # 写入M3U条目
                        m3u.write(f'#EXTINF:-1 tvg-id="{channel_counter}" tvg-name="{display_name}" group-title="{category}",{display_name}\n')
                        m3u.write(f"{final_url}\n")
                        
                        # 写入TXT条目
                        txt.write(f"{display_name},{final_url}\n")
                        
                        channel_counter += 1

            print(f"频道处理完成，总计有效频道数：{channel_counter}")

def generate_unmatched_report(unmatched_template_channels, unmatched_source_channels, output_file="py/config/iptv_test.txt"):
    """生成未匹配频道的报告"""
    with open(output_file, "w", encoding="utf-8") as f:
        f.write("# 未匹配频道报告\n")
        f.write("# 以下频道在源中未找到匹配项\n")
        f.write("# 生成时间: " + datetime.now().strftime("%Y-%m-%d %H:%M:%S") + "\n\n")
        
        # 第一部分：模板中未匹配的频道
        f.write("## 模板中未匹配的频道（在源中找不到）\n")
        total_template_unmatched = 0
        for category, channels in unmatched_template_channels.items():
            if channels:
                f.write(f"\n{category},#genre#\n")
                # 使用有序字典去重，保持顺序
                unique_channels = []
                seen_channels = set()
                for channel in channels:
                    if channel not in seen_channels:
                        unique_channels.append(channel)
                        seen_channels.add(channel)
                for channel in unique_channels:
                    f.write(f"{channel},\n")
                    total_template_unmatched += 1
        
        f.write(f"\n# 模板中未匹配频道总计: {total_template_unmatched}\n")
        
        # 第二部分：源中未匹配的频道
        f.write("\n\n## 源中未匹配的频道（在模板中找不到）\n")
        total_source_unmatched = 0
        for category, channels in unmatched_source_channels.items():
            if channels:
                f.write(f"\n{category},#genre#\n")
                # 使用有序字典去重，只保留频道名称
                unique_channel_names = []
                seen_channel_names = set()
                for channel_name, channel_url in channels:
                    if channel_name not in seen_channel_names:
                        unique_channel_names.append(channel_name)
                        seen_channel_names.add(channel_name)
                for channel_name in unique_channel_names:
                    # 在报告中只写入频道名称，不写入链接
                    f.write(f"{channel_name},\n")
                    total_source_unmatched += 1
        
        f.write(f"\n# 源中未匹配频道总计: {total_source_unmatched}\n")
        f.write(f"\n# 未匹配频道总计: {total_template_unmatched + total_source_unmatched}\n")
    
    print(f"未匹配频道报告已生成: {output_file}")
    print(f"模板中未匹配频道数: {total_template_unmatched}")
    print(f"源中未匹配频道数: {total_source_unmatched}")
    print(f"未匹配频道总计: {total_template_unmatched + total_source_unmatched}")
    
    # 在控制台也输出未匹配频道
    if total_template_unmatched > 0:
        print("\n=== 模板中未匹配的频道 ===")
        for category, channels in unmatched_template_channels.items():
            if channels:
                print(f"\n{category},#genre#")
                # 使用有序字典去重，保持顺序
                unique_channels = []
                seen_channels = set()
                for channel in channels:
                    if channel not in seen_channels:
                        unique_channels.append(channel)
                        seen_channels.add(channel)
                for channel in unique_channels:
                    print(f"{channel},")
    
    if total_source_unmatched > 0:
        print("\n=== 源中未匹配的频道 ===")
        for category, channels in unmatched_source_channels.items():
            if channels:
                print(f"\n{category},#genre#")
                # 使用有序字典去重，只保留频道名称
                unique_channel_names = []
                seen_channel_names = set()
                for channel_name, channel_url in channels:
                    if channel_name not in seen_channel_names:
                        unique_channel_names.append(channel_name)
                        seen_channel_names.add(channel_name)
                for channel_name in unique_channel_names:
                    # 在控制台输出中只显示频道名称，不显示链接
                    print(f"{channel_name},")
    
    return total_template_unmatched

def remove_unmatched_from_template(template_file, unmatched_template_channels):
    """从模板文件中删除未匹配的频道"""
    try:
        # 创建备份文件
        backup_file = template_file + ".backup"
        shutil.copy2(template_file, backup_file)
        print(f"已创建模板备份文件: {backup_file}")
    except Exception as e:
        print(f"创建备份文件失败: {e}")
        return
    
    # 读取原始模板文件
    try:
        with open(template_file, "r", encoding="utf-8") as f:
            lines = f.readlines()
    except Exception as e:
        print(f"读取模板文件失败: {e}")
        return
    
    # 创建新的模板内容
    new_lines = []
    current_category = None
    
    for line in lines:
        original_line = line.strip()
        
        if not original_line:
            # 保留空行
            new_lines.append(line)
            continue
            
        if original_line.startswith("#"):
            # 保留注释
            new_lines.append(line)
            continue
            
        if "#genre#" in original_line:
            current_category = original_line.split(",")[0].strip()
            new_lines.append(line)
            continue
            
        if current_category and original_line:
            # 提取频道名称（去掉可能存在的URL部分）
            channel_name = original_line.split(",")[0].strip()
            
            # 检查这个频道是否在未匹配列表中
            skip_channel = False
            if current_category in unmatched_template_channels:
                for unmatched_channel in unmatched_template_channels[current_category]:
                    # 比较频道名称，考虑可能包含|符号的情况
                    unmatched_primary = unmatched_channel.split("|")[0].strip()
                    channel_primary = channel_name.split("|")[0].strip()
                    if unmatched_primary == channel_primary:
                        skip_channel = True
                        print(f"从模板中删除未匹配频道: {channel_name}")
                        break
            
            if not skip_channel:
                new_lines.append(line)
    
    # 写入新的模板文件
    try:
        with open(template_file, "w", encoding="utf-8") as f:
            f.writelines(new_lines)
        print(f"已更新模板文件: {template_file}，删除了未匹配的频道")
    except Exception as e:
        print(f"写入模板文件失败: {e}")

def filter_sources(template_file, tv_urls):
    template = parse_template(template_file)
    all_channels = OrderedDict()

    print(f"开始从 {len(tv_urls)} 个源获取频道数据...")
    
    with ThreadPoolExecutor(max_workers=5) as executor:
        futures = {executor.submit(fetch_channels, url): url for url in tv_urls}
        for future in as_completed(futures):
            url = futures[future]
            try:
                result = future.result()
                if result:
                    for cat, chans in result.items():
                        if cat not in all_channels:
                            all_channels[cat] = []
                        # 添加来源信息以便调试
                        for chan_name, chan_url in chans:
                            all_channels[cat].append((chan_name, chan_url))
                    print(f"成功从 {url} 获取 {len(result)} 个分类的频道数据")
                else:
                    print(f"从 {url} 获取数据为空")
            except Exception as e:
                print(f"处理源 {url} 时出错: {str(e)}")

    total_channels = sum(len(chans) for chans in all_channels.values())
    print(f"总共获取到 {total_channels} 个频道")
    
    # 返回匹配结果和两种未匹配频道
    matched_channels, unmatched_template_channels, unmatched_source_channels = match_channels(template, all_channels)
    
    return matched_channels, unmatched_template_channels, unmatched_source_channels, template

# 示例使用
if __name__ == "__main__":
    
    template_file = "py/config/iptv.txt"
    matched_channels, unmatched_template_channels, unmatched_source_channels, template = filter_sources(template_file, tv_urls)
    generate_outputs(matched_channels, template, unmatched_template_channels, unmatched_source_channels)
    total_unmatched = generate_unmatched_report(unmatched_template_channels, unmatched_source_channels)
    
    # 如果存在未匹配的频道，询问是否从模板中删除
    if total_unmatched > 0:
        print(f"\n检测到 {total_unmatched} 个未匹配的频道")
        # 在GitHub Actions中自动删除未匹配频道
        print("自动从模板文件中删除未匹配的频道...")
        remove_unmatched_from_template(template_file, unmatched_template_channels)
    else:
        print("\n没有检测到未匹配的频道，无需更新模板文件")