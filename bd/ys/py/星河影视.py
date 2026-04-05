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
from bs4 import BeautifulSoup
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
import random
import json
import time
import ast
import sys
import re
import os

sys.path.append('..')

session = requests.Session()

xurl = "https://www.xinghetv.cc"

headerx = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.87 Safari/537.36'
          }

headerz = {
    'User-Agent': 'com.android.chrome/131.0.6778.200 (Linux;Android 9) AndroidXMedia3/1.8.0'
          }

session.headers.update({
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36',
    'Referer': 'https://www.xinghetv.cc/',
    'Origin': 'https://www.xinghetv.cc',
    'sec-ch-ua': '"Google Chrome";v="123", "Not:A-Brand";v="8", "Chromium";v="123"',
    'sec-ch-ua-mobile': '?0',
    'sec-ch-ua-platform': '"Windows"',
    'Accept': 'application/json, text/javascript, */*; q=0.01',
    'X-Requested-With': 'XMLHttpRequest'
                      })

headerw = {
    'accept': 'text/html, */*; q=0.01',
    'accept-language': 'zh-CN,zh;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6',
    'cache-control': 'no-cache',
    'pragma': 'no-cache',
    'priority': 'u=1, i',
    'referer': 'https://www.xinghetv.cc/',
    'sec-ch-ua': '"Microsoft Edge";v="143", "Chromium";v="143", "Not A(Brand";v="24"',
    'sec-ch-ua-mobile': '?0',
    'sec-ch-ua-platform': '"Windows"',
    'sec-fetch-dest': 'empty',
    'sec-fetch-mode': 'cors',
    'sec-fetch-site': 'same-origin',
    'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36 Edg/143.0.0.0',
    'x-requested-with': 'XMLHttpRequest',
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
        result = {"class": [{"type_id": "1", "type_name": "电影"},
                            {"type_id": "2", "type_name": "剧集"},
                            {"type_id": "4", "type_name": "动漫"},
                            {"type_id": "3", "type_name": "综艺"}],
                 }
        return result

    def homeVideoContent(self):
        pass

    def _build_image_url(self, cover_url):
        if 'http' not in cover_url:
            return "https://image.baidu.com/search/down?url=https:" + cover_url
        return cover_url

    def _create_video_item(self, vod, cid):
        name = vod['title']
        video_id = vod['id'] + "@" + cid
        pic = self._build_image_url(vod['cover'])
        remark = vod.get('comment', '暂无备注')
        return {
            "vod_id": video_id,
            "vod_name": name,
            "vod_pic": pic,
            "vod_remarks": remark
               }

    def categoryContent(self, cid, pg, filter, ext):
        videos = []
        page = int(pg) if pg else 1
        url = f'{xurl}/api/filter-list.php?catid={cid}&rank=rankhot&size=36&pageno={str(page)}'
        detail = requests.get(url=url, headers=headerx)
        detail.encoding = "utf-8"
        data = detail.json()
        for vod in data['data']['movies']:
            video = self._create_video_item(vod, cid)
            videos.append(video)
        result = {
            'list': videos,
            'page': pg,
            'pagecount': 9999,
            'limit': 90,
            'total': 999999
                 }
        return result

    def _build_detail_url(self, fenge):
        if '1' in fenge[1]:
            return f'{xurl}/player.php?mid={fenge[0]}'
        elif '2' in fenge[1]:
            return f'{xurl}/player.php?tvid={fenge[0]}'
        elif '3' in fenge[1]:
            return f'{xurl}/player.php?vaid={fenge[0]}'
        elif '4' in fenge[1]:
            return f'{xurl}/player.php?ctid={fenge[0]}'

    def _get_html_content(self, url):
        detail = requests.get(url=url, headers=headerx)
        detail.encoding = "utf-8"
        res = detail.text
        return BeautifulSoup(res, "lxml")

    def _extract_play_lines(self, doc):
        xianlu = ''
        soups = doc.find_all('ul', class_="am-tabs-nav")
        for item in soups:
            vods = item.find_all('li')
            for sou in vods:
                name = sou.text.strip()
                xianlu = xianlu + name + '$$$'
        if xianlu:
            xianlu = xianlu[:-3]
        else:
            xianlu = "专线"
        return xianlu

    def _extract_play_urls(self, doc):
        bofang = ''
        soups = doc.find_all('div', class_="am-tab-panel")
        for item in soups:
            vods = item.find_all('button')
            for sou in vods:
                name = sou.text.strip()
                skip_names = ["加载更多"]
                if name in skip_names:
                    continue
                id = sou['data-url']
                bofang = bofang + name + '$' + id + '#'
            bofang = bofang[:-1] + '$$$'
        bofang = bofang[:-3]
        return bofang

    def detailContent(self, ids):
        did = ids[0]
        fenge = did.split("@")
        url = self._build_detail_url(fenge)
        doc = self._get_html_content(url)
        xianlu = self._extract_play_lines(doc)
        bofang = self._extract_play_urls(doc)
        videos = [{
            "vod_id": did,
            "vod_play_from": xianlu,
            "vod_play_url": bofang
                  }]
        result = {'list': videos}
        return result

    def safe_b64decode(self, data):
        if not data: return b""
        data = data.replace('-', '+').replace('_', '/')
        missing_padding = len(data) % 4
        if missing_padding:
            data += '=' * (4 - missing_padding)
        return base64.b64decode(data)

    def decrypt_m3u8(self, token, ciphertext, iv, tag):
        try:
            payload = json.loads(self.safe_b64decode(token.split('.')[0]))
            cipher = AES.new(self.safe_b64decode(payload['key']), AES.MODE_GCM, nonce=self.safe_b64decode(iv))
            return cipher.decrypt_and_verify(self.safe_b64decode(ciphertext), self.safe_b64decode(tag)).decode('utf-8')
        except Exception as e:
            return None

    def get_verify_token(self):
        url = 'https://www.xinghetv.cc/api/verify.php'
        req_headers = headerz if 'headerz' in globals() else None
        for i in range(5):
            try:
                resp = session.get(url, params={'action': 'challenge', 't': int(time.time() * 1000)},headers=req_headers).json()
                if 'verify_token' in resp:
                    return resp['verify_token']
                if 'challenge' in resp:
                    x = int(resp['targetX'])
                    y = int(resp['targetY'])
                    time.sleep(random.uniform(0.5, 1.0))
                    verify_data = {
                        'challenge': resp['challenge'],
                        'answer': f'{x + random.randint(-4, 4)},{y + random.randint(-4, 4)}'
                                  }
                    v_resp = session.post(url, params={'action': 'verify'}, data=verify_data,headers=req_headers).json()
                    if v_resp.get('code') == 200:
                        continue
                    else:
                        print(f"验证提交失败，服务器返回: {v_resp}")
            except Exception as e:
                print(f"请求发生异常: {e}")
            time.sleep(1)
        return None

    def get_xinghe_m3u8(self, video_url):
        try:
            v_token = self.get_verify_token()
            if not v_token:
                return "Error: Failed to get verify token"
            req_headers = headerz if 'headerz' in globals() else None
            auth_token = session.get('https://www.xinghetv.cc/api/token.php', headers=req_headers).json().get('token')
            if not auth_token:
                return "Error: Failed to get auth token"
            resp = session.get('https://www.xinghetv.cc/api/parse.php', params={'url': video_url},headers={'x-auth-token': auth_token, 'x-verify-token': v_token,**(req_headers or {})}).json()
            if 'ciphertext' in resp:
                decrypted_str = self.decrypt_m3u8(auth_token, resp['ciphertext'], resp['iv'], resp['tag'])
                if decrypted_str:
                    try:
                        data = json.loads(decrypted_str)
                        return data.get('url')
                    except json.JSONDecodeError:
                        return decrypted_str
                return None
            return f"Error: {resp.get('msg', 'Unknown error')}"
        except Exception as e:
            return f"Error: {str(e)}"

    def playerContent(self, flag, id, vipFlags):
        url = self.get_xinghe_m3u8(id)
        result = {}
        result["parse"] = 0
        result["playUrl"] = ''
        result["url"] = url
        result["header"] = headerz
        return result

    def _build_search_params(self, key, page):
        return {
            'wd': key,
            'pageno': page,
            'tab': 'official',
            'ajax': '1',
               }

    def _fetch_search_data(self, params):
        detail = requests.get('https://www.xinghetv.cc/search.php', params=params, headers=headerw)
        detail.encoding = "utf-8-sig"
        res = detail.text
        return BeautifulSoup(res, "html.parser")

    def _parse_id_from_href(self, href):
        fenge = href.split("=")
        if 'mid' in href:
            return f"{fenge[1]}@1"
        elif 'tvid' in href:
            return f"{fenge[1]}@2"
        elif 'vaid' in href:
            return f"{fenge[1]}@3"
        elif 'ctid' in href:
            return f"{fenge[1]}@4"

    def _parse_vod_item(self, vod):
        name = vod.find('img')['alt']
        ids = vod.find('div', class_="am-list-thumb")
        id = self._parse_id_from_href(ids.find('a')['href'])
        pic = vod.find('img')['data-original']
        return {
            "vod_id": id,
            "vod_name": name,
            "vod_pic": pic
               }

    def _build_result(self, videos, pg):
        result = {'list': videos}
        result['page'] = pg
        result['pagecount'] = 9999
        result['limit'] = 90
        result['total'] = 999999
        return result

    def searchContentPage(self, key, quick, pg):
        page = int(pg) if pg else 1
        params = self._build_search_params(key, page)
        doc = self._fetch_search_data(params)
        soups = doc.find_all('ul', class_="am-list")
        videos = []
        for item in soups:
            vods = item.find_all('li')
            for vod in vods:
                video = self._parse_vod_item(vod)
                videos.append(video)
        return self._build_result(videos, pg)

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












