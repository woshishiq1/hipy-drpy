# coding=utf-8
# !/usr/bin/python
import sys
import time
import json
import requests
from Crypto.Cipher import AES
from Crypto.PublicKey import RSA
from Crypto.Cipher import PKCS1_v1_5
from Crypto.Util.Padding import pad, unpad
from base64 import b64decode
from urllib.parse import quote
from hashlib import md5
sys.path.append('..')
from base.spider import Spider

publicKey = """-----BEGIN PUBLIC KEY-----
MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGAe6hKrWLi1zQmjTT1
ozbE4QdFeJGNxubxld6GrFGximxfMsMB6BpJhpcTouAqywAFppiKetUBBbXwYsYU
1wNr648XVmPmCMCy4rY8vdliFnbMUj086DU6Z+/oXBdWU3/b1G0DN3E9wULRSwcK
ZT3wj/cCI1vsCm3gj2R5SqkA9Y0CAwEAAQKBgAJH+4CxV0/zBVcLiBCHvSANm0l7
HetybTh/j2p0Y1sTXro4ALwAaCTUeqdBjWiLSo9lNwDHFyq8zX90+gNxa7c5EqcW
V9FmlVXr8VhfBzcZo1nXeNdXFT7tQ2yah/odtdcx+vRMSGJd1t/5k5bDd9wAvYdI
DblMAg+wiKKZ5KcdAkEA1cCakEN4NexkF5tHPRrR6XOY/XHfkqXxEhMqmNbB9U34
saTJnLWIHC8IXys6Qmzz30TtzCjuOqKRRy+FMM4TdwJBAJQZFPjsGC+RqcG5UvVM
iMPhnwe/bXEehShK86yJK/g/UiKrO87h3aEu5gcJqBygTq3BBBoH2md3pr/W+hUM
WBsCQQChfhTIrdDinKi6lRxrdBnn0Ohjg2cwuqK5zzU9p/N+S9x7Ck8wUI53DKm8
jUJE8WAG7WLj/oCOWEh+ic6NIwTdAkEAj0X8nhx6AXsgCYRql1klbqtVmL8+95KZ
K7PnLWG/IfjQUy3pPGoSaZ7fdquG8bq8oyf5+dzjE/oTXcByS+6XRQJAP/5ciy1b
L3NhUhsaOVy55MHXnPjdcTX0FaLi+ybXZIfIQ2P4rb19mVq1feMbCXhz+L1rG8oa
t5lYKfpe8k83ZA==
-----END PUBLIC KEY-----"""

