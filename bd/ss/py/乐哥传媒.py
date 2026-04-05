# coding=utf-8
# !/usr/bin/python

"""

作者 丢丢喵 🚓 内容均从互联网收集而来 仅供交流学习使用 版权归原创者所有 如侵犯了您的权益 请通知作者 将及时删除侵权内容
                    ====================Diudiumiao====================

"""

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
import urllib.request
import urllib.parse
import datetime
import binascii
import requests
import hashlib
import base64
import json
import time
import sys
import re
import os

sys.path.append('..')

xurl = "https://www.r5nu.com"

headerx = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.87 Safari/537.36'
          }

class Spider(Spider):
    global xurl
    global headerx

    def getName(self):
        return "首页"

    def init(self, extend):
        pass

    def isVideoFormat(self, url):
        pass

    def manualVideoCheck(self):
        pass

    def generate_signature_params(self, payload):
        SECRET_KEY = "s5dVVmAyt75nCrHPAdV2y1i+koJNaxh6jNTkiKgSSurRQDJSt4AH7Z8GawIF92Tc"
        t = str(int(time.time() * 1000))
        signature_s = hashlib.md5((t + SECRET_KEY).encode('utf-8')).hexdigest()
        final_params = payload.copy()
        final_params['t'] = t
        final_params['s'] = signature_s
        return final_params

    def homeContent(self, filter):
        result = {"class": []}
        menu_data = self.fetch_menu_data()
        result["class"] = self.parse_menu_data(menu_data)
        return result

    def fetch_menu_data(self):
        payload = {
            'action': 'getmenu',
            'vtype': '',
            'index': '-1',
            'state': '0',
            'ttt': '',
            'p': ''
                  }
        final_params = self.generate_signature_params(payload)
        urlz = f'{xurl}/web/abcdefg.ashx'
        response = requests.post(url=urlz, headers=headerx, data=final_params)
        res = response.text
        return res

    def parse_menu_data(self, html_content):
        doc = BeautifulSoup(html_content, "lxml")
        soups = doc.find_all('div', class_="head_bottom")[:2]
        class_list = []
        for soup in soups:
            vods = soup.find_all('li')
            for vod in vods:
                name = self.process_category_name(vod.text.strip())
                id = self.process_category_id(vod['onclick'])
                class_list.append({"type_id": id, "type_name": name})
        return class_list

    def process_category_name(self, name):
        replacements = {
            'npiik685Lck0FDMUZdiEww==': '亚洲无码',
            's/1sDU0O4YiSQcOWSJSU0w==': '欧美无码',
            'DwciqD3gIgL7nw/s7sILpA==': '中文字幕',
            'w3MG36tpsp7Q2laGGkz8/w==': '经典三级',
            'QlWqEFTdBnS7fJE2QeRWPA==': '国产主播',
            'QWTsC1myBO2tSCLQ/sEnew==': '韩国主播',
            'gN2L7RnWjEzBfcovmlSAmQ==': 'ＡＳＭＲ',
            '8KibIBlYoyvWx9DCZhxk2w==': '恐怖色情',
            '1BnJg5tSsn5AM2C07wItyA==': '网红视频',
            'CCNquvXakHIecCOudFO8yg==': '国产视频',
            'sUaKzVcQ5ehvRZ3kt27KAQ==': '人妖伪娘',
            'B5RKLzIG+WCEscBNxlwr+A==': '动漫卡通',
            'WBm+mcc3ZOug3T/VO4KxRA==': '华人原创',
            'nA3l008NjTxmTW+BuW5pOQ==': 'ＪＶＩＤ',
            'eRP3JFAXTQwWoiTAu95jeA==': 'ＳＷＡＧ',
            'fGfFjWIpFa1ughCZLhAf9w==': '明星换脸'
                       }
        for old, new in replacements.items():
            name = name.replace(old, new)
        return name

    def process_category_id(self, onclick_value):
        id = onclick_value.replace("toLinkpage('video-", '').replace(".html');", '').replace("duanpian-", '')
        return id

    def homeVideoContent(self):
        pass

    def categoryContent(self, cid, pg, filter, ext):
        page = self.process_page_number(pg)
        payload = self.build_category_payload(cid, page)
        data = self.fetch_category_data(payload)
        videos = self.parse_video_list(data)
        result = self.build_category_result(videos, pg)
        return result

    def process_page_number(self, pg):
        if pg:
            return int(pg)
        else:
            return 1

    def build_category_payload(self, cid, page):
        payload = {
            'action': 'getvideos',
            'vtype': cid,
            'pageindex': str(page),
            'pagesize': '12',
            'tags': '全部',
            'sortindex': '1'
                  }
        return payload

    def fetch_category_data(self, payload):
        final_params = self.generate_signature_params(payload)
        timestamp = int(time.time() * 1000)
        urlz = f'{xurl}/web/abcdefg.ashx?v={timestamp}'
        detail = requests.post(url=urlz, headers=headerx, data=final_params)
        detail.encoding = "utf-8"
        return detail.json()

    def parse_video_list(self, data):
        videos = []
        for vod in data['videos']:
            name = vod['title']
            id = vod['vurl']
            pic = vod['coverimg']
            remark = vod['updatedate']
            video = {
                "vod_id": id,
                "vod_name": name,
                "vod_pic": pic,
                "vod_remarks": remark
                    }
            videos.append(video)
        return videos

    def build_category_result(self, videos, pg):
        result = {
            'list': videos,
            'page': pg,
            'pagecount': 9999,
            'limit': 90,
            'total': 999999
                 }
        return result

    def detailContent(self, ids):
        did = ids[0]
        videos = self.build_video_details(did)
        result = self.build_detail_result(videos)
        return result

    def build_video_details(self, did):
        videos = []
        videos.append({
            "vod_id": did,
            "vod_play_from": "在线观看",
            "vod_play_url": did
                      })
        return videos

    def build_detail_result(self, videos):
        result = {
            'list': videos
                 }
        return result

    def _is_url_valid(self, url: str, headers: dict, timeout: int = 1) -> bool:
        try:
            detail = requests.get(url=url, headers=headerx, timeout=timeout)
            return detail.status_code == 200 and bool(detail.text.strip())
        except requests.exceptions.RequestException:
            return False

    def _find_valid_url(self, id: str, url_templates: list, headers: dict) -> str:
        for template in url_templates:
            url = template.format(id)
            if self._is_url_valid(url, headers):
                return url
        return url_templates[-1].format(id)

    def playerContent(self, flag, id, vipFlags):
        encoded_id = self.encode_video_id(id)
        url_template_map = self.get_url_template_map()
        final_id = self.find_valid_play_url(encoded_id, url_template_map)
        result = self.build_player_result(final_id)
        return result

    def encode_video_id(self, id):
        return quote(id, safe='/.')

    def get_url_template_map(self):
        return {
            'yazhouwuma': ['https://3x1.lv99t.com/changpian{}', 'https://2x1.lv99t.com/changpian{}',
                           'https://1x1.lv99t.com/changpian{}'],
            'oumeiwuma': ['https://3x1.lv99t.com/changpian{}', 'https://2x1.lv99t.com/changpian{}',
                          'https://1x1.lv99t.com/changpian{}'],
            'zhongwenzimu': ['https://3x1.lv99t.com/changpian{}', 'https://2x1.lv99t.com/changpian{}',
                             'https://1x1.lv99t.com/changpian{}'],
            'jingdiansanji': ['https://3x1.lv99t.com/changpian{}', 'https://2x1.lv99t.com/changpian{}',
                              'https://1x1.lv99t.com/changpian{}'],
            'guochanzhubo': ['https://1x1.lv99t.com/changpian{}', 'https://2x1.lv99t.com/changpian{}',
                             'https://3x1.lv99t.com/changpian{}'],
            'hanguozhubo': ['https://3x1.lv99t.com/changpian{}', 'https://2x1.lv99t.com/changpian{}',
                            'https://1x1.lv99t.com/changpian{}'],
            'asmr': ['https://3x1.lv99t.com/changpian{}', 'https://2x1.lv99t.com/changpian{}',
                     'https://1x1.lv99t.com/changpian{}'],
            'kongbu': ['https://3x1.lv99t.com/changpian{}', 'https://2x1.lv99t.com/changpian{}',
                       'https://1x1.lv99t.com/changpian{}'],
            'zhubo': ['https://1x2.lv99t.com{}', 'https://2x2.lv99t.com{}',
                       'https://3x2.lv99t.com{}'],
            'katong': ['https://3x2.lv99t.com{}', 'https://2x2.lv99t.com{}',
                      'https://1x2.lv99t.com{}'],
            'wanghongshipin': ['https://3x1.lv99t.com/duanpian{}', 'https://2x1.lv99t.com/duanpian{}',
                               'https://1x1.lv99t.com/duanpian{}'],
            'biantairenyao': ['https://3x1.lv99t.com/duanpian{}', 'https://2x1.lv99t.com/duanpian{}',
                              'https://1x1.lv99t.com/duanpian{}'],
            'weiniang': ['https://3x1.lv99t.com/duanpian{}', 'https://2x1.lv99t.com/duanpian{}',
                         'https://1x1.lv99t.com/duanpian{}'],
            'huaren': ['https://3x1.lv99t.com/duanpian{}', 'https://2x1.lv99t.com/duanpian{}',
                       'https://1x1.lv99t.com/duanpian{}'],
            'jvid': ['https://3x1.lv99t.com/duanpian{}', 'https://2x1.lv99t.com/duanpian{}',
                     'https://1x1.lv99t.com/duanpian{}'],
            'swag': ['https://2x1.lv99t.com/duanpian{}', 'https://1x1.lv99t.com/duanpian{}',
                     'https://3x1.lv99t.com/duanpian{}'],
            'AI': ['https://3x1.lv99t.com/duanpian{}', 'https://2x1.lv99t.com/duanpian{}',
                   'https://1x1.lv99t.com/duanpian{}'],
                 }

    def find_valid_play_url(self, id, url_template_map):
        final_id = id
        for type_name, templates in url_template_map.items():
            if type_name in id:
                final_id = self._find_valid_url(id, templates, headers=headerx)
                break
        return final_id

    def build_player_result(self, final_id):
        result = {
            "parse": 0,
            "playUrl": '',
            "url": final_id,
            "header": headerx
                 }
        return result

    def searchContentPage(self, key, quick, pg):
        pass

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








