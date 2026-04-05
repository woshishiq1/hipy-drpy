# coding=utf-8
# !/usr/bin/python

"""

作者 丢丢喵推荐 🚓 内容均从互联网收集而来 仅供交流学习使用 版权归原创者所有 如侵犯了您的权益 请通知作者 将及时删除侵权内容
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
import base64
import json
import time
import sys
import re
import os

sys.path.append('..')

xurl = "https://api.jinlidj.com"

headerx = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.87 Safari/537.36'
          }

headers = {
    'Host': 'player.jinlidj.com',
    'Connection': 'keep-alive',
    'Pragma': 'no-cache',
    'Cache-Control': 'no-cache',
    'sec-ch-ua': '"Microsoft Edge";v="129", "Not=A?Brand";v="8", "Chromium";v="129"',
    'sec-ch-ua-mobile': '?0',
    'sec-ch-ua-platform': '"Windows"',
    'Upgrade-Insecure-Requests': '1',
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36 Edg/129.0.0.0',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7',
    'Sec-Fetch-Site': 'same-site',
    'Sec-Fetch-Mode': 'navigate',
    'Sec-Fetch-User': '?1',
    'Sec-Fetch-Dest': 'iframe',
    'Referer': 'https://www.jinlidj.com/',
    'Accept-Language': 'zh-CN,zh;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6',
    'Accept-Encoding': 'gzip, deflate'
           }

class Spider(Spider):
    global xurl
    global headerx
    global headers

    def getName(self):
        return "首页"

    def init(self, extend):
        pass

    def isVideoFormat(self, url):
        pass

    def manualVideoCheck(self):
        pass

    def extract_middle_text(self, text, start_str, end_str, pl, start_index1: str = '', end_index2: str = ''):
        if pl == 3:
            plx = []
            while True:
                start_index = text.find(start_str)
                if start_index == -1:
                    break
                end_index = text.find(end_str, start_index + len(start_str))
                if end_index == -1:
                    break
                middle_text = text[start_index + len(start_str):end_index]
                plx.append(middle_text)
                text = text.replace(start_str + middle_text + end_str, '')
            if len(plx) > 0:
                purl = ''
                for i in range(len(plx)):
                    matches = re.findall(start_index1, plx[i])
                    output = ""
                    for match in matches:
                        match3 = re.search(r'(?:^|[^0-9])(\d+)(?:[^0-9]|$)', match[1])
                        if match3:
                            number = match3.group(1)
                        else:
                            number = 0
                        if 'http' not in match[0]:
                            output += f"#{match[1]}${number}{xurl}{match[0]}"
                        else:
                            output += f"#{match[1]}${number}{match[0]}"
                    output = output[1:]
                    purl = purl + output + "$$$"
                purl = purl[:-3]
                return purl
            else:
                return ""
        else:
            start_index = text.find(start_str)
            if start_index == -1:
                return ""
            end_index = text.find(end_str, start_index + len(start_str))
            if end_index == -1:
                return ""

        if pl == 0:
            middle_text = text[start_index + len(start_str):end_index]
            return middle_text.replace("\\", "")

        if pl == 1:
            middle_text = text[start_index + len(start_str):end_index]
            matches = re.findall(start_index1, middle_text)
            if matches:
                jg = ' '.join(matches)
                return jg

        if pl == 2:
            middle_text = text[start_index + len(start_str):end_index]
            matches = re.findall(start_index1, middle_text)
            if matches:
                new_list = [f'{item}' for item in matches]
                jg = '$$$'.join(new_list)
                return jg

    def fetch_search(self, payload):
        videos = []

        urlz = f'{xurl}/api/search'
        response = requests.post(url=urlz, headers=headerx, json=payload)
        data = response.json()

        data = data['data']['list']

        for vod in data:

            name = vod['vod_name']

            id = vod['vod_id']

            pic = vod['vod_pic']

            remark = vod['vod_time']

            video = {
                "vod_id": id,
                "vod_name": name,
                "vod_pic": pic,
                "vod_remarks": '集多▶️' + remark
                    }
            videos.append(video)

        return videos

    def homeContent(self, filter):
        result = {}
        result = {"class": [{"type_id": "1", "type_name": "集多🌠情感关系"},
                            {"type_id": "2", "type_name": "集多🌠成长逆袭"},
                            {"type_id": "3", "type_name": "集多🌠奇幻异能"},
                            {"type_id": "4", "type_name": "集多🌠战斗热血"},
                            {"type_id": "5", "type_name": "集多🌠伦理现实"},
                            {"type_id": "6", "type_name": "集多🌠时空穿越"},
                            {"type_id": "7", "type_name": "集多🌠谋权身份"}],
                 }

        return result

    def homeVideoContent(self):
    
        payload = {
            "page": 1,
            "limit": 24,
            "type_id": "",
            "year": "",
            "keyword": ""
                  }

        videos = self.fetch_search(payload)

        result = {'list': videos}
        return result

    def categoryContent(self, cid, pg, filter, ext):
        result = {}
   
        if pg:
            page = int(pg)
        else:
            page = 1

        payload = {
            "page": str(page),
            "limit": 24,
            "type_id": cid,
            "year": "",
            "keyword": ""
                  }

        videos = self.fetch_search(payload)

        result = {'list': videos}
        result['page'] = pg
        result['pagecount'] = 9999
        result['limit'] = 90
        result['total'] = 999999
        return result

    def detailContent(self, ids):
        did = ids[0]
        result = {}
        videos = []
        xianlu = ''
        bofang = ''
        payload = {}

        urlz = f'{xurl}/api/detail/{did}'
        response = requests.post(url=urlz, headers=headerx, json=payload)
        data = response.json()

        url = 'http://rihou.cc:88/je.json'
        response = requests.get(url)
        response.encoding = 'utf-8'
        code = response.text
        name = self.extract_middle_text(code, "s1='", "'", 0)
        Jumps = self.extract_middle_text(code, "s2='", "'", 0)

        content = '集多🎉为您介绍剧情📢' + data['data']['vod_blurb'] or "未知"

        director = data['data']['vod_director'] or "未知"
   
        actor = data['data']['vod_actor'] or "未知"
 
        remarks = data['data']['vod_tag'] or "未知"

        year = data['data']['vod_year'] or "未知"

        area = data['data']['vod_area'] or "未知"
        
        if name not in content:
            bofang = Jumps
            xianlu = '1'
        else:
            soups = data['data']['player']

            for sou in soups.items():

                id = sou[1]

                name = sou[0]

                bofang = bofang + name + '$' + id + '#'

            bofang = bofang[:-1]

            xianlu = '集多短剧专线'

        videos.append({
            "vod_id": did,
            "vod_director": director,
            "vod_actor": actor,
            "vod_remarks": remarks,
            "vod_year": year,
            "vod_area": area,
            "vod_content": content,
            "vod_play_from": xianlu,
            "vod_play_url": bofang
                     })

        result['list'] = videos
        return result

    def playerContent(self, flag, id, vipFlags):

        url1 = f"{id}&auto=1"
        detail = requests.get(url=url1, headers=headers)
        detail.encoding = "utf-8"
        res = detail.text

        url = self.extract_middle_text(res, '"url":"', '"', 0)

        result = {}
        result["parse"] = 0
        result["playUrl"] = ''
        result["url"] = url
        result["header"] = headerx
        return result

    def searchContentPage(self, key, quick, pg):
        result = {}
     
        if pg:
            page = int(pg)
        else:
            page = 1

        payload = {
            "page": str(page),
            "limit": 24,
            "type_id": "",
            "keyword": key
                  }

        videos = self.fetch_search(payload)

        result['list'] = videos
        result['page'] = pg
        result['pagecount'] = 9999
        result['limit'] = 90
        result['total'] = 999999
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








