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

xurl = "https://eibdlw.hq123.icu"

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

    def searchContentPage(self, key, quick, pg):
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

    def decrypt_data(self, token: str, key: str = "UC2FmMyG928hRZY4") -> dict:
        padded_token = self.pad_token(token)
        bin_data = self.base64_decode(padded_token)
        k = self.encode_key(key)
        payload = self.xor_decrypt(bin_data, k)
        body = self.decompress_payload(payload)
        return self.parse_json_body(body)

    def pad_token(self, token):
        return token + '=' * (4 - len(token) % 4)

    def base64_decode(self, token):
        return base64.urlsafe_b64decode(token)

    def encode_key(self, key):
        return key.encode('utf-8')

    def xor_decrypt(self, bin_data, k):
        return bytes(b ^ k[i % len(k)] for i, b in enumerate(bin_data))

    def decompress_payload(self, payload):
        if payload[0] == 1:
            return zlib.decompress(payload[1:], -15)
        return payload[1:]

    def parse_json_body(self, body):
        return json.loads(body.decode('utf-8'))

    def homeContent(self, filter):
        result = {"class": []}
        res = self.get_home_page()
        ress = self.extract_app_index(res)
        data = self.decrypt_data(ress)
        self.process_menu_items(data['menu'], result)
        return result

    def get_home_page(self):
        detail = requests.get(url=xurl, headers=headerx)
        detail.encoding = "utf-8"
        return detail.text

    def extract_app_index(self, res):
        return self.extract_middle_text(res, "APP.Index('", "'", 0)

    def process_menu_items(self, menu, result):
        for vod in menu:
            if not self.is_skipped_name(vod['name']):
                self.append_class(result, vod)

    def is_skipped_name(self, name):
        skip_names = ["首頁", "AI脱衣", "小说", "影视剧", "涩漫", "抖淫", "黄游", "AI伴侣", "同城泻火"]
        return name in skip_names

    def append_class(self, result, vod):
        result["class"].append({"type_id": vod['id'], "type_name": vod['name']})

    def categoryContent(self, cid, pg, filter, ext):
        videos = []
        page = self.get_page_number(pg)
        if '9' in cid:
            url = self.build_gua_url(cid, page)
            res = self.get_page_content(url)
            ress = self.extract_app_index(res)
            data = self.decrypt_data(ress)
            self.process_gua_list(data['list'], videos)
        else:
            url = self.build_video_url(cid, page)
            res = self.get_page_content(url)
            ress = self.extract_app_index(res)
            data = self.decrypt_data(ress)
            self.process_video_list(data['list'], videos)
        result = self.build_category_result(videos, pg)
        return result

    def get_page_number(self, pg):
        return int(pg) if pg else 1

    def build_gua_url(self, cid, page):
        return f'{xurl}/category/{cid}/-{str(page)}-'

    def build_video_url(self, cid, page):
        return f'{xurl}/category/{cid}/---{str(page)}'

    def get_page_content(self, url):
        detail = requests.get(url=url, headers=headerx)
        detail.encoding = "utf-8"
        return detail.text

    def extract_app_index(self, res):
        return self.extract_middle_text(res, "APP.Index('", "'", 0)

    def process_gua_list(self, vod_list, videos):
        for vod in vod_list:
            video = self.parse_gua_video(vod)
            videos.append(video)

    def parse_gua_video(self, vod):
        return {
            "vod_id": f"{vod.get('art_id')}@gua_details",
            "vod_name": vod.get('art_name'),
            "vod_pic": vod.get('art_pic')
               }

    def process_video_list(self, vod_list, videos):
        for vod in vod_list:
            video = self.parse_video(vod)
            videos.append(video)

    def parse_video(self, vod):
        return {
            "vod_id": f"{vod.get('vod_id')}@videoplay",
            "vod_name": vod.get('vod_name'),
            "vod_pic": vod.get('vod_pic')
               }

    def build_category_result(self, videos, pg):
        result = {'list': videos}
        result['page'] = pg
        result['pagecount'] = 9999
        result['limit'] = 90
        result['total'] = 999999
        return result

    def decode_video_url(self, encrypted_hex):
        key = self.get_aes_key()
        cipher_hex, iv_hex = self.split_hex_data(encrypted_hex)
        ciphertext = self.hex_to_bytes(cipher_hex)
        iv = self.hex_to_bytes(iv_hex)
        cipher = self.create_aes_cipher(key, iv)
        decrypted_bytes = self.decrypt_ciphertext(cipher, ciphertext)
        decrypted_str = self.bytes_to_string(decrypted_bytes)
        return self.parse_json(decrypted_str)

    def get_aes_key(self):
        return b"WB0nMZHXlxNndORe"

    def split_hex_data(self, encrypted_hex):
        n = len(encrypted_hex)
        if n < 48:
            cipher_hex = encrypted_hex[:n - 32]
            iv_hex = encrypted_hex[n - 32:]
        else:
            cipher_hex = encrypted_hex[:16] + encrypted_hex[48:]
            iv_hex = encrypted_hex[16:48]
        return cipher_hex, iv_hex

    def hex_to_bytes(self, hex_str):
        return binascii.unhexlify(hex_str)

    def create_aes_cipher(self, key, iv):
        return AES.new(key, AES.MODE_CFB, iv=iv, segment_size=128)

    def decrypt_ciphertext(self, cipher, ciphertext):
        return cipher.decrypt(ciphertext)

    def bytes_to_string(self, decrypted_bytes):
        return decrypted_bytes.decode('utf-8')

    def parse_json(self, decrypted_str):
        return json.loads(decrypted_str)

    def detailContent(self, ids):
        did = self.get_first_id(ids)
        fenge = self.split_did(did)
        if self.is_gua_details(fenge):
            data = self.get_gua_details_data(fenge)
            bofang = self.extract_gua_play_url(data)
        else:
            data = self.get_normal_details_data(fenge)
            bofang = self.extract_normal_play_url(data)
        videos = self.build_video_info(did, bofang)
        result = self.build_detail_result(videos)
        return result

    def get_first_id(self, ids):
        return ids[0]

    def split_did(self, did):
        return did.split("@")

    def is_gua_details(self, fenge):
        return 'gua_details' in fenge[1]

    def get_gua_details_data(self, fenge):
        url = self.build_gua_details_url(fenge)
        res = self.get_page_content(url)
        ress = self.extract_middle_text(res, "content:'", "'", 0)
        return self.decode_video_url(ress)

    def build_gua_details_url(self, fenge):
        return f'{xurl}/{fenge[1]}/{fenge[0]}'

    def get_page_content(self, url):
        detail = requests.get(url=url, headers=headerx)
        detail.encoding = "utf-8"
        return detail.text

    def extract_gua_play_url(self, data):
        return data['0']['vod_play_url'][0]['list'][0]['h264']

    def get_normal_details_data(self, fenge):
        url = self.build_normal_details_url(fenge)
        res = self.get_page_content(url)
        ress = self.extract_middle_text(res, "APP.Index('", "'", 0)
        return self.decrypt_data(ress)

    def build_normal_details_url(self, fenge):
        return f'{xurl}/{fenge[1]}/{fenge[0]}'

    def extract_normal_play_url(self, data):
        return data.get('info', {}).get('vod_play_url') or data.get('info', {}).get('vod_down_url')

    def build_video_info(self, did, bofang):
        return [{"vod_id": did,"vod_play_from": "黄区专线","vod_play_url": bofang}]

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









