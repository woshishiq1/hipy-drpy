#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# File  : 本地包订阅神器.py
# Author: DaShenHan&道长-----先苦后甜，任凭晚风拂柳颜------
# Author's Blog: https://blog.csdn.net/qq_32394351
# Date  : 2024/7/24

import json
import time
import requests
from urllib.parse import urljoin
import warnings

# 关闭警告
warnings.filterwarnings("ignore")
requests.packages.urllib3.disable_warnings()


def main():
    headers = {
        'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36',
    }
    timeout = 5
    # https://zysub-api.catni.cn/api/v1/subscribe/fe2qei
    url = str(input('请输入当前ip可访问的在线订阅地址:\n'))
    if url.startswith('http'):
        r = requests.get(url, headers=headers, timeout=timeout, verify=False)
        ret = r.json()
        # print(ret)
        sites = ret.get('sites') or []
        for site in sites:
            if site.get('api') and str(site['api']).startswith('.'):
                site['api'] = urljoin(url, site['api'])
            if site.get('ext') and str(site['ext']).startswith('.'):
                site['ext'] = urljoin(url, site['ext'])
        # print(sites)
        ret['sub_url'] = url
        ret['sub_time'] = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())
        ret['homeLogo'] = urljoin(url, ret['homeLogo'])
        ret['spider'] = urljoin(url, ret['spider'])
        with open('zysub.json', mode='w+', encoding='utf-8') as f:
            f.write(json.dumps(ret, ensure_ascii=False, indent=2))
    else:
        exit('地址不合法，程序已退出')


if __name__ == '__main__':
    main()
