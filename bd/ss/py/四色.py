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

headerx = {
    'User-Agent': 'com.android.chrome/131.0.6778.200 (Linux;Android 9) AndroidXMedia3/1.8.0'
          }

xurl1 = "http://3344br.com/"

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

    def decrypt_m3u8(self, ciphertext):
        real_key = self.get_real_key()
        final_iv = self.build_final_iv()
        encrypted_bytes = base64.b64decode(ciphertext)
        decrypted_bytes = self.aes_decrypt(real_key, final_iv, encrypted_bytes)
        result_text = self.finalize_result(decrypted_bytes)
        return result_text

    def get_real_key(self):
        B64_KEY = "SWRUSnEwSGtscHVJNm11OGlCJU9PQCF2ZF40SyZ1WFc="
        return base64.b64decode(B64_KEY)

    def build_final_iv(self):
        B64_IV_BASE = "JDB2QGtySDdWMg=="
        SUFFIX = "883346"
        iv_prefix = base64.b64decode(B64_IV_BASE).decode('utf-8')
        return (iv_prefix + SUFFIX).encode('utf-8')

    def aes_decrypt(self, real_key, final_iv, encrypted_bytes):
        cipher = AES.new(real_key, AES.MODE_CBC, final_iv)
        decrypted_bytes = cipher.decrypt(encrypted_bytes)
        return unpad(decrypted_bytes, AES.block_size).decode('utf-8')

    def finalize_result(self, decrypted_bytes):
        return decrypted_bytes.replace('"', '')

    def get_real_base_url(self, start_url):
        res = self.fetch_start_page(start_url)
        target_host_b64 = self.extract_target_host_b64(res)
        if not target_host_b64:
            return start_url
        target_host = base64.b64decode(target_host_b64).decode('utf-8')
        u_val, p_val = self.build_params(start_url)
        check_url = f"{target_host}/?u={u_val}&p={p_val}"
        redirect_url_1 = self.get_redirect(check_url)
        if not redirect_url_1:
            return check_url
        redirect_url_2 = self.get_redirect(redirect_url_1)
        real_url = redirect_url_2 if redirect_url_2 else redirect_url_1
        return real_url.rstrip('/')

    def fetch_start_page(self, start_url):
        detail = requests.get(url=start_url, headers=headerx)
        detail.encoding = "utf-8"
        return detail.text

    def extract_target_host_b64(self, res):
        match = re.search(r'window\.atob\("(.*?)"\)', res)
        return match.group(1) if match else None

    def build_params(self, start_url):
        parsed_url = urlparse(start_url)
        origin = f"{parsed_url.scheme}://{parsed_url.netloc}"
        path_and_search = parsed_url.path
        if parsed_url.query:
            path_and_search += f"?{parsed_url.query}"
        if not path_and_search:
            path_and_search = "/"
        u_val = base64.b64encode(origin.encode('utf-8')).decode('utf-8')
        p_val = base64.b64encode(path_and_search.encode('utf-8')).decode('utf-8')
        return u_val, p_val

    def get_redirect(self, url):
        response = requests.get(url=url, headers=headerx, allow_redirects=False)
        return response.headers.get('Location')

    def homeContent(self, filter):
        xurl = self.get_real_base_url(xurl1)
        url = self.build_home_url(xurl)
        res = self.fetch_home_page(url)
        doc = self.parse_html(res)
        soups = self.find_row_items(doc)
        classes = self.extract_classes(soups)
        result = self.build_home_result(classes)
        return result

    def build_home_url(self, xurl):
        return f'{xurl}/index/home.html'

    def fetch_home_page(self, url):
        detail = requests.get(url=url, headers=headerx)
        detail.encoding = "utf-8"
        return detail.text

    def parse_html(self, html):
        return BeautifulSoup(html, "lxml")

    def find_row_items(self, doc):
        return doc.find_all('ul', class_="row-item-content")[:1]

    def extract_classes(self, soups):
        classes = []
        for soup in soups:
            for vod in soup.find_all('a'):
                classes.append(self.parse_class_item(vod))
        return classes

    def parse_class_item(self, vod):
        names = vod.find('span', class_="menu-desktop-content-item")
        name = names['title']
        name = self.decrypt_m3u8(name)
        return {"type_id": name, "type_name": name}

    def build_home_result(self, classes):
        result = {"class": classes}
        return result

    def get_page_url(self, category_name, page_num):
        raw_path = f"/juqing/list-{category_name}-{page_num}.html"
        b64_bytes = base64.b64encode(raw_path.encode('utf-8'))
        b64_str = b64_bytes.decode('utf-8')
        url_encoded = urllib.parse.quote(b64_str)
        final_url = f"/cYc{url_encoded}.html"
        return final_url

    def categoryContent(self, cid, pg, filter, ext):
        xurl = self.get_real_base_url(xurl1)
        page = self.get_page_number(pg)
        url1 = self.get_page_url(cid, page)
        url = f'{xurl}{url1}'
        res = self.fetch_category_page(url)
        doc = self.parse_html(res)
        soups = self.find_video_lists(doc)
        videos = self.extract_videos(soups, xurl)
        return self.build_category_result(videos, pg)

    def get_page_number(self, pg):
        return int(pg) if pg else 1

    def fetch_category_page(self, url):
        detail = requests.get(url=url, headers=headerx)
        detail.encoding = "utf-8"
        return detail.text

    def parse_html(self, html):
        return BeautifulSoup(html, "lxml")

    def find_video_lists(self, doc):
        return doc.find_all('div', class_="video-list")

    def extract_videos(self, soups, xurl):
        videos = []
        for soup in soups:
            for vod in soup.find_all('a'):
                videos.append(self.parse_video_item(vod, xurl))
        return videos

    def parse_video_item(self, vod, xurl):
        names = vod.find('div', class_="video-item-title")
        raw_title = names['title']
        name = self.decrypt_m3u8(raw_title)
        vid = vod['href']
        pics = vod.find('img', class_="video-item-img")
        pic = f"{xurl}{pics['src']}"
        remarks = vod.find('div', class_="video-item-date")
        remark = remarks.text.strip() if remarks else ""
        return {"vod_id": vid,"vod_name": name,"vod_pic": pic,"vod_remarks": remark}

    def build_category_result(self, videos, pg):
        result = {'list': videos}
        result['page'] = pg
        result['pagecount'] = 9999
        result['limit'] = 90
        result['total'] = 999999
        return result

    def _fetch_page_content(self, url):
        response = requests.get(url=url, headers=headerx)
        response.encoding = "utf-8"
        return response.text

    def _decode_config(self, html, key):
        start_str = f"{key} = decodeString('"
        encoded_str = self.extract_middle_text(html, start_str, "'", 0)
        return base64.b64decode(encoded_str).decode('utf-8')

    def _build_play_url(self, html):
        video_path = self._decode_config(html, "var video     ")
        host1 = self._decode_config(html, "m3u8_host ")
        host2 = self._decode_config(html, "m3u8_host1")
        return f"线路1${host1}{video_path}#线路2${host2}{video_path}"

    def detailContent(self, ids):
        did = ids[0]
        base_url = self.get_real_base_url(xurl1)
        full_url = f'{base_url}{did}'
        page_content = self._fetch_page_content(full_url)
        play_url = self._build_play_url(page_content)
        return {'list': [{"vod_id": did,"vod_name": "温馨提醒📢注意身体","vod_play_from": "四色专线","vod_play_url": play_url}]}

    def playerContent(self, flag, id, vipFlags):
        result = {}
        result["parse"] = 0
        result["playUrl"] = ''
        result["url"] = id
        result["header"] = headerx
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


