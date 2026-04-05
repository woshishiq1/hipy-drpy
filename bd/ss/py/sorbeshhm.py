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
import zlib
import json
import time
import sys
import re
import os

sys.path.append('..')

xurl = "https://yhecfhhm.top:2549"  # http://104.255.229.161:6688/?r=aHR0cDovL2hoZTQ5LmNvbS8=

headerx = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.87 Safari/537.36'
          }

class Spider(Spider):

    def getName(self):
        return "丢丢喵"

    def init(self, extend):
        pass

    def searchContentPage(self, key, quick, pg):
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

    def decrypt_data(self, Toubu, Zhongbu):
        key_bytes = self.get_key_bytes(Toubu)
        iv_bytes = key_bytes
        encrypted_bytes = self.decode_encrypted_data(Zhongbu)
        cipher = self.create_aes_cipher(key_bytes, iv_bytes)
        decrypted_padded = self.decrypt_data_bytes(cipher, encrypted_bytes)
        decrypted_bytes = self.unpad_data(decrypted_padded)
        decompressed_bytes = self.try_decompress(decrypted_bytes)
        result = self.decode_to_string(decompressed_bytes)
        return result

    def get_key_bytes(self, Toubu):
        return Toubu[:16].encode('utf-8')

    def decode_encrypted_data(self, Zhongbu):
        return base64.b64decode(Zhongbu.replace('\n', '').strip())

    def create_aes_cipher(self, key_bytes, iv_bytes):
        return AES.new(key_bytes, AES.MODE_CBC, iv_bytes)

    def decrypt_data_bytes(self, cipher, encrypted_bytes):
        return cipher.decrypt(encrypted_bytes)

    def unpad_data(self, decrypted_padded):
        return unpad(decrypted_padded, AES.block_size)

    def try_decompress(self, decrypted_bytes):
        try:
            return zlib.decompress(decrypted_bytes, zlib.MAX_WBITS | 32)
        except:
            try:
                return zlib.decompress(decrypted_bytes, -zlib.MAX_WBITS)
            except:
                return None

    def decode_to_string(self, decompressed_bytes):
        return decompressed_bytes.decode('utf-8', errors='ignore')

    def homeContent(self, filter):
        result = {"class": []}
        res = self.get_main_page()
        Toubu = self.extract_toubu(res)
        Zhongbu = self.extract_zhongbu(res)
        decrypted = self.decrypt_data(Toubu, Zhongbu)
        res1 = self.extract_movie_channel(decrypted)
        soups = self.parse_html(res1)
        self.process_soups(soups, result)
        return result

    def get_main_page(self):
        detail = requests.get(url=xurl + "/main.html", headers=headerx)
        detail.encoding = "utf-8"
        return detail.text

    def extract_toubu(self, res):
        return self.extract_middle_text(res, '头部加载中</p><div data-content="">', '<', 0)

    def extract_zhongbu(self, res):
        return self.extract_middle_text(res, '中部加载中</p><div data-content="">', '<', 0)

    def extract_movie_channel(self, decrypted):
        return self.extract_middle_text(decrypted, '电影频道</a></li>', '</ul>', 0)

    def parse_html(self, res1):
        return BeautifulSoup(res1, "lxml")

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
        videos = []
        page = self.get_page_number(pg)
        url = self.build_category_url(cid, page)
        res = self.get_category_page(url)
        Toubu = self.extract_toubu(res)
        Zhongbu = self.extract_zhongbu(res)
        decrypted = self.decrypt_data(Toubu, Zhongbu)
        doc = self.parse_html(decrypted)
        soups = self.find_vodlist_divs(doc)
        self.process_vodlist_divs(soups, videos)
        result = self.build_category_result(videos, pg)
        return result

    def get_page_number(self, pg):
        return int(pg) if pg else 1

    def build_category_url(self, cid, page):
        return f'{xurl}{cid}&page={str(page)}'

    def get_category_page(self, url):
        detail = requests.get(url=url, headers=headerx)
        detail.encoding = "utf-8"
        return detail.text

    def extract_toubu(self, res):
        return self.extract_middle_text(res, '头部加载中</p><div data-content="">', '<', 0)

    def extract_zhongbu(self, res):
        return self.extract_middle_text(res, '中部加载中</p><div data-content="">', '<', 0)

    def parse_html(self, decrypted):
        return BeautifulSoup(decrypted, "lxml")

    def find_vodlist_divs(self, doc):
        return doc.find_all('div', class_="vodlist dylist")

    def process_vodlist_divs(self, soups, videos):
        for soup in soups:
            self.process_single_vodlist(soup, videos)

    def process_single_vodlist(self, soup, videos):
        vods = self.find_links(soup)
        for vod in vods:
            video = self.extract_video_info(vod)
            if video:
                videos.append(video)

    def find_links(self, soup):
        return soup.find_all('a')

    def extract_video_info(self, vod):
        names = vod.find('div', class_="vodname")
        if names is None:
            return None
        name = names.text.strip()
        id = vod['href']
        pics = vod.find('div', class_="vodpic lazyload")
        pic = pics['data-original']
        remarks = vod.find('span', class_="time")
        year = remarks.text.strip() if remarks else ""
        return {"vod_id": id,"vod_name": name,"vod_pic": pic,"vod_year": year,}

    def build_category_result(self, videos, pg):
        result = {'list': videos}
        result['page'] = pg
        result['pagecount'] = 9999
        result['limit'] = 90
        result['total'] = 999999
        return result

    def detailContent(self, ids):
        did = self.get_first_id(ids)
        videos = self.build_video_info(did)
        result = self.build_detail_result(videos)
        return result

    def get_first_id(self, ids):
        return ids[0]

    def build_video_info(self, did):
        return [{"vod_id": did,"vod_play_from": "保重身体","vod_play_url": did}]

    def build_detail_result(self, videos):
        result = {}
        result['list'] = videos
        return result

    def playerContent(self, flag, id, vipFlags):
        res = self.get_player_page(id)
        Toubu = self.extract_toubu(res)
        Zhongbu = self.extract_zhongbu(res)
        decrypted = self.decrypt_data(Toubu, Zhongbu)
        real_url = self.extract_real_url(decrypted)
        result = self.build_player_result(real_url)
        return result

    def get_player_page(self, id):
        detail = requests.get(url=f"{xurl}{id}", headers=headerx)
        detail.encoding = "utf-8"
        return detail.text

    def extract_toubu(self, res):
        return self.extract_middle_text(res, '头部加载中</p><div data-content="">', '<', 0)

    def extract_zhongbu(self, res):
        return self.extract_middle_text(res, '中部加载中</p><div data-content="">', '<', 0)

    def extract_real_url(self, decrypted):
        pattern = r'(https?://[^\s"\'<>]+?\.m3u8|https?:\\/\\/[^\s"\'<>]+?\.m3u8)'
        match = re.search(pattern, decrypted)
        return match.group(1).replace('\\/', '/')

    def build_player_result(self, real_url):
        result = {}
        result["parse"] = 0
        result["playUrl"] = ''
        result["url"] = real_url
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







