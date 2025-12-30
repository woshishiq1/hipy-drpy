- name: Create and run merge script
  run: |
    cat > merge_script.py << 'EOF'
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import os
import sys
import json
import time
import requests

# ======================
# 配置区 - 修改为相对路径
# ======================
SOURCES_JSON_PATH = '青龙面板版所用工具/source.json'
TARGET_JSON_PATH = 'QLTV.json'

# 请求头
HEADERS = {
    'User-Agent': 'Mozilla/5.0 (compatible; TVBoxMerge/1.0)'
}

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
                start = content.find('{')
                end = content.rfind('}') + 1
                if start != -1 and end != 0:
                    data = json.loads(content[start:end])
                    if isinstance(data, dict) and 'sites' in data:
                        return data['sites']
        return []
    except Exception as e:
        print(f"[请求失败] {url} | {e}")
        return []

def fix_site_paths(site, base_url, jar_url):
    base = base_url.rstrip('/')
    for k, v in site.items():
        if isinstance(v, str) and v.startswith('./'):
            site[k] = base + '/' + v[2:]
    if 'jar' not in site and jar_url and jar_url.strip():
        site['jar'] = jar_url.rstrip('/')
    return site

def main():
    if not os.path.exists(SOURCES_JSON_PATH):
        print(f"[错误] 找不到源配置：{SOURCES_JSON_PATH}")
        return

    try:
        with open(SOURCES_JSON_PATH, 'r', encoding='utf-8') as f:
            sources = json.load(f)
    except Exception as e:
        print(f"[错误] 读取 sources.json 失败：{e}")
        return

    if os.path.exists(TARGET_JSON_PATH):
        try:
            with open(TARGET_JSON_PATH, 'r', encoding='utf-8') as f:
                target_data = json.load(f)
        except Exception as e:
            print(f"[警告] 读取目标文件失败，将新建：{e}")
            target_data = {}
    else:
        target_data = {}

    if not isinstance(target_data, dict):
        print("[警告] 目标文件内容不是对象，将使用空对象作为基础")
        target_data = {}

    if 'sites' not in target_data:
        target_data['sites'] = []
    target_data['sites'][:] = []

    seen_keys = set()
    merged_sites = []
    for src in sources:
        url = src.get('url')
        jar = src.get('jar') or ''
        base = src.get('base') or ''

        if not url:
            continue

        print(f"[拉取] {url}")
        sites = get_sites_from_url(url)
        base_url = base.rstrip('/') + '/'
        jar_url = jar.rstrip('/')
        forin sites:
            fixed = fix_site_paths(s, base_url, jar_url)
            key = fixed.get('key', '').strip()
            if key and key not in seen_keys:
                seen_keys.add(key)
                merged_sites.append(fixed)

    target_data['sites'] = merged_sites

    try:
        with open(TARGET_JSON_PATH, 'w', encoding='utf-8') as f:
            items = []
            for k in sorted(target_data.keys()):
                v = target_data[k]
                if k == 'sites':
                    if not merged_sites:
                        items.append('  "sites": []')
                    else:
                        lines = [json.dumps(x, ensure_ascii=False, separators=(',', ':')) for x in merged_sites]
                        joined = ',\n    '.join(lines)
                        items.append(f'  "sites": [\n    {joined}\n  ]')
                else:
                    items.append(f'  "{k}": {json.dumps(v, ensure_ascii=False, separators=(",", ":"))}')
            f.write('{\n')
            f.write(',\n'.join(items))
            f.write('\n}\n')

        print(f"[完成] 已生成：{TARGET_JSON_PATH}，共 {len(merged_sites)} 个站点")
    except Exception as e:
        print(f"[错误] 写出文件失败：{e}")

if __name__ == '__main__':
    main()
EOF

    python merge_script.py
