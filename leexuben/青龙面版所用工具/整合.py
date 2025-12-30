import json
import requests
import os
import time

# ======================
# 配置
# ======================
SOURCES_JSON_PATH = '/ql/data/scripts/tvbox/config/sources.json'
TARGET_JSON_PATH = '/ql/data/scripts/tvbox/青龙.json'
# 如需提交到子目录，例如 bingo-tv/青龙.json，请使用：
# TARGET_PATH_ON_GITHUB = 'bingo-tv/青龙.json'
TARGET_PATH_ON_GITHUB = 'https://${GITHUB_TOKEN}@github.com/leexuben/TVBOX-merge/main/青龙.json'

# 请求头（可加 User-Agent 避免部分站点拦截）
HEADERS = {
    'User-Agent': 'Mozilla/5.0 (compatible; TVBoxMerge/1.0)'
}

# ======================
# 工具：从 URL 获取 sites
# ======================
def get_sites_from_url(url):
    try:
        resp = requests.get(url, headers=HEADERS, timeout=15)
        if resp.status_code == 200:
            content = resp.text
            try:
                data = json.loads(content)
                if isinstance(data, dict) and 'sites' in data:
                    return data['sites']
                elif isinstance(data, list):
                    return data
            except json.JSONDecodeError:
                # 兜底：尝试提取最外层 {} 的 JSON
                start = content.find('{')
                end = content.rfind('}') + 1
                if start != -1 and end != -1:
                    data = json.loads(content[start:end])
                    if isinstance(data, dict) and 'sites' in data:
                        return data['sites']
        return []
    except Exception as e:
        print(f"[请求失败] {url} | {e}")
        return []

# ======================
# 工具：修复路径与 jar
# ======================
def fix_site_paths(site, base_url, jar_url):
    if 'jar' not in site:
        site['jar'] = jar_url
    # 修复相对路径
    for k in ['api', 'ext']:
        if k in site and isinstance(site[k], str) and site[k].startswith('./'):
            site[k] = base_url.rstrip('/') + '/' + site[k][2:]
    return site

# ======================
# 主流程
# ======================
def main():
    if not os.path.exists(SOURCES_JSON_PATH):
        print(f"[错误] 找不到源配置：{SOURCES_JSON_PATH}")
        return

    # 读取源
    try:
        with open(SOURCES_JSON_PATH, 'r', encoding='utf-8') as f:
            sources = json.load(f)
    except Exception as e:
        print(f"[错误] 读取 sources.json 失败：{e}")
        return

    # 读取目标
    if os.path.exists(TARGET_JSON_PATH):
        try:
            with open(TARGET_JSON_PATH, 'r', encoding='utf-8') as f:
                target_data = json.load(f)
        except Exception as e:
            print(f"[警告] 读取目标文件失败，将新建：{e}")
            target_data = {}
    else:
        target_data = {}

    if 'sites' not in target_data:
        target_data['sites'] = []

    existing_keys = {s.get('key', '') forin target_data['sites'] if s.get('key')}

    for src in sources:
        url = src.get('url')
        jar = src.get('jar') or ''
        base = src.get('base') or ''
        if not url:
            continue
        print(f"[拉取] {url}")
        sites = get_sites_from_url(url)
        forin sites:
            fixed = fix_site_paths(s, base.rstrip('/') + '/', jar.rstrip('/'))
            key = fixed.get('key', '').strip()
            if key and key not in existing_keys:
                target_data['sites'].append(fixed)
                existing_keys.add(key)

    # 写出
    try:
        with open(TARGET_JSON_PATH, 'w', encoding='utf-8') as f:
            json.dump(target_data, f, ensure_ascii=False, indent=2)
        print(f"[完成] 已生成：{TARGET_JSON_PATH}，共 {len(target_data['sites'])} 个站点")
    except Exception as e:
        print(f"[错误] 写出文件失败：{e}")

if __name__ == '__main__':
    main()
