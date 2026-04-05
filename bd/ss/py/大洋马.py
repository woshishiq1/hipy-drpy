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

xurl = "https://pornlax.com"

headerx = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.87 Safari/537.36'
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

    def searchContentPage(self, key, quick, pg):
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
        res = self.get_response()
        doc = self.parse_response(res)
        soups = self.find_sugg_divs(doc)
        self.process_soups(soups, result)
        return result

    def get_response(self):
        detail = requests.get(url=xurl, headers=headerx)
        detail.encoding = "utf-8"
        return detail.text

    def parse_response(self, res):
        return BeautifulSoup(res, "lxml")

    def find_sugg_divs(self, doc):
        return doc.find_all('div', class_="sugg")

    def process_soups(self, soups, result):
        for soup in soups:
            self.process_single_soup(soup, result)

    def process_single_soup(self, soup, result):
        vods = self.find_links(soup)
        self.process_vods(vods, result)

    def find_links(self, soup):
        return soup.find_all('a')

    def process_vods(self, vods, result):
        for vod in vods:
            self.extract_and_append(vod, result)

    def extract_and_append(self, vod, result):
        name = vod.text.strip()
        id = vod['href']
        result["class"].append({"type_id": id, "type_name": name})

    def categoryContent(self, cid, pg, filter, ext):
        page = self.get_page_number(pg)
        data = self.build_request_data(cid, page)
        res = self.send_post_request(data)
        doc = self.parse_html(res)
        soups = self.find_video_divs(doc)
        videos = self.process_video_divs(soups)
        return self.build_result(videos, pg)

    def get_page_number(self, pg):
        return int(pg) if pg else 1

    def build_request_data(self, cid, page):
        fenge = cid.split("videos/")
        return {'mix': 'video-next3','value': fenge[1],'page': str(page),}

    def send_post_request(self, data):
        detail = requests.post('https://pornlax.com/hash-pornlax', headers=headerx, data=data)
        detail.encoding = "utf-8"
        return detail.text

    def parse_html(self, res):
        return BeautifulSoup(res, "lxml")

    def find_video_divs(self, doc):
        return doc.find_all('div', class_="prev")

    def process_video_divs(self, soups):
        videos = []
        for vod in soups:
            video = self.extract_video_info(vod)
            videos.append(video)
        return videos

    def extract_video_info(self, vod):
        names = vod.find('div', class_="name")
        name = names.text.strip()
        id = vod.find('a')['href']
        pic = vod.find('img')['src']
        remarks = vod.find('div', class_="info")
        remark = remarks.text.strip() if remarks else ""
        return {"vod_id": id,"vod_name": name,"vod_pic": pic,"vod_remarks": remark}

    def build_result(self, videos, pg):
        result = {'list': videos}
        result['page'] = pg
        result['pagecount'] = 9999
        result['limit'] = 90
        result['total'] = 999999
        return result

    def detailContent(self, ids):
        did = ids[0]
        data = self.build_detail_data(did)
        res = self.get_iframe_response(data)
        cond = self.extract_middle_text(res, 'src="', '"', 0)
        res = self.get_player_response(cond)
        matches = self.extract_play_info(res)
        bofang = self.build_play_string(matches)
        videos = self.build_video_list(did, bofang)
        result = self.build_detail_result(videos)
        return result

    def build_detail_data(self, did):
        fenge = did.split("/")
        return {'mix': 'moviesiframe2','num': fenge[2],}

    def get_iframe_response(self, data):
        detail = requests.post('https://pornlax.com/hash-pornlax', headers=headerx, data=data)
        detail.encoding = "utf-8"
        return detail.text

    def get_player_response(self, cond):
        detail = requests.get(url=cond, headers=headerx)
        detail.encoding = "utf-8"
        return detail.text

    def extract_play_info(self, res):
        pattern = re.compile(r"html:\s*'(.*?)'.*?url:\s*'(.*?)'", re.DOTALL)
        return pattern.findall(res)

    def build_play_string(self, matches):
        bofang = ''
        for name, id in matches:
            bofang = bofang + name + '$' + id + '#'
        return bofang[:-1]

    def build_video_list(self, did, bofang):
        return [{"vod_id": did,"vod_play_from": "小心腰专线","vod_play_url": bofang}]

    def build_detail_result(self, videos):
        result = {}
        result['list'] = videos
        return result

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









