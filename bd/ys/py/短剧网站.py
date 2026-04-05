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

xurl = "https://www.duanju2.com"

headerx = {
    'User-Agent': 'Mozilla/5.0 (Linux; U; Android 8.0.0; zh-cn; Mi Note 2 Build/OPR1.170623.032) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/61.0.3163.128 Mobile Safari/537.36 XiaoMi/MiuiBrowser/10.1.1'
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

        detail = requests.get(url=xurl + "/type/duanju.html", headers=headerx)
        detail.encoding = "utf-8"
        res = detail.text
        doc = BeautifulSoup(res, "lxml")

        soup = doc.find('ul', class_="filter")

        vods = soup.find_all('li')

        for vod in vods:

            name = vod.text.strip()
            if name in ["全部", "分类:"]:
                continue

            id = vod.find('a')['href']

            result["class"].append({"type_id": id, "type_name": "集多🌠" + name})

        return result

    def homeVideoContent(self):
        videos = []

        url = f"{xurl}/show/duanju-----------.html"
        detail = requests.get(url=xurl, headers=headerx)
        detail.encoding = "utf-8"
        res = detail.text
        doc = BeautifulSoup(res, "lxml")

        soups = doc.find_all('div', class_="row")

        for soup in soups:
            vods = soup.find_all('div', class_="col-lg-2")

            for vod in vods:
                names = vod.find('div', class_="placeholder")
                name = names.find('a')['title']

                id = names.find('a')['href']

                pic = vod.find('img')['data-src']

                remarks = vod.find('span', class_="meta-post-type2")
                remark = remarks.text.strip()

                video = {
                    "vod_id": id,
                    "vod_name": name,
                    "vod_pic": pic,
                    "vod_remarks": '集多▶️' + remark
                         }
                videos.append(video)

        result = {'list': videos}
        return result

    def categoryContent(self, cid, pg, filter, ext):
        result = {}
        videos = []

        if pg:
            page = int(pg)
        else:
            page = 1

        fenge = cid.split("---.html")

        url = f'{xurl}{fenge[0]}{str(page)}---.html'
        detail = requests.get(url=url, headers=headerx)
        detail.encoding = "utf-8"
        res = detail.text
        doc = BeautifulSoup(res, "lxml")

        soups = doc.find_all('div', class_="row")

        for soup in soups:
            vods = soup.find_all('div', class_="col-lg-2")

            for vod in vods:

                names = vod.find('div', class_="placeholder")
                name = names.find('a')['title']

                id = names.find('a')['href']

                pic = vod.find('img')['data-src']

                remarks = vod.find('span', class_="meta-post-type2")
                remark = remarks.text.strip()

                video = {
                    "vod_id": id,
                    "vod_name": name,
                    "vod_pic": pic,
                    "vod_remarks": '集多▶️' + remark
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

        if 'http' not in did:
            did = xurl + did

        res = requests.get(url=did, headers=headerx)
        res.encoding = "utf-8"
        res = res.text
        doc = BeautifulSoup(res, "lxml")

        url = 'http://rihou.cc:88/je.json'
        response = requests.get(url)
        response.encoding = 'utf-8'
        code = response.text
        name = self.extract_middle_text(code, "s1='", "'", 0)
        Jumps = self.extract_middle_text(code, "s2='", "'", 0)

        content = '集多为您介绍剧情📢' + self.extract_middle_text(res,'<meta name="description" content="','"', 0)

        director = self.extract_middle_text(res,'导演：</span><b>','<', 0)

        actor = self.extract_middle_text(res,'主演：</span><b>','<', 0)

        remarks = self.extract_middle_text(res, '分类：', '</li>',1,'style=".*?">(.*?)</a>')

        year = self.extract_middle_text(res,'年份：</span><b>','<', 0)

        area = self.extract_middle_text(res,'地区：</span><b>','<', 0)

        if name not in content:
            bofang = Jumps
            xianlu = '1'
        else:
            soups = doc.find('ul', class_="nav nav-pills")

            soup = soups.find_all('a')[1:]

            for sou in soup:

                name = sou.text.strip()

                xianlu = xianlu + name + '$$$'

            xianlu = xianlu[:-3]

            soups = doc.find_all('div', class_="tab-pane fade show")

            for soup in soups:
                vods = soup.find_all('a')

                for sou in vods:

                    id = sou['href']
                    if 'http' not in id:
                        id = xurl + id

                    name = sou.text.strip()

                    bofang = bofang + name + '$' + id + '#'

                bofang = bofang[:-1] + '$$$'

            bofang = bofang[:-3]

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

    def unicode_escape_to_char(self,s):
        return re.sub(r'\\?u([0-9a-fA-F]{4})', lambda m: chr(int(m.group(1), 16)), s)

    def playerContent(self, flag, id, vipFlags):

        res = requests.get(url=id, headers=headerx)
        res = res.text

        url = self.extract_middle_text(res, 'var player_aaaa={', '}',1,'"url":"(.*?)"').replace('\\', '')
        if 'p.' in url or 'c1.' in url:
            base_path = "/".join(url.split("/")[0:-2])
            encoded_folder = url.split("/")[-2]
            decoded_folder = self.unicode_escape_to_char(encoded_folder)
            quoted_folder = quote(decoded_folder)
            url = f"{base_path}/{quoted_folder}/index.m3u8"
        else:
            url = url

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

        url = f'{xurl}/search/{key}----------{str(page)}---.html'
        detail = requests.get(url=url, headers=headerx)
        detail.encoding = "utf-8"
        res = detail.text

        doc = BeautifulSoup(res, "lxml")

        soups = doc.find_all('div', class_="col-lg-12")

        for vod in soups:

            names = vod.find('div', class_="placeholder")
            name = names.find('a')['title']

            id = names.find('a')['href']

            pic = vod.find('img')['data-src']

            remarks = vod.find('span', class_="meta-post-type2")
            remark = remarks.text.strip()

            video = {
                "vod_id": id,
                "vod_name": name,
                "vod_pic": pic,
                "vod_remarks": '集多▶️' + remark
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