class Spider(Spider):

    headers = {
        'Cache-Control': 'no-cache',
        'Version': '2406025',
        'PackageName': 'com.uf076bf0c246.qe439f0d5e.m8aaf56b725a.ifeb647346f',
        'Ver': '1.9.2',
        'Referer': 'https://api.8utdtcq.com',
        'X-Customer-Client-Ip': '127.0.0.1',
        'Content-Type': 'application/x-www-form-urlencoded',
        'Host': 'api.8utdtcq.com',
        'Connection': 'Keep-Alive',
        'User-Agent': 'okhttp/3.12.0'
    }

    def init(self, extend="{}"):
        pass

    def getName(self):
        pass

    def isVideoFormat(self, url):
        pass

    def manualVideoCheck(self):
        pass

    def destroy(self):
        pass

    def homeContent(self, filter):
        result = {}
        classes = [{'type_name': '女主播', 'type_id': 'girls'}, {'type_name': '情侣', 'type_id': 'couples'}, {'type_name': '男主播', 'type_id': 'men'}]
        filters = {
            'girls': [{'key': 'tag', 'value': [{'n': '中国', 'v': 'tagLanguageChinese'}, {'n': '美国', 'v': 'tagLanguageUSModels'}]}],
            'couples': [{'key': 'tag', 'value': [{'n': '中国', 'v': 'tagLanguageChinese'}, {'n': '美国', 'v': 'tagLanguageUSModels'}]}],
            'men': [{'key': 'tag', 'value': [{'n': '中国', 'v': 'tagLanguageChinese'}, {'n': '美国', 'v': 'tagLanguageUSModels'}, {'n': '情侣', 'v': 'sexGayCouples'}, {'n': '直男', 'v': 'orientationStraight'}]}]
        }
        result['class'] = classes
        result['filters'] = filters
        return result

    def homeVideoContent(self):
        pass

    def categoryContent(self, tid, pg, filter, extend):
        return {}

    def detailContent(self, array):
        vid = array[0]
        session = requests.Session()
        url = "https://api.8utdtcq.com/App/IndexPlay/playInfo"
        timestamp = int(time.time())
        timestamp = str(timestamp)

        src = f'{{"token_id": "393668","vod_id": "{vid}","mobile_time": "{timestamp}","token": "1be86e8e18a9fa18b2b8d5432699dad0.ac008ed650fd087bfbecf2fda9d82e9835253ef24843e6b18fcd128b10763497bcf9d53e959f5377cde038c20ccf9d17f604c9b8bb6e61041def86729b2fc7408bd241e23c213ac57f0226ee656e2bb0a583ae0e4f3bf6c6ab6c490c9a6f0d8cdfd366aacf5d83193671a8f77cd1af1ff2e9145de92ec43ec87cf4bdc563f6e919fe32861b0e93b118ec37d8035fbb3c.59dd05c5d9a8ae726528783128218f15fe6f2c0c8145eddab112b374fcfe3d79"}}'
        src = self.encrypt(src)

        keys = "Qmxi5ciWXbQzkr7o+SUNiUuQxQEf8/AVyUWY4T/BGhcXBIUz4nOyHBGf9A4KbM0iKF3yp9M7WAY0rrs5PzdTAOB45plcS2zZ0wUibcXuGJ29VVGRWKGwE9zu2vLwhfgjTaaDpXo4rby+7GxXTktzJmxvneOUdYeHi+PZsThlvPI="
        postBody = self.getSignature(src, keys, timestamp)

        r = session.post(url, headers=self.headers, data=postBody)
        banner = r.json()['data']
        responseKey = banner['response_key']
        bodyKeyIV = json.loads(self.rsaDecrypt(banner['keys'], publicKey))
        html = self.decrypt(responseKey, bodyKeyIV['key'], bodyKeyIV['iv'])

        info = json.loads(html)['vodInfo']
        name = info["vod_name"]
        pic = info['vod_pic']
        dire = info['vod_director']
        area = info['vod_area']
        actors = info['vod_actor']
        content = info['vod_use_content'].strip()
        video = {
            "vod_id": vid,
            "vod_name": name,
            "vod_pic": pic,
            "vod_director": dire,
            "vod_area": area,
            "vod_actor": actors,
            "vod_content": content,
            'vod_play_from': "瓜子"
        }

        src = f'{{"vurl_cloud_id":"2","vod_d_id": "{vid}"}}'
        src = self.encrypt(src)
        postBody = self.getSignature(src, keys, timestamp)
        url = "https://api.8utdtcq.com/App/Resource/Vurl/show"

        r = session.post(url, headers=self.headers, data=postBody)
        banner = r.json()['data']
        responseKey = banner['response_key']

        bodyKeyIV = json.loads(self.rsaDecrypt(banner['keys'], publicKey))
        html = self.decrypt(responseKey, bodyKeyIV['key'], bodyKeyIV['iv'])
        vods = json.loads(html)['list']
        playUrls = ""
        for vod in vods:
            playUrl = ""
            uid = vod['id']
            for resolution, urls in vod['play'].items():
                if urls['param'] == "":
                    continue
                playUrl += f'"{resolution}P","{{"vid":"{vid}","uid":"{uid}","resolution":"{resolution}"}}",'
            playUrls += f"{vod['title']}$[{playUrl.strip(',')}]#"
        playUrls = playUrls.strip("#")
        video["vod_play_url"] = playUrls
        result = {'list': [video]}
        return result

    def searchContent(self, key, quick, pg):
        videos = []
        url = "https://api.8utdtcq.com/App/Index/findMoreVod"
        src = f'{{"keywords": "{key}", "order_val": "1"}}'
        src = self.encrypt(src)
        timestamp = int(time.time())
        timestamp = str(timestamp)
        keys = "qDpotE2bedimK3QGqlyV5ieXXC3EhaPLQ+IOJyHnHflCj5w/7ESK7FgywMvrgjxbx0GklEFLI4+JshgySe633OIRstuktwdiCy3CT+fLSpuxBJDIlfXQDaeH3ig1wiB0JsZ601XHiFweGMu4tZfnSpHg3OnoL6nz/uurUif2OK4="
        postBody = self.getSignature(src, keys, timestamp)
        r = requests.post(url, headers=self.headers, data=postBody)
        banner = r.json()['data']
        responseKey = banner['response_key']
        keys = banner['keys']
        bodyKeyIV = json.loads(self.rsaDecrypt(keys, publicKey))
        html = self.decrypt(responseKey, bodyKeyIV['key'], bodyKeyIV['iv'])
        vodList = json.loads(html)["list"]
        for vod in vodList:
            vid = vod['vod_id']
            pic = vod['vod_pic']
            name = vod['vod_name']
            year = vod['vod_addtime']
            remark = '电影' if vod['vod_continu'] == 0 else f'更新至{vod["vod_continu"]}集'
            videos.append({
                'vod_id': vid,
                'vod_name': name,
                'vod_pic': pic,
                'vod_year': year,
                'vod_remarks': remark
            })
        return {'list': videos,'page': pg}

    def playerContent(self, flag, pid, vipFlags):
        params = json.loads(pid)
        vid = params["vid"]
        uid = params["uid"]
        resolution = params["resolution"]
        src = f'{{"domain_type":"8","vod_id": "{vid}","type":"play","resolution": "{resolution}","vurl_id": "{uid}"}}'
        timestamp = int(time.time())
        timestamp = str(timestamp)
        src = self.encrypt(src)
        keys = "ZH8gpdp9bxjuG2NK97sol3o7Uiz+9eVEaVMlE2Fk3j7EResM3YHnECZUH7BONNTjpy7RVNi/YimGuNYriC7Cmswv4PNYiFYzw9QhlqZKwNfCM6IUpFZ0T4rZx8G78zkv2tNVbfYC4qNQedGi07nWZ33dlSuVxROVfY5JxOWHMI0="
        postBody = self.getSignature(src, keys, timestamp)
        url = "https://api.8utdtcq.com/App/Resource/VurlDetail/showOne"
        r = requests.post(url, headers=self.headers, data=postBody)
        banner = r.json()['data']
        responseKey = banner['response_key']
        bodyKeyIV = json.loads(self.rsaDecrypt(banner['keys'], publicKey))
        html = self.decrypt(responseKey, bodyKeyIV['key'], bodyKeyIV['iv'])
        url = json.loads(html)['url']

        result = {}
        result["url"] = url
        result["parse"] = '0'
        result["contentType"] = ''
        result["header"] = self.headers
        return result

    def localProxy(self, param):
        pass

    def getSignature(self, src, keys, timestamp):
        signature = f'token_id=,token=1be86e8e18a9fa18b2b8d5432699dad0.ac008ed650fd087bfbecf2fda9d82e9835253ef24843e6b18fcd128b10763497bcf9d53e959f5377cde038c20ccf9d17f604c9b8bb6e61041def86729b2fc7408bd241e23c213ac57f0226ee656e2bb0a583ae0e4f3bf6c6ab6c490c9a6f0d8cdfd366aacf5d83193671a8f77cd1af1ff2e9145de92ec43ec87cf4bdc563f6e919fe32861b0e93b118ec37d8035fbb3c.59dd05c5d9a8ae726528783128218f15fe6f2c0c8145eddab112b374fcfe3d79,phone_type=1,request_key={src},app_id=1,time={timestamp},keys={keys}*&zvdvdvddbfikkkumtmdwqppp?|4Y!s!2br'
        signature = md5(signature.encode()).hexdigest()
        return f'token=1be86e8e18a9fa18b2b8d5432699dad0.ac008ed650fd087bfbecf2fda9d82e9835253ef24843e6b18fcd128b10763497bcf9d53e959f5377cde038c20ccf9d17f604c9b8bb6e61041def86729b2fc7408bd241e23c213ac57f0226ee656e2bb0a583ae0e4f3bf6c6ab6c490c9a6f0d8cdfd366aacf5d83193671a8f77cd1af1ff2e9145de92ec43ec87cf4bdc563f6e919fe32861b0e93b118ec37d8035fbb3c.59dd05c5d9a8ae726528783128218f15fe6f2c0c8145eddab112b374fcfe3d79&token_id=&phone_type=1&time={timestamp}&phone_model=xiaomi-22021211rc&keys={quote(keys, safe="")}&request_key={src}&signature={signature}&app_id=1&ad_version=1'

    # RSA解密函数
    def rsaDecrypt(self, src, publicKey):
        key = RSA.import_key(publicKey)
        cipher = PKCS1_v1_5.new(key)
        decrypted = cipher.decrypt(b64decode(src), None)
        return decrypted.decode('utf-8')

    # AES加密函数
    def encrypt(self, src):
        key = "mvXBSW7ekreItNsT".encode('utf-8')
        iv = "2U3IrJL8szAKp0Fj".encode('utf-8')
        cipher = AES.new(key, AES.MODE_CBC, iv)
        padded_data = pad(src.encode('utf-8'), AES.block_size)
        encrypted = cipher.encrypt(padded_data)
        return encrypted.hex().upper()

    # AES解密函数
    def decrypt(self, src, key, iv):
        cipher = AES.new(key.encode('utf-8'), AES.MODE_CBC, iv.encode('utf-8'))
        encrypted_hex = bytes.fromhex(src)
        decrypted = cipher.decrypt(encrypted_hex)
        return unpad(decrypted, AES.block_size).decode('utf-8')

