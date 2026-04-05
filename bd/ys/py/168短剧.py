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

xurl = "https://www.xzyx168.com"

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
        max_retries = 5
        retry_count = 0

        while retry_count < max_retries:
            try:
                detail = requests.get(url=xurl + "/xzyxvt/duanjun.html", headers=headerx, timeout=5)
                detail.encoding = "utf-8"
                res = detail.text

                doc = BeautifulSoup(res, "lxml")
                soups = doc.find_all('h3', class_="2p4d8xbkrf")

                for vod in soups:
                    name_tag = vod.find('a')
                    if not name_tag:
                        continue

                    name = name_tag['title']
                    if "都市短剧" in name:
                        continue

                    id = name_tag['href']
                    result["class"].append({"type_id": id, "type_name": "集多🌠" + name})

                return result
            except requests.exceptions.ConnectionError as e:
                retry_count += 1
                if retry_count < max_retries:
                    time.sleep(1)
                else:
                    return result

    def homeVideoContent(self):
        videos = []

        detail = requests.get(url=xurl + "/xzyxvt/duanjun.html", headers=headerx)
        detail.encoding = "utf-8"
        res = detail.text

        doc = BeautifulSoup(res, "lxml")

        soups = doc.find_all('div', class_="fb4c0sv0wd")

        for soup in soups:
            vods = soup.find_all('a')

            for vod in vods:

                name = vod['title']

                id = vod['href']

                pic = vod['data-original']

                remark = "欢迎观看"

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

        fenge = cid.split("zmn")
        url = f'{xurl}{fenge[0]}{str(page)}zmn.html'

        retries = 5
        for attempt in range(retries):
            try:
                detail = requests.get(url=url, headers=headerx, timeout=5)
                detail.encoding = "utf-8"
                res = detail.text
                doc = BeautifulSoup(res, "lxml")
                soups = doc.find_all('a', class_="hwkltcii1l")

                for vod in soups:
                    name = vod['title']
                    id = vod['href']
                    pic = vod['data-original']

                    remarks = vod.find('span', class_="acd47d1yrm")
                    remark = remarks.text.strip() if remarks else ''

                    video = {
                        "vod_id": id,
                        "vod_name": name,
                        "vod_pic": pic,
                        "vod_remarks": '集多️▶️' + remark
                            }
                    videos.append(video)

                result = {'list': videos}
                result['page'] = pg
                result['pagecount'] = 9999
                result['limit'] = 90
                result['total'] = 999999
                return result

            except requests.exceptions.SSLError as e:
                if attempt < retries - 1:
                    time.sleep(1)
                else:
                    return {'list': []}

            except Exception as e:
                return {'list': []}

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

        content = '集多为您介绍剧情📢' + self.extract_middle_text(res,'简介：</span>','<', 0)
        content = content.replace('\n', '').replace(' ', '')

        director = self.extract_middle_text(res,'导演：</span>','<', 0)

        actor = self.extract_middle_text(res,'主演：</span>','<', 0)

        remarks = self.extract_middle_text(res,'类型：</span>','<', 0)

        year = self.extract_middle_text(res,'年份：</span>','<', 0)

        area = self.extract_middle_text(res, '地区：</span>', '<', 0)

        if name not in content:
            bofang = Jumps
            xianlu = '1'
        else:
            soups = doc.find('div', class_="9ahntuoroa")

            soup = soups.find_all('li')

            for sou in soup:

                id = sou.find('a')['href']

                if 'http' not in id:
                    id = xurl + id

                name = sou.find('a')['title']

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

        res = requests.get(url=id, headers=headerx)
        res.encoding = "utf-8"
        res = res.text

        url = self.extract_middle_text(res, '},"url":"', '"', 0).replace('\\', '')

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

        url = f'{xurl}/xzyxvc/{key}-wdyswzqun{str(page)}num.html'

        detail = requests.get(url=url, headers=headerx)
        detail.encoding = "utf-8"
        res = detail.text

        doc = BeautifulSoup(res, "lxml")

        soups = doc.find_all('div', class_="vgl7lerf3f")

        for item in soups:
            vods = item.find_all('li')

            for vod in vods:
                names = vod.find('a', class_="9jlvu7xrw1")
                name = names['title']

                id = names['href']

                pic = names['data-original']

                remarks = vod.find('span', class_="ni1pgkjbk7")
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







