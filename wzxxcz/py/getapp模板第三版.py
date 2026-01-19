# coding = utf-8
# !/usr/bin/python
# 新时代青年 2025.06.25 getApp第三版
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

headerx = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.87 Safari/537.36'
          }

pm = ''

class Spider(Spider):
    global xurl1
    global headerx
    global headers

    def getName(self):
        return "首页"

    def init(self, extend):
        js1=json.loads(extend)
        self.xurl = js1['url']
        self.key = js1['datakey']
        self.iv = js1['dataiv']

    def isVideoFormat(self, url):
        pass

    def manualVideoCheck(self):
        pass

    def homeContent(self, filter):
        result = {}
        result["class"] = []

        res = requests.get(self.xurl + '/initV119', headers=headerx).text
        res = json.loads(res)
        encrypted_data = res['data']
        response = self.decrypt(encrypted_data)
        kjson = json.loads(response)
        for i in kjson['type_list']:
            if i['type_name'] in ['全部', 'QQ'] or '企鹅群' in i['type_name']:
                continue
            result["class"].append({
                "type_id": i['type_id'],
                "type_name": i['type_name']
            })
        return result

    def decrypt(self, encrypted_data_b64):
        key_text = self.key
        iv_text = self.iv
        key_bytes = key_text.encode('utf-8')
        iv_bytes = iv_text.encode('utf-8')
        encrypted_data = base64.b64decode(encrypted_data_b64)
        cipher = AES.new(key_bytes, AES.MODE_CBC, iv_bytes)
        decrypted_padded = cipher.decrypt(encrypted_data)
        decrypted = unpad(decrypted_padded, AES.block_size)
        return decrypted.decode('utf-8')

    def decrypt_wb(self, sencrypted_data):
        key_text = self.key
        iv_text = self.iv
        key_bytes = key_text.encode('utf-8')
        iv_bytes = iv_text.encode('utf-8')
        data_bytes = sencrypted_data.encode('utf-8')
        padded_data = pad(data_bytes, AES.block_size)
        cipher = AES.new(key_bytes, AES.MODE_CBC, iv_bytes)
        encrypted_bytes = cipher.encrypt(padded_data)
        encrypted_data_b64 = base64.b64encode(encrypted_bytes).decode('utf-8')
        return encrypted_data_b64

    def homeVideoContent(self):
        result = {}
        videos = []
        url = f"{self.xurl}/initV119"
        res = requests.get(url=url, headers=headerx).text
        res = json.loads(res)
        encrypted_data = res['data']
        kjson = self.decrypt(encrypted_data)
        kjson1 = json.loads(kjson)
        for i in kjson1['type_list']:
            for item in i['recommend_list']:
                id = item['vod_id']
                name = item['vod_name']
                pic = item['vod_pic']
                remarks = item['vod_remarks']
                video = {
                    "vod_id": id,
                    "vod_name": name,
                    "vod_pic": pic,
                    "vod_remarks": remarks
                }
                videos.append(video)

        result = {'list': videos}
        return result

    def categoryContent(self, cid, pg, filter, ext):
        result = {}
        videos = []
        payload = {
            'area': "全部",
            'year': "全部",
            'type_id': cid,
            'page': str(pg),
            'sort': "最新",
            'lang': "全部",
            'class': "全部"
        }
        url = f'{self.xurl}/typeFilterVodList'
        res = requests.post(url=url, headers=headerx,data=payload).text
        res = json.loads(res)
        encrypted_data = res['data']
        kjson = self.decrypt(encrypted_data)
        kjson1 = json.loads(kjson)
        for i in kjson1['recommend_list']:
            id = i['vod_id']
            name = i['vod_name']
            pic = i['vod_pic']
            remarks = i['vod_remarks']

            video = {
                "vod_id": id,
                "vod_name": name,
                "vod_pic": pic,
                "vod_remarks": remarks
            }
            videos.append(video)
        result = {'list': videos}
        result['page'] = pg
        result['pagecount'] = 9999
        result['limit'] = 90
        result['total'] = 999999
        return result

    def detailContent1(self, kdata, did):
        videos = []
        play_form = ''
        play_url = ''
        kjson = kdata
        actor = kjson['vod']['vod_actor']
        director = kjson['vod'].get('vod_director', '')
        area = kjson['vod']['vod_area']
        name = kjson['vod']['vod_name']
        year = kjson['vod']['vod_year']
        content = kjson['vod']['vod_content']
        subtitle = kjson['vod']['vod_remarks']
        desc = kjson['vod']['vod_lang']
        remark = '时间:' + subtitle + ' 语言:' + desc
        for line in kjson['vod_play_list']:
            keywords = ['防走丢', '群', '防失群', 'Q']
            if any(keyword in line['player_info']['show'] for keyword in keywords):
                continue
            play_form += line['player_info']['show'] + '$$$'
            parse = line['player_info']['parse']
            player_parse_type = line['player_info']['player_parse_type']
            kurls = ""
            for vod in line['urls']:
                kurl = vod['url']
                if '.m3u8' in kurl:
                    kurls += str(vod['name']) + '$' + vod['url'] + '#'
                else:
                    if 'm3u8' not in kurl:
                        token = 'token+' + vod['token']
                        kurls += str(vod['name']) + '$' + parse + ',' + vod[
                            'url'] + ',' + token + ',' + player_parse_type + '#'
            kurls = kurls.rstrip('#')
            play_url += kurls + '$$$'
        play_form = play_form.rstrip('$$$')
        play_url = play_url.rstrip('$$$')
        videos.append({
            "vod_id": did,
            "vod_name": name,
            "vod_actor": actor.replace('演员', ''),
            "vod_director": director.replace('导演', ''),
            "vod_content": content,
            "vod_remarks": remark,
            "vod_year": year + '年',
            "vod_area": area,
            "vod_play_from": play_form,
            "vod_play_url": play_url
        })

        return {'list': videos}

    def detailContent(self, ids):
        did = ids[0]
        payload = {
            'vod_id': did,
        }
        api_endpoints = ['vodDetail', 'vodDetail2']

        for endpoint in api_endpoints:
            url = f'{self.xurl}/{endpoint}'
            response = requests.post(url=url, headers=headerx, data=payload)

            if response.status_code == 200:
                response_data = response.json()
                encrypted_data = response_data['data']
                kjson1 = self.decrypt(encrypted_data)
                kjson = json.loads(kjson1)
                break
        result = self.detailContent1(kjson, did)
        return result

    def playerContent(self, flag, id, vipFlags):
        url = ''
        if 'm3u8' in id:
            url = id
        if 'url=' in id:
            aid = id.split(',')
            uid = aid[0]
            kurl = aid[1]
            kjson = uid + kurl
            url2 = f"{kjson}"
            response = requests.get(url=url2)
            if response.status_code == 200:
                kjson1 = response.json()
                url = kjson1['url']
        else:
            aid = id.split(',')
            bid = aid[-1]
            uid = aid[0]
            kurl = aid[1]
            token = aid[2].replace('token+', '')
            id1 = self.decrypt_wb(kurl)
            payload = {
                'parse_api': uid,
                'url': id1,
                'player_parse_type': bid,
                'token': token
            }
            url1 = f"{self.xurl}/vodParse"
            response = requests.post(url=url1, headers=headerx, data=payload)
            if response.status_code == 200:
                response_data = response.json()
                encrypted_data = response_data['data']
                kjson = self.decrypt(encrypted_data)
                kjson1 = json.loads(kjson)
                kjson2 = kjson1['json']
                kjson3 = json.loads(kjson2)
                url = kjson3['url']
        result = {}
        result["parse"] = 0
        result["playUrl"] = ''
        result["url"] = url
        result["header"] = headerx
        return result

    def searchContentPage(self, key, quick, pg):
        result = {}
        videos = []
        payload = {
            'keywords': key,
            'type_id': "0",
            'page': str(pg)
        }
        url = f'{self.xurl}/searchList'
        response = requests.post(url=url, data=payload, headers=headerx).text
        res = json.loads(response)
        encrypted_data = res['data']
        kjson = self.decrypt(encrypted_data)
        kjson1 = json.loads(kjson)
        for i in kjson1['search_list']:
            id = i['vod_id']
            name = i['vod_name']
            pic = i['vod_pic']
            remarks = i['vod_year'] + ' ' + i['vod_class']

            video = {
                "vod_id": id,
                "vod_name": name,
                "vod_pic": pic,
                "vod_remarks": remarks
            }
            videos.append(video)
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
