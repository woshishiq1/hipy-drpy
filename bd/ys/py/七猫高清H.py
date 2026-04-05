# coding=utf-8
# !/usr/bin/python

"""

内容均从互联网收集而来 仅供交流学习使用 严禁用于商业用途 请于24小时内删除

"""

from concurrent.futures import ThreadPoolExecutor
from Crypto.Util.Padding import unpad
from Crypto.Util.Padding import pad
from urllib.parse import unquote
from Crypto.Cipher import ARC4
from urllib.parse import quote
from base.spider import Spider
from Crypto.Cipher import AES
from datetime import datetime
from bs4 import BeautifulSoup
from base64 import b64decode
import concurrent.futures
import urllib.request
import urllib.parse
import threading
import datetime
import binascii
import requests
import base64
import json
import time
import sys
import re
import os

sys.path.append('..')

xurl1 = "https://www.5544ww.com"

headerx = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.87 Safari/537.36'
          }

detail = requests.get(url=xurl1, headers=headerx)
detail.encoding = "utf-8"
res = detail.text
pattern = r"decodeURIComponent\('(.+?)'\)"
match = re.search(pattern, res)
if match:
    extracted_string = match.group(1)
    real_code = unquote(extracted_string)
    domain_match = re.search(r'"(.*?)"', real_code)
    if domain_match:
        domain = domain_match.group(1)

xurl = f"https://www.{domain}"

headers = {
    'accept': '*/*',
    'accept-language': 'zh-CN,zh;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6',
    'cache-control': 'no-cache',
    'content-type': 'application/json',
    'pragma': 'no-cache',
    'priority': 'u=1, i',
    'referer': xurl,
    'sec-ch-ua': '"Microsoft Edge";v="143", "Chromium";v="143", "Not A(Brand";v="24"',
    'sec-ch-ua-mobile': '?0',
    'sec-ch-ua-platform': '"Windows"',
    'sec-fetch-dest': 'empty',
    'sec-fetch-mode': 'cors',
    'sec-fetch-site': 'same-origin',
    'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36 Edg/143.0.0.0',
          }

session = requests.Session()
adapter = requests.adapters.HTTPAdapter(pool_connections=50, pool_maxsize=50, max_retries=1)
session.mount('https://', adapter)
session.mount('http://', adapter)

