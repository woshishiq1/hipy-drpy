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
import base64
import json
import time
import sys
import re
import os

sys.path.append('..')

xurl = "https://fy-musicbox-api.mu-jie.cc"

headerx = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.87 Safari/537.36'
          }

headers = {
    'accept': '*/*',
    'accept-encoding': 'gzip, deflate, br, zstd',
    'accept-language': 'zh-CN,zh;q=0.9',
    'cache-control': 'no-cache',
    'origin': 'https://mu-jie.cc',
    'pragma': 'no-cache',
    'priority': 'u=1, i',
    'referer': 'https://mu-jie.cc/',
    'sec-ch-ua': '"Microsoft Edge";v="129", "Not=A?Brand";v="8", "Chromium";v="129"',
    'sec-ch-ua-mobile': '?0',
    'sec-ch-ua-platform': '"Windows"',
    'sec-fetch-dest': 'empty',
    'sec-fetch-mode': 'cors',
    'sec-fetch-site': 'same-site',
    'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36 Edg/129.0.0.0'
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

    def homeContent(self, filter):
        result = {"class": []}

        url = f'{xurl}/getPlaylistCategory'
        detail = requests.get(url=url, headers=headers)
        detail.encoding = "utf-8"
        data = detail.json()

        data = data[0]['category'][2]['sub']

        for vod in data:

            name = vod['name']

            id = vod['id']
            id = quote(id, encoding='utf-8')

            result["class"].append({"type_id": id, "type_name": name})

        return result

    def homeVideoContent(self):
        pass

    def categoryContent(self, cid, pg, filter, ext):
        result = {}
        videos = []

        url = f'{xurl}/netease/playlist/category?type={cid}&limit=60'
        detail = requests.get(url=url, headers=headers)
        detail.encoding = "utf-8"
        data = detail.json()

        for vod in data:

            name = vod['name']

            id = vod['id']

            pic = vod['coverImgUrl']

            remark = int(vod['playCount'])

            video = {
                "vod_id": id,
                "vod_name": name,
                "vod_pic": pic,
                "vod_remarks": '集多▶️播放量' + str(remark)
                    }
            videos.append(video)

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

        if '搜索专线' not in did:
            url = f'{xurl}/meting/?server=netease&type=playlist&id={did}'
            detail = requests.get(url=url, headers=headers)
            detail.encoding = "utf-8"
            data = detail.json()

            url = 'http://rihou.cc:88/je.json'
            response = requests.get(url)
            response.encoding = 'utf-8'
            code = response.text
            name = self.extract_middle_text(code, "s1='", "'", 0)
            Jumps = self.extract_middle_text(code, "s2='", "'", 0)

            content = '集多为您介绍剧情📢' + data['description']

            if name not in content:
                bofang = Jumps
                xianlu = '1'
            else:
                data = data['tracks']

                for sou in data:

                    id = sou['url']

                    name1 = sou['artist'].replace('$$', '')
                    name2 = sou['name']
                    name = name2 + ' ' + name1

                    bofang = bofang + name + '$' + id + '#'

                bofang = bofang[:-1]

                xianlu = '集多音乐专线'

            videos.append({
                "vod_id": did,
                "vod_content": content,
                "vod_play_from": xianlu,
                "vod_play_url": bofang
                         })

        else:
            fenge = did.split("@")

            bofang = fenge[0]

            xianlu = '集多搜索专线'

            videos.append({
                "vod_id": did,
                "vod_play_from": xianlu,
                "vod_play_url": bofang
                          })

        result['list'] = videos
        return result

    def playerContent(self, flag, id, vipFlags):

        response = requests.get(url=id, headers=headers, allow_redirects=False)
        if response.status_code == 302:
            url = response.headers.get('Location')

        result = {}
        result["parse"] = 0
        result["playUrl"] = ''
        result["url"] = url
        result["header"] = headerx
        return result

    def searchContentPage(self, key, quick, pg):
        result = {}
        videos = []

        if pg:
            page = int(pg)
        else:
            page = 1

        url = f'{xurl}/netease/search/song/?keywords={key}&pn={str(page)}&limit=20'
        detail = requests.get(url=url, headers=headers)
        detail.encoding = "utf-8"
        data = detail.json()

        for sou in data:

            name1 = sou['artist'].replace('$$', '')
            name2 = sou['name']
            name = name2 + ' ' + name1

            id = sou['url'] + '@搜索专线'

            pic = sou['pic']

            remark = "推荐"

            video = {
                "vod_id": id,
                "vod_name": name,
                "vod_pic": pic,
                "vod_remarks": remark
                    }
            videos.append(video)

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








