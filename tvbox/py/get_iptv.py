import re
import requests
from collections import OrderedDict
from datetime import datetime
from concurrent.futures import ThreadPoolExecutor, as_completed
import threading

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
    "",
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
                    
                    # 检查频道名称是否匹配任何变体
                    for variant in name_variants:
                        if variant.lower() in chan_name.lower() or chan_name.lower() in variant.lower():
                            matched[category].setdefault(primary_name, []).append((chan_name, chan_url))
                            used_channels.add(channel_key)
                            found = True
                            break
                    if found:
                        break
                if found:
                    break
            
            # 如果没有找到匹配，记录到未匹配列表
            if not found:
                unmatched_template_channels[category].append(name)
    
    # 然后找出源中未匹配的频道
    for src_category, channels in all_channels.items():
        for chan_name, chan_url in channels:
            channel_key = f"{chan_name}_{chan_url}"
            if channel_key not in used_channels:
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
                
                for name in template_channels[category]:
                    primary_name = name.split("|")[0].strip()
                    channel_data = channels[category].get(primary_name, [])
                    
                    if not channel_data:
                        continue

                    # 去重处理
                    unique_channels = []
                    seen_urls = set()
                    
                    for chan_name, chan_url in channel_data:
                        if chan_url not in seen_urls and chan_url not in written_urls:
                            unique_channels.append((chan_name, chan_url))
                            seen_urls.add(chan_url)

                    if not unique_channels:
                        continue

                    # 为每个频道生成输出
                    total = len(unique_channels)
                    for idx, (chan_name, chan_url) in enumerate(unique_channels, 1):
                        # 使用获取的频道名称，如果没有则使用模板名称
                        display_name = chan_name if chan_name and chan_name != "未知频道" else primary_name
                        
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
                        
                        written_urls.add(chan_url)
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
                for channel in channels:
                    f.write(f"{channel},\n")
                    total_template_unmatched += 1
        
        f.write(f"\n# 模板中未匹配频道总计: {total_template_unmatched}\n")
        
        # 第二部分：源中未匹配的频道
        f.write("\n\n## 源中未匹配的频道（在模板中找不到）\n")
        total_source_unmatched = 0
        for category, channels in unmatched_source_channels.items():
            if channels:
                f.write(f"\n{category},#genre#\n")
                for channel_name, channel_url in channels:
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
                for channel in channels:
                    print(f"{channel},")
    
    if total_source_unmatched > 0:
        print("\n=== 源中未匹配的频道 ===")
        for category, channels in unmatched_source_channels.items():
            if channels:
                print(f"\n{category},#genre#")
                for channel_name, channel_url in channels:
                    # 在控制台输出中只显示频道名称，不显示链接
                    print(f"{channel_name},")

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
    
    matched_channels, unmatched_template_channels, unmatched_source_channels, template = filter_sources("py/config/iptv.txt", tv_urls)
    generate_outputs(matched_channels, template, unmatched_template_channels, unmatched_source_channels)
    generate_unmatched_report(unmatched_template_channels, unmatched_source_channels)