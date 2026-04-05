# coding = utf-8
# !/usr/bin/python

"""

作者 丢丢喵推荐 🚓 内容均从互联网收集而来 仅供交流学习使用 版权归原创者所有 如侵犯了您的权益 请通知作者 将及时删除侵权内容
                    ====================Diudiumiao====================

"""

from Crypto.Util.Padding import unpad
from urllib.parse import unquote
from Crypto.Cipher import ARC4
from urllib.parse import quote
from base.spider import Spider
from Crypto.Cipher import AES
from bs4 import BeautifulSoup
from base64 import b64decode
import urllib.request
import urllib.parse
import binascii
import requests
import base64
import json
import time
import sys
import re
import os

sys.path.append('..')

xurl = "https://ptt.red"

headerx = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.87 Safari/537.36'
          }

pm = ''

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
        result = {}
        result = {"class": [{"type_id": "67", "type_name": "集多🌠爽剧"},
                            {"type_id": "68", "type_name": "集多🌠言情"},
                            {"type_id": "70", "type_name": "集多🌠穿越"},
                            {"type_id": "71", "type_name": "集多🌠悬疑"},
                            {"type_id": "73", "type_name": "集多🌠古装"},
                            {"type_id": "80", "type_name": "集多🌠都市"},
                            {"type_id": "84", "type_name": "集多🌠甜宠"},
                            {"type_id": "85", "type_name": "集多🌠恋爱"},
                            {"type_id": "74", "type_name": "集多🌠其他"}],

                  "list": [],
                  "filters": {"67": [{"key": "年代",
                                     "name": "年代",
                                     "value": [{"n": "全部", "v": ""},
                                               {"n": "2025", "v": "2025"},
                                               {"n": "2024", "v": "2024"},
                                               {"n": "2023", "v": "2023"},
                                               {"n": "2022", "v": "2022"},
                                               {"n": "2021", "v": "2021"},
                                               {"n": "2020", "v": "2020"},
                                               {"n": "2019", "v": "2019"},
                                               {"n": "2018", "v": "2018"}]}],
                              "68": [{"key": "年代",
                                     "name": "年代",
                                     "value": [{"n": "全部", "v": ""},
                                               {"n": "2025", "v": "2025"},
                                               {"n": "2024", "v": "2024"},
                                               {"n": "2023", "v": "2023"},
                                               {"n": "2022", "v": "2022"},
                                               {"n": "2021", "v": "2021"},
                                               {"n": "2020", "v": "2020"},
                                               {"n": "2019", "v": "2019"},
                                               {"n": "2018", "v": "2018"}]}],
                              "70": [{"key": "年代",
                                     "name": "年代",
                                     "value": [{"n": "全部", "v": ""},
                                               {"n": "2025", "v": "2025"},
                                               {"n": "2024", "v": "2024"},
                                               {"n": "2023", "v": "2023"},
                                               {"n": "2022", "v": "2022"},
                                               {"n": "2021", "v": "2021"},
                                               {"n": "2020", "v": "2020"},
                                               {"n": "2019", "v": "2019"},
                                               {"n": "2018", "v": "2018"}]}],
                              "71": [{"key": "年代",
                                     "name": "年代",
                                     "value": [{"n": "全部", "v": ""},
                                               {"n": "2025", "v": "2025"},
                                               {"n": "2024", "v": "2024"},
                                               {"n": "2023", "v": "2023"},
                                               {"n": "2022", "v": "2022"},
                                               {"n": "2021", "v": "2021"},
                                               {"n": "2020", "v": "2020"},
                                               {"n": "2019", "v": "2019"},
                                               {"n": "2018", "v": "2018"}]}],
                              "73": [{"key": "年代",
                                     "name": "年代",
                                     "value": [{"n": "全部", "v": ""},
                                               {"n": "2025", "v": "2025"},
                                               {"n": "2024", "v": "2024"},
                                               {"n": "2023", "v": "2023"},
                                               {"n": "2022", "v": "2022"},
                                               {"n": "2021", "v": "2021"},
                                               {"n": "2020", "v": "2020"},
                                               {"n": "2019", "v": "2019"},
                                               {"n": "2018", "v": "2018"}]}],
                              "80": [{"key": "年代",
                                      "name": "年代",
                                      "value": [{"n": "全部", "v": ""},
                                                {"n": "2025", "v": "2025"},
                                                {"n": "2024", "v": "2024"},
                                                {"n": "2023", "v": "2023"},
                                                {"n": "2022", "v": "2022"},
                                                {"n": "2021", "v": "2021"},
                                                {"n": "2020", "v": "2020"},
                                                {"n": "2019", "v": "2019"},
                                                {"n": "2018", "v": "2018"}]}],
                              "84": [{"key": "年代",
                                      "name": "年代",
                                      "value": [{"n": "全部", "v": ""},
                                                {"n": "2025", "v": "2025"},
                                                {"n": "2024", "v": "2024"},
                                                {"n": "2023", "v": "2023"},
                                                {"n": "2022", "v": "2022"},
                                                {"n": "2021", "v": "2021"},
                                                {"n": "2020", "v": "2020"},
                                                {"n": "2019", "v": "2019"},
                                                {"n": "2018", "v": "2018"}]}],
                              "85": [{"key": "年代",
                                      "name": "年代",
                                      "value": [{"n": "全部", "v": ""},
                                                {"n": "2025", "v": "2025"},
                                                {"n": "2024", "v": "2024"},
                                                {"n": "2023", "v": "2023"},
                                                {"n": "2022", "v": "2022"},
                                                {"n": "2021", "v": "2021"},
                                                {"n": "2020", "v": "2020"},
                                                {"n": "2019", "v": "2019"},
                                                {"n": "2018", "v": "2018"}]}],
                              "74": [{"key": "年代",
                                     "name": "年代",
                                     "value": [{"n": "全部", "v": ""},
                                               {"n": "2025", "v": "2025"},
                                               {"n": "2024", "v": "2024"},
                                               {"n": "2023", "v": "2023"},
                                               {"n": "2022", "v": "2022"},
                                               {"n": "2021", "v": "2021"},
                                               {"n": "2020", "v": "2020"},
                                               {"n": "2019", "v": "2019"},
                                               {"n": "2018", "v": "2018"}]}]}}

        return result

    def homeVideoContent(self):
        videos = []

        try:
            detail = requests.get(url=xurl + "/p/66", headers=headerx)
            detail.encoding = "utf-8"
            res = detail.text

            doc = BeautifulSoup(res, "lxml")

            soups = doc.find_all('div', class_="row")

            for soup in soups:
                vods = soup.find_all('div', class_="col-xl-2")

                for vod in vods:
                    names = vod.find('div', class_="lines")
                    name = names.find('a').text

                    ids = vod.find('div', class_="embed-responsive")
                    id = ids.find('a')['href']

                    pic = vod.find('img')['src']

                    if 'http' not in pic:
                        pic = xurl + pic

                    remarks = vod.find('div', class_="imagelabel")
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
        except:
            pass

    def categoryContent(self, cid, pg, filter, ext):
        result = {}
        videos = []

        if pg:
            page = int(pg)
        else:
            page = 1

        if '年代' in ext.keys():
            NdType = ext['年代']
        else:
            NdType = ''

        if page == 1:
            url = f'{xurl}/p/66/c/{cid}'

        else:
            url = f'{xurl}/p/66/c/{cid}?year={NdType}&page={str(page)}'

        try:
            detail = requests.get(url=url, headers=headerx)
            detail.encoding = "utf-8"
            res = detail.text
            doc = BeautifulSoup(res, "lxml")

            soups = doc.find_all('div', class_="row")

            for soup in soups:
                vods = soup.find_all('div', class_="col-xl-2")

                for vod in vods:
                    names = vod.find('div', class_="lines")
                    name = names.find('a').text

                    ids = vod.find('div', class_="embed-responsive")
                    id = ids.find('a')['href']

                    pic = vod.find('img')['src']

                    if 'http' not in pic:
                        pic = xurl + pic

                    remarks = vod.find('div', class_="imagelabel")
                    remark = remarks.text.strip()

                    video = {
                        "vod_id": id,
                        "vod_name": name,
                        "vod_pic": pic,
                        "vod_remarks": '集多▶️' + remark
                            }
                    videos.append(video)

        except:
            pass
        result = {'list': videos}
        result['page'] = pg
        result['pagecount'] = 9999
        result['limit'] = 90
        result['total'] = 999999
        return result

    def detailContent(self, ids):
        global pm
        did = ids[0]
        result = {}
        videos = []

        if 'http' not in did:
            did = xurl + did

        res = requests.get(url=did, headers=headerx)
        res.encoding = "utf-8"
        res = res.text

        url = 'http://rihou.cc:88/je.json'
        response = requests.get(url)
        response.encoding = 'utf-8'
        code = response.text
        name = self.extract_middle_text(code, "s1='", "'", 0)
        Jumps = self.extract_middle_text(code, "s2='", "'", 0)

        content = '集多🎉为您介绍剧情📢' + self.extract_middle_text(res,'劇情介紹</h3>','</p>', 0)

        content = content.replace('<p>', '').replace(' ', '')

        actor = self.extract_middle_text(res, '領銜主演</h3>', '<h3 class="mt-3">',1,'href=".*?">(.*?)</a>')

        remarks = self.extract_middle_text(res, '狀態</th><td>', '</td>', 0)

        year = self.extract_middle_text(res, '年代</th><td>', '</td>', 0)

        area = self.extract_middle_text(res, '>國家</th><td>', '</td>', 0)

        if name not in content:
            bofang = Jumps
        else:
            if '/p/1' in res or '/p/53' in res:
                doc = BeautifulSoup(res, "lxml")
                soups = doc.find('div', class_="col-5")
                bofang = soups.find('a')['href']
                if 'http' not in bofang:
                    bofang = xurl + bofang

            else:
                bofang = self.extract_middle_text(res, '<div class="seqs mb-4">', '</div>', 3,'href="(.*?)">(.*?)</a>')

        videos.append({
            "vod_id": did,
            "vod_actor": actor,
            "vod_remarks": remarks,
            "vod_year": year,
            "vod_area": area,
            "vod_content": content,
            "vod_play_from": "请观看",
            "vod_play_url": bofang
                     })

        result['list'] = videos
        return result

    def playerContent(self, flag, id, vipFlags):
        parts = id.split("http")

        xiutan = 0

        if xiutan == 0:
            if len(parts) > 1:
                before_https, after_https = parts[0], 'http' + parts[1]

            if '/tp/jd.m3u8' in after_https:
                url = after_https
            else:
                res = requests.get(url=after_https, headers=headerx)
                res = res.text

                url = self.extract_middle_text(res, '"contentUrl":"', '"', 0).replace('\\', '')

            result = {}
            result["parse"] = xiutan
            result["playUrl"] = ''
            result["url"] = url
            result["header"] = headerx
            return result

    def searchContentPage(self, key, quick, page):
        result = {}
        videos = []

        if not page:
            page = '1'
        if page == '1':
            url = f'{xurl}/node/search?title={key}'

        else:
            url = f'{xurl}/q/{key}?page={str(page)}'

        detail = requests.get(url=url, headers=headerx)
        detail.encoding = "utf-8"
        res = detail.text
        doc = BeautifulSoup(res, "lxml")

        soups = doc.find_all('div', class_="row")

        for soup in soups:
            vods = soup.find_all('div', class_="col-xl-2")

            for vod in vods:
                names = vod.find('div', class_="lines")
                name = names.find('a').text

                ids = vod.find('div', class_="embed-responsive")
                id = ids.find('a')['href']

                pic = vod.find('img')['src']

                if 'http' not in pic:
                    pic = xurl + pic

                remarks = vod.find('div', class_="imagelabel")
                remark = remarks.text.strip()

                video = {
                    "vod_id": id,
                    "vod_name": name,
                    "vod_pic": pic,
                    "vod_remarks": '集多▶️' + remark
                        }
                videos.append(video)

        result['list'] = videos
        result['page'] = page
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









