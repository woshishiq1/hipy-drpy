# coding=utf-8
# !/usr/bin/python

"""

作者 丢丢喵 内容均从互联网收集而来 仅供交流学习使用 严禁用于商业用途 请于24小时内删除
         ====================Diudiumiao====================

"""

from Crypto.Util.Padding import unpad
from Crypto.Util.Padding import pad
from urllib.parse import urlparse
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

xurl = "https://spiderscloudcn2.51111666.com"

headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.87 Safari/537.36'
          }

headerx = {
    'accept': '*/*',
    'accept-language': 'zh-CN,zh;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6',
    'cache-control': 'no-cache',
    'content-type': 'application/json',
    'origin': 'https://www.bbwwbb.com',
    'pragma': 'no-cache',
    'priority': 'u=1, i',
    'referer': 'https://www.bbwwbb.com/',
    'sec-ch-ua': '"Microsoft Edge";v="143", "Chromium";v="143", "Not A(Brand";v="24"',
    'sec-ch-ua-mobile': '?0',
    'sec-ch-ua-platform': '"Windows"',
    'sec-fetch-dest': 'empty',
    'sec-fetch-mode': 'cors',
    'sec-fetch-site': 'cross-site',
    'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36 Edg/143.0.0.0',
           }

class Spider(Spider):

    def getName(self):
        return "丢丢喵"

    def init(self, extend):
        pass

    def isVideoFormat(self, url):
        pass

    def manualVideoCheck(self):
        pass

    def homeVideoContent(self):
        pass

    def homeContent(self, filter):
        payload = self._build_home_payload()
        data = self._fetch_home_data(payload)
        result = self._parse_home_content(data)
        return result

    def _build_home_payload(self):
        return {'name': 'John','age': 31,'city': 'New York'}

    def _fetch_home_data(self, payload):
        urlz = f'{xurl}/getDataInit'
        response = requests.post(url=urlz, headers=headerx, json=payload)
        return response.json()

    def _parse_home_content(self, data):
        result = {"class": []}
        menu0_list = data['data']['menu0ListMap']
        count = min(3, len(menu0_list))
        for i in range(count):
            current_menu2_list = menu0_list[i]['menu2List']
            for vod in current_menu2_list:
                result["class"].append({"type_id": vod['typeId2'],"type_name": vod['typeName2']})
        return result

    def categoryContent(self, cid, pg, filter, ext):
        page = int(pg) if pg else 1
        payload = self._build_category_payload(cid, page)
        data = self._fetch_category_data(payload)
        videos = self._parse_category_videos(data)
        return self._format_category_result(videos, pg)

    def _build_category_payload(self, cid, page):
        return {'command': 'WEB_GET_INFO','pageNumber': page,'RecordsPage': 20,'typeId': cid,'typeMid': '1','languageType': 'CN','content': '',}

    def _fetch_category_data(self, payload):
        urlz = f'{xurl}/forward'
        response = requests.post(url=urlz, headers=headerx, json=payload)
        return response.json()

    def _parse_category_videos(self, data):
        videos = []
        for vod in data['data']['resultList']:
            videos.append({"vod_id": f"{vod['id']}@{vod['vod_server_id']}","vod_name": vod['vod_name'],"vod_pic": vod['vod_pic']})
        return videos

    def _format_category_result(self, videos, pg):
        return {'list': videos,'page': pg,'pagecount': 9999,'limit': 90,'total': 999999}

    def detailContent(self, ids):
        did = ids[0]
        fenge = self._split_did(did)
        datas = self._fetch_init_data()
        data = self._fetch_detail_data(fenge)
        bofang = self._build_bofang_string(datas, data, fenge)
        videos = [self._build_video_item(did, bofang)]
        return {"list": videos}

    def _split_did(self, did):
        return did.split("@")

    def _fetch_init_data(self):
        payloads = {'name': 'John', 'age': 31, 'city': 'New York'}
        urlz = f'{xurl}/getDataInit'
        response = requests.post(url=urlz, headers=headerx, json=payloads)
        return response.json()

    def _fetch_detail_data(self, fenge):
        payload = {'command': 'WEB_GET_INFO_DETAIL', 'type_Mid': '1', 'id': fenge[0], 'languageType': 'CN'}
        urlz = f'{xurl}/forward'
        response = requests.post(url=urlz, headers=headerx, json=payload)
        return response.json()

    def _build_bofang_string(self, datas, data, fenge):
        server_id = fenge[1]
        link_map = datas['data']['macVodLinkMap'][server_id]
        base_url = data['data']['result']['vod_url']
        return f"国内线路1${link_map['LINK_1']}{base_url}#国内线路2${link_map['LINK_2']}{base_url}#海外线路${link_map['LINK_3']}{base_url}"

    def _build_video_item(self, did, bofang):
        return {"vod_id": did, "vod_play_from": "熊猫专线", "vod_play_url": bofang}

    def playerContent(self, flag, id, vipFlags):
        result = {}
        result["parse"] = 0
        result["playUrl"] = ''
        result["url"] = id
        result["header"] = headers
        return result

    def searchContentPage(self, key, quick, pg):
        page = int(pg) if pg else 1
        payload = self._build_search_payload(key, page)
        data = self._fetch_search_data(payload)
        videos = self._parse_search_videos(data)
        return self._format_search_result(videos, pg)

    def _build_search_payload(self, key, page):
        return {'command': 'WEB_GET_INFO','pageNumber': page,'RecordsPage': 20,'typeId': '0','typeMid': '1','languageType': 'CN','content': key,'type': '1'}

    def _fetch_search_data(self, payload):
        urlz = f'{xurl}/forward'
        response = requests.post(url=urlz, headers=headerx, json=payload)
        return response.json()

    def _parse_search_videos(self, data):
        videos = []
        for vod in data['data']['resultList']:
            videos.append({"vod_id": f"{vod['id']}@{vod['vod_server_id']}","vod_name": vod['vod_name'],"vod_pic": vod['vod_pic']})
        return videos

    def _format_search_result(self, videos, pg):
        return {'list': videos,'page': pg,'pagecount': 9999,'limit': 90,'total': 999999}

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