class Spider(Spider):

    def getName(self):
        return "首页"

    def init(self, extend):
        pass

    def isVideoFormat(self, url):
        pass

    def manualVideoCheck(self):
        pass

    def homeVideoContent(self):
        pass

    def searchContentPage(self, key, quick, pg):
        pass

    def decrypt_aes(self, data_b64, key_b64):
        raw_data = base64.b64decode(data_b64)
        key = base64.b64decode(key_b64)
        iv = raw_data[:16]
        ciphertext = raw_data[16:]
        cipher = AES.new(key, AES.MODE_CBC, iv)
        decrypted_data = unpad(cipher.decrypt(ciphertext), AES.block_size).decode('utf-8')
        return decrypted_data

    def homeContent(self, filter):
        result = {"class": []}
        data_bb = self.fetch_navigation_data()
        self.process_navigation_items(data_bb, result)
        return result

    def fetch_navigation_data(self):
        url = f"{xurl}/api/member/getnav?_v="
        detail = requests.get(url=url, headers=headers)
        detail.encoding = "utf-8"
        data = detail.json()
        data_b64 = data['data']['data']
        key_b64 = data['data']['key']
        data_bb = self.decrypt_aes(data_b64, key_b64)
        return json.loads(data_bb)

    def process_navigation_items(self, data_bb, result):
        for vod in data_bb:
            name = vod['name']
            if self.should_skip_navigation_item(name):
                continue
            id = self.build_navigation_id(vod)
            result["class"].append({"type_id": id, "type_name": name})

    def should_skip_navigation_item(self, name):
        skip_names = ["首页", "美图", "小说"]
        return name in skip_names

    def build_navigation_id(self, vod):
        return f"{vod['child'][0]['id']}@{vod['child'][0]['fid']}"

    def categoryContent(self, cid, pg, filter, ext):
        page = self.parse_category_page(pg)
        params = self.build_category_params(cid, page)
        data_bb = self.fetch_category_data(params)
        videos = self.process_category_videos(data_bb)
        return self.build_category_result(videos, pg)

    def parse_category_page(self, pg):
        return int(pg) if pg else 1

    def build_category_params(self, cid, page):
        fenge = cid.split("@")
        return {'cid': fenge[0], 'fcid': fenge[1], 'page_no': page, 'page_size': 42, 'tag': 'video', 'sort': 'new',
                '_v': ''}

    def fetch_category_data(self, params):
        url = f"{xurl}/api/video/index"
        detail = session.get(url, params=params, headers=headers, timeout=5)
        detail.encoding = "utf-8"
        data = detail.json()
        data_b64 = data['data']['data']
        key_b64 = data['data']['key']
        data_bb = self.decrypt_aes(data_b64, key_b64)
        return json.loads(data_bb)

    def process_category_videos(self, data_bb):
        with ThreadPoolExecutor(max_workers=32) as executor:
            results = executor.map(self.process_single_vod, data_bb['lists'])
        return [v for v in results if v]

    def build_category_result(self, videos, pg):
        return {'list': videos, 'page': pg, 'pagecount': 9999, 'limit': 90, 'total': 999999}

    def process_single_vod(self, vod):
        name = vod.get('title', '')
        id = vod.get('id', '')
        remark = vod.get('times', '暂无备注')
        pic = self.extract_vod_pic(vod)
        return {"vod_id": id, "vod_name": name, "vod_pic": pic, "vod_remarks": remark}

    def extract_vod_pic(self, vod):
        cover_value = vod.get('cover')
        if not isinstance(cover_value, list) or not cover_value:
            return ""
        try:
            pics_path = cover_value[0]
            url_pic = f"https://ggfm.gszy12348.com/{pics_path}"
            detail = session.get(url=url_pic, headers=headers, timeout=3)
            if detail.status_code == 200:
                detail.encoding = "utf-8"
                pic_text = detail.text
                if "base64" in pic_text[:50]:
                    pic_text = self.clean_pic_text(pic_text)
                return pic_text
        except Exception:
            pass
        return ""

    def clean_pic_text(self, pic_text):
        pic_text = pic_text.replace('\ufeff', '').strip()
        pic_text = pic_text.replace("\\", "/")
        pic_text = pic_text.replace("\r\n", "").replace("\n", "").replace("%0D%0A", "")
        return pic_text

    def detailContent(self, ids):
        did = ids[0]
        result = {}
        videos = []
        data_bb = self.fetch_video_detail_data(did)
        content = self.extract_video_content(data_bb)
        bofang = self.extract_play_url(data_bb)
        videos.append({"vod_id": did, "vod_content": content, "vod_play_from": "七猫专线", "vod_play_url": bofang})
        result['list'] = videos
        return result

    def fetch_video_detail_data(self, did):
        params = {'id': did, '_v': ''}
        url = f"{xurl}/api/videos/videodetail"
        detail = requests.get(url=url, params=params, headers=headers)
        detail.encoding = "utf-8"
        data = detail.json()
        data_b64 = data['data']['data']
        key_b64 = data['data']['key']
        data_bb = self.decrypt_aes(data_b64, key_b64)
        return json.loads(data_bb)

    def extract_video_content(self, data_bb):
        update_time = data_bb.get('create_time', '暂无备注')
        return '为您介绍剧情📢上架时间' + update_time

    def extract_play_url(self, data_bb):
        h264_url = data_bb['content'][0]['h264Url']
        return f"https://h3.xinghun1.com/data/{h264_url}"

    def playerContent(self, flag, id, vipFlags):
        result = {}
        result["parse"] = 0
        result["playUrl"] = ''
        result["url"] = id
        result["header"] = headerx
        return result

    def searchContent(self, key, quick, pg="1"):
        return self.searchContentPage(key, quick, '1')

    def localProxy(self, params):
        if params['type'] == "m3u8":
            return self.proxyM3u8(params)
        elif params['type'] == "media":
            return self.proxyMedia(params)
        elif params['type'] == "ts":
            return self.proxyTs(params)
        return None












