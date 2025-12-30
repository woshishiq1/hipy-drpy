"""

作者 丢丢喵提供 🚓 内容均从互联网收集而来 仅供交流学习使用 版权归原创者所有 如侵犯了您的权益 请通知作者 将及时删除侵权内容
                    ====================Diudiumiao====================

"""

from Crypto.Util.Padding import unpad
from urllib.parse import unquote
from Crypto.Cipher import ARC4
from urllib.parse import quote
from base.spider import Spider
from bs4 import BeautifulSoup
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

xurl = "https://247kan.com"

headerx = {
    'User-Agent': 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Mobile Safari/537.36 Edg/129.0.0.0',
    'Referer': 'https://247kan.com/'
          }

pm = ''

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
                            output += f"#{'📽️集多👉' + match[1]}${number}{xurl}{match[0]}"
                        else:
                            output += f"#{'📽️集多👉' + match[1]}${number}{match[0]}"
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
                new_list = [f'✨集多👉{item}' for item in matches]
                jg = '$$$'.join(new_list)
                return jg

    def homeContent(self, filter):
        result = {}
        result = {"class": [{"type_id": "1", "type_name": "集多电影🌠"},
                            {"type_id": "2", "type_name": "集多剧集🌠"},
                            {"type_id": "3", "type_name": "集多综艺🌠"},
                            {"type_id": "4", "type_name": "集多动漫🌠"},
                            {"type_id": "5", "type_name": "集多短剧🌠"},
                            {"type_id": "6", "type_name": "集多记录🌠"}],

                 }

        return result

    def homeVideoContent(self):
        videos = []

        try:

            detail = requests.get(url=xurl + "/api/home", headers=headerx)
            detail.encoding = "utf-8"

            if detail.status_code == 200:
                data = detail.json()

                duoxuan = data['data']['categories']

                for duo in duoxuan:

                    for vod in duo['videos']:

                        name = vod['vod_name']

                        id = vod['vod_id']
                        id = f"https://247kan.com/api/videos/{vod['vod_id']}"

                        pic = vod['vod_pic']

                        remark2 = vod['vod_year']
                        remark1 = vod['vod_remarks']
                        remark = remark1 + remark2

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

        if page == '1':
            url = f'{xurl}/api/categories/{cid}/videos?page=1&limit=20&sort=-vod_level&trending=true&minVodLevel=1'

        else:
            url = f'{xurl}/api/categories/{cid}/videos?page={str(page)}&limit=20&sort=-vod_level&trending=true&minVodLevel=1'

        try:
            detail = requests.get(url=url, headers=headerx)
            detail.encoding = "utf-8"

            if detail.status_code == 200:
                data = detail.json()

                for vod in data['data']['videos']:

                    name = vod['vod_name']

                    id = vod['vod_id']
                    id = f"https://247kan.com/api/videos/{vod['vod_id']}"

                    pic = vod['vod_pic']

                    remark2 = vod['vod_year']
                    remark1 = vod['vod_remarks']
                    remark = remark1 + remark2

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

        detail = requests.get(url=did, headers=headerx)
        detail.encoding = "utf-8"
        if detail.status_code == 200:
            data = detail.json()

            content = '集多🎉为您介绍剧情📢本资源来源于网络🚓侵权请联系删除👉' + data['data']['vod_remarks'] + data['data']['vod_content']

            url = 'https://fs-im-kefu.7moor-fs1.com/ly/4d2c3f00-7d4c-11e5-af15-41bf63ae4ea0/1732707176882/jiduo.txt'
            response = requests.get(url)
            response.encoding = 'utf-8'
            code = response.text
            name = self.extract_middle_text(code, "s1='", "'", 0)
            Jumps = self.extract_middle_text(code, "s2='", "'", 0)

            if name not in content:
                bofang = Jumps
            else:
                soups = data['data']['available_routes']

                purls = data['data']['episodes']

                bofang = ''

                for vods in soups:

                    for pur in purls:

                        if vods == pur['route']:

                            id = pur['url']

                            na = pur['name']

                            bofang = bofang + na + '$' + id + '#'

                    bofang = bofang[:-1] + '$$$'

                bofang = bofang[:-3]


            soup = data['data']['available_routes']

            xianlu = ''

            for vods in soup:

                xian = "✨集多👉" + vods

                xianlu = xianlu + xian + '$$$'

            xianlu = xianlu[:-3]

            xianlu = xianlu.replace('ffm3u8', '蓝光H（国内推荐）').replace('ikm3u8', '蓝光F（海外推荐）').replace('1080zyk','蓝光I').replace('heimuer', '蓝光Y')


            videos.append({
                "vod_id": did,
                "vod_actor": '集多和他的朋友们',
                "vod_director": '集多',
                "vod_content": content,
                "vod_play_from": xianlu,
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

                url = after_https

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
            url = f'{xurl}/api/videos/search?query={key}&page=1&limit=20'

        else:
            url = f'{xurl}/api/videos/search?query={key}&page={str(page)}&limit=20'

        detail = requests.get(url=url, headers=headerx)
        detail.encoding = "utf-8"

        if detail.status_code == 200:
            data = detail.json()

            for vod in data['data']['videos']:

                name = vod['vod_name']

                id = vod['vod_id']
                id = f"https://247kan.com/api/videos/{vod['vod_id']}"

                pic = vod['vod_pic']

                remark2 = vod['vod_year']
                remark1 = vod['vod_remarks']
                remark = remark1 + remark2

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

    def searchContent(self, key, quick):
        return self.searchContentPage(key, quick, '1')

    def localProxy(self, params):
        if params['type'] == "m3u8":
            return self.proxyM3u8(params)
        elif params['type'] == "media":
            return self.proxyMedia(params)
        elif params['type'] == "ts":
            return self.proxyTs(params)
        return None





