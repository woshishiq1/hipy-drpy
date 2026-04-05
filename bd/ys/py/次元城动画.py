# coding=utf-8
# !/usr/bin/python

"""

作者 丢丢喵 内容均从互联网收集而来 仅供交流学习使用 严禁用于商业用途 请于24小时内删除
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

xurl = "https://www.cycani.org"

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
        res = self.fetch_home_page()
        doc = self.parse_html(res)
        soups = self.find_home_categories(doc)
        classes = self.extract_home_classes(soups)
        return self.build_home_result(classes)

    def fetch_home_page(self):
        detail = requests.get(url=xurl, headers=headerx)
        detail.encoding = "utf-8"
        return detail.text

    def parse_html(self, html):
        return BeautifulSoup(html, "lxml")

    def find_home_categories(self, doc):
        return doc.find_all('li', class_="head-more-a")

    def extract_home_classes(self, soups):
        classes = []
        for soup in soups:
            for vod in soup.find_all('a'):
                if self.should_skip_category(vod):
                    continue
                classes.append(self.parse_home_class(vod))
        return classes

    def should_skip_category(self, vod):
        name = vod.text.strip()
        skip_names = ["更多", "首页", "4K专区"]
        return name in skip_names

    def parse_home_class(self, vod):
        name = vod.text.strip()
        id = vod['href']
        return {"type_id": id, "type_name": name}

    def build_home_result(self, classes):
        result = {"class": classes}
        return result

    def categoryContent(self, cid, pg, filter, ext):
        fenge = cid.split(".html")
        page = self.get_page_number(pg)
        url = self.build_category_url(fenge, page)
        doc = self.fetch_category_document(url)
        soups = doc.find_all('div', class_="border-box")
        videos = self.extract_category_videos(soups)
        return self.build_category_result(videos, pg)

    def get_page_number(self, pg):
        return int(pg) if pg else 1

    def build_category_url(self, fenge, page):
        return f'{xurl}{fenge[0]}/page/{str(page)}.html'

    def fetch_category_document(self, url):
        detail = requests.get(url=url, headers=headerx)
        detail.encoding = "utf-8"
        return BeautifulSoup(detail.text, "lxml")

    def extract_category_videos(self, soups):
        videos = []
        for soup in soups:
            for vod in soup.find_all('a', class_="public-list-exp"):
                videos.append(self.parse_category_video(vod))
        return videos

    def parse_category_video(self, vod):
        name = vod['title']
        id = vod['href']
        pic = vod.find('img')['data-src']
        remarks = vod.find('i', class_="ft4")
        remark = remarks.text.strip() if remarks else ""
        return {"vod_id": id,"vod_name": name,"vod_pic": pic,"vod_remarks": remark}

    def build_category_result(self, videos, pg):
        result = {'list': videos}
        result['page'] = pg
        result['pagecount'] = 9999
        result['limit'] = 90
        result['total'] = 999999
        return result

    def detailContent(self, ids):
        did = self.prepare_did(ids[0])
        res = self.fetch_detail_page(did)
        doc = BeautifulSoup(res, "lxml")
        content = self.build_content(res)
        director = self.extract_director(res)
        actor = self.extract_actor(res)
        remarks = self.extract_remarks(res)
        year = self.extract_year(res)
        area = self.extract_area(res)
        xianlu = self.extract_xianlu(doc)
        bofang = self.extract_bofang(doc)
        videos = [self.build_video_data(did, director, actor, remarks, year, area, content, xianlu, bofang)]
        return {'list': videos}

    def prepare_did(self, did):
        return xurl + did if 'http' not in did else did

    def fetch_detail_page(self, did):
        detail = requests.get(url=did, headers=headerx)
        detail.encoding = "utf-8"
        return detail.text

    def build_content(self, res):
        return '😸丢丢为您介绍剧情📢' + self.extract_middle_text(res, '简介：</em>', '<', 0)

    def extract_director(self, res):
        return self.extract_middle_text(res, '导演：', '</li>', 1, 'target=".*?">(.*?)<')

    def extract_actor(self, res):
        return self.extract_middle_text(res, '主演：', '</li>', 1, 'target=".*?">(.*?)<')

    def extract_remarks(self, res):
        return self.extract_middle_text(res, '类型：', '</li>', 1, 'target=".*?">(.*?)<')

    def extract_year(self, res):
        return self.extract_middle_text(res, '年份：</em>', '<', 0)

    def extract_area(self, res):
        return self.extract_middle_text(res, '地区：</em>', '<', 0)

    def extract_xianlu(self, doc):
        soups = doc.find_all('div', class_="swiper-wrapper")
        xianlu = ''
        for item in soups:
            for sou in item.find_all('a'):
                xianlu += sou.text.strip() + '$$$'
        return xianlu[:-3]

    def extract_bofang(self, doc):
        soups = doc.find_all('ul', class_="anthology-list-play")
        bofang = ''
        for item in soups:
            for sou in item.find_all('a'):
                id = sou['href']
                if 'http' not in id:
                    id = xurl + id
                bofang += sou.text.strip() + '$' + id + '#'
            bofang = bofang[:-1] + '$$$'
        return bofang[:-3]

    def build_video_data(self, did, director, actor, remarks, year, area, content, xianlu, bofang):
        return {"vod_id": did,"vod_director": director,"vod_actor": actor,"vod_remarks": remarks,"vod_year": year,"vod_area": area,"vod_content": content,"vod_play_from": xianlu,"vod_play_url": bofang}

    def manual_decrypt(self, encrypted_url, raw_text, raw_sort):
        secret_suffix = "YLwJVbXw77pk2eOrAnFdBo2c3mWkLtodMni2wk81GCnP94ZltW"
        sorted_str = self.sort_and_combine_chars(raw_text, raw_sort)
        final_str = self.add_salt_to_string(sorted_str, secret_suffix)
        md5_hex = self.calculate_md5_hash(final_str)
        iv, key = self.extract_iv_and_key(md5_hex)
        real_url = self.perform_aes_decryption(encrypted_url, key, iv)
        return real_url

    def sort_and_combine_chars(self, raw_text, raw_sort):
        pairs = []
        min_len = min(len(raw_text), len(raw_sort))
        for i in range(min_len):
            pairs.append({'char': raw_text[i], 'sort': raw_sort[i]})
        pairs.sort(key=lambda x: x['sort'])
        return "".join([p['char'] for p in pairs])

    def add_salt_to_string(self, sorted_str, salt):
        return sorted_str + salt

    def calculate_md5_hash(self, final_str):
        return hashlib.md5(final_str.encode('utf-8')).hexdigest()

    def extract_iv_and_key(self, md5_hex):
        iv = md5_hex[0:16].encode('utf-8')
        key = md5_hex[16:32].encode('utf-8')
        return iv, key

    def perform_aes_decryption(self, encrypted_url, key, iv):
        cipher = AES.new(key, AES.MODE_CBC, iv)
        encrypted_bytes = base64.b64decode(encrypted_url)
        decrypted_bytes = cipher.decrypt(encrypted_bytes)
        return unpad(decrypted_bytes, AES.block_size).decode('utf-8')

    def playerContent(self, flag, id, vipFlags):
        res = self.fetch_player_page(id)
        url = self.extract_and_decode_url(res)
        url2 = self.build_player_url(url)
        res2 = self.fetch_player_iframe(url2)
        raw_text = self.extract_raw_text(res2)
        raw_sort = self.extract_raw_sort(res2)
        encrypted_url = self.extract_encrypted_url(res2)
        url5 = self.manual_decrypt(encrypted_url, raw_text, raw_sort)
        return self.build_player_result(url5)

    def fetch_player_page(self, id):
        detail = requests.get(url=id, headers=headerx)
        detail.encoding = "utf-8"
        return detail.text

    def extract_and_decode_url(self, res):
        url = self.extract_middle_text(res, '},"url":"', '"', 0).replace('\\', '')
        base64_decoded_bytes = base64.b64decode(url)
        base64_decoded_string = base64_decoded_bytes.decode('utf-8')
        return unquote(base64_decoded_string)

    def build_player_url(self, url1):
        return f"https://player.cycanime.com/?url={url1}"

    def fetch_player_iframe(self, url2):
        detail = requests.get(url=url2, headers=headerx)
        detail.encoding = "utf-8"
        return detail.text

    def extract_raw_text(self, res2):
        return self.extract_middle_text(res2, 'user-scalable=no" id="now_', '"', 0)

    def extract_raw_sort(self, res2):
        return self.extract_middle_text(res2, '"UTF-8" id="now_', '"', 0)

    def extract_encrypted_url(self, res2):
        return self.extract_middle_text(res2, '"url": "', '"', 0)

    def build_player_result(self, url5):
        result = {}
        result["parse"] = 0
        result["playUrl"] = ''
        result["url"] = url5
        result["header"] = headerx
        return result

    def searchContentPage(self, key, quick, pg):
        page = self.get_page_number(pg)
        url = self.build_search_url(key, page)
        data = self.fetch_search_json(url)
        videos = self.parse_search_videos(data)
        return self.build_search_result(videos, pg)

    def get_page_number(self, pg):
        return int(pg) if pg else 1

    def build_search_url(self, key, page):
        return f'{xurl}/index.php/ajax/suggest?mid=1&wd={key}&page={str(page)}&limit=30'

    def fetch_search_json(self, url):
        detail = requests.get(url=url, headers=headerx)
        detail.encoding = "utf-8"
        return detail.json()

    def parse_search_videos(self, data):
        videos = []
        for vod in data['list']:
            videos.append(self.parse_search_item(vod))
        return videos

    def parse_search_item(self, vod):
        name = vod['name']
        id = f"{xurl}/bangumi/{vod['id']}.html"
        pic = vod['pic']
        return {"vod_id": id,"vod_name": name,"vod_pic": pic}

    def build_search_result(self, videos, pg):
        result = {'list': videos}
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










