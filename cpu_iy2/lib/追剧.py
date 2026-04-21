# -*- coding: utf-8 -*-
# 恒轩：https://www.jubaba.vip/
import json
import random
import re
import sys
from base64 import b64decode, b64encode
import requests
from Crypto.Hash import MD5
from pyquery import PyQuery as pq

sys.path.append('..')
from base.spider import Spider


class Spider(Spider):
    def init(self, extend=""):
        self.host = "https://www.jubaba.cc"
        self.headers.update({
            'referer': f'{self.host}/',
            'origin': self.host,
        })
        self.session = requests.Session()
        self.session.headers.update(self.headers)
        self.session.get(self.host)

    def getName(self):
        pass

    def isVideoFormat(self, url):
        pass

    def manualVideoCheck(self):
        pass

    def destroy(self):
        pass

    headers = {
        'User-Agent': 'Mozilla/5.0 (iPad; CPU OS 16_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6 Mobile/15E148 Safari/604.1',
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7',
        'sec-ch-ua': '"Not/A)Brand";v="8", "Chromium";v="134", "Google Chrome";v="134"',
        'sec-ch-ua-mobile': '?0',
        'sec-ch-ua-platform': '"macOS"',
        'sec-fetch-site': 'same-origin',
        'sec-fetch-mode': 'navigate',
        'sec-fetch-user': '?1',
        'sec-fetch-dest': 'document',
        'accept-language': 'zh-CN,zh;q=0.9,en;q=0.8',
    }

    config = {
        "1": [
            {"key": "by", "name": "排序",
             "value": [{"n": "时间", "v": "time"}, {"n": "人气", "v": "hits"}, {"n": "评分", "v": "score"}]}],
        "2": [
            {"key": "by", "name": "排序",
             "value": [{"n": "时间", "v": "time"}, {"n": "人气", "v": "hits"}, {"n": "评分", "v": "score"}]}],
        "3": [
            {"key": "by", "name": "排序",
             "value": [{"n": "时间", "v": "time"}, {"n": "人气", "v": "hits"}, {"n": "评分", "v": "score"}]}],
        "4": [
            {"key": "by", "name": "排序",
             "value": [{"n": "时间", "v": "time"}, {"n": "人气", "v": "hits"}, {"n": "评分", "v": "score"}]}],
    }

    def clean_vod_name(self, raw_name):
        
        clean_name = re.sub(r'年番\d+$|第[一二三四五六七八九十\d]+季$|\d+$|:.*$', '', raw_name).strip()
        return clean_name

    def homeContent(self, filter):
        data = self.getpq()
        result = {}
        classes = []
        for k in data('ul.swiper-wrapper').eq(0)('li').items():
            i = k('a').attr('href')
            if i and 'type' in i:
                type_name = k.text().strip()

                if type_name == '推荐':
                    type_name = '恒轩'
                classes.append({
                    'type_name': type_name,
                    'type_id': re.findall(r'\d+', i)[0],
                })
        result['class'] = classes
        result['list'] = self.getlist(data('.tab-content.ewave-pannel_bd li'))
        result['filters'] = self.config
        return result

    def homeVideoContent(self):
        pass

    def categoryContent(self, tid, pg, filter, extend):
        path = f"/vodshow/{tid}-{extend.get('area', '')}-{extend.get('by', '')}-{extend.get('class', '')}-----{pg}---{extend.get('year', '')}.html"
        data = self.getpq(path)
        result = {}
        result['list'] = self.getlist(data('ul.ewave-vodlist.clearfix li'))
        result['page'] = pg
        result['pagecount'] = 9999
        result['limit'] = 90
        result['total'] = 999999
        return result

    def detailContent(self, ids):
        data = self.getpq(f"/voddetail/{ids[0]}.html")
        v = data('.ewave-content__detail')
        c = data('p')

        raw_vod_name = v('h1').text()
        clean_vod_name = self.clean_vod_name(raw_vod_name)

        vod = {
            'type_name': c.eq(0)('a').text(),
            'vod_year': v('.data.hidden-sm').text(),
            'vod_remarks': clean_vod_name,
            'vod_actor': c.eq(1)('a').text(),
            'vod_director': c.eq(2)('a').text(),
            'vod_content': v('.desc.hidden-xs').text(),
            'vod_play_from': '',
            'vod_play_url': ''
        }

        nd = list(data('ul.nav-tabs.swiper-wrapper li').items())
        pd = list(data('ul.ewave-content__playlist').items())

        line_priority = ['自营b', '自营e', '自营c', '自营c', '自营d', 'LZ有广', 'BF有广', 'YZ有广']
        play_url = ''
        for line in line_priority:
            for idx, line_name_ele in enumerate(nd):
                current_line = line_name_ele.text().strip()
                if current_line == line and pd[idx]('li').items():
                    play_url = '#'.join([f"{j.text()}${j('a').attr('href')}" for j in pd[idx]('li').items()])
                    break
            if play_url:
                break

        vod['vod_play_from'] = '追剧'
        vod['vod_play_url'] = play_url if play_url else ''
        return {'list': [vod]}

    def searchContent(self, key, quick, pg="1"):
        if pg == "1":
            p = f"-------------.html?wd={key}"
        else:
            p = f"{key}----------{pg}---.html"
        data = self.getpq(f"/vodsearch/{p}")
        return {'list': self.getlist(data('ul.ewave-vodlist__media.clearfix li')), 'page': pg}

    def playerContent(self, flag, id, vipFlags):
        try:
            data = self.getpq(id)
            jstr = json.loads(data('.ewave-player__video script').eq(0).text().split('=', 1)[-1])
            jxpath = '/bbplayer/api.php'
            data = self.session.post(f"{self.host}{jxpath}", data={'vid': jstr['url']}).json()['data']
            if re.search(r'\.m3u8|\.mp4', data['url']):
                url = data['url']
            elif data['urlmode'] == 1:
                url = self.decode1(data['url'])
            elif data['urlmode'] == 2:
                url = self.decode2(data['url'])
            elif re.search(r'\.m3u8|\.mp4', jstr['url']):
                url = jstr['url']
            else:
                url = None
            if not url: raise Exception('未找到播放地址')
            p, c = 0, ''
        except Exception as e:
            self.log(f"解析失败: {e}")
            p, url, c = 1, f"{self.host}{id}", 'document.querySelector("#playleft iframe").contentWindow.document.querySelector("#start").click()'
        return {'parse': p, 'url': url, 'header': {'User-Agent': 'okhttp/3.12.1'}, 'click': c}

    def localProxy(self, param):
        wdict = json.loads(self.d64(param['wdict']))
        url = f"{wdict['jx']}{wdict['id']}"
        data = pq(self.fetch(url, headers=self.headers).text)
        html = data('script').eq(-1).text()
        url = re.search(r'src="(.*?)"', html).group(1)
        return [302, 'text/html', None, {'Location': url}]

    def liveContent(self, url):
        pass

    def getpq(self, path='', min=0, max=3):
        data = self.session.get(f"{self.host}{path}")
        data = data.text
        try:
            if '人机验证' in data:
                print(f"第{min}次尝试人机验证")
                jstr = pq(data)('script').eq(-1).html()
                token, tpath, stt = self.extract(jstr)
                body = {'value': self.encrypt(self.host, stt), 'token': self.encrypt(token, stt)}
                cd = self.session.post(f"{self.host}{tpath}", data=body)
                if min > max: raise Exception('人机验证失败')
                return self.getpq(path, min + 1, max)
            return pq(data)
        except:
            return pq(data.encode('utf-8'))

    def encrypt(self, input_str, staticchars):
        encodechars = ""
        for char in input_str:
            num0 = staticchars.find(char)
            if num0 == -1:
                code = char
            else:
                code = staticchars[(num0 + 3) % 62]
            num1 = random.randint(0, 61)
            num2 = random.randint(0, 61)
            encodechars += staticchars[num1] + code + staticchars[num2]
        return self.e64(encodechars)

    def extract(self, js_code):
        token_match = re.search(r'var token = encrypt\("([^"]+)"\);', js_code)
        token_value = token_match.group(1) if token_match else None
        url_match = re.search(r'var url = \'([^\']+)\';', js_code)
        url_value = url_match.group(1) if url_match else None
        staticchars_match = re.search(r'var\s+staticchars\s*=\s*["\']([^"\']+)["\'];', js_code)
        staticchars = staticchars_match.group(1) if staticchars_match else None
        return token_value, url_value, staticchars

    def decode1(self, val):
        url = self._custom_str_decode(val)
        parts = url.split("/")
        result = "/".join(parts[2:])
        key1 = json.loads(self.d64(parts[1]))
        key2 = json.loads(self.d64(parts[0]))
        decoded = self.d64(result)
        return self._de_string(key1, key2, decoded)

    def _custom_str_decode(self, val):
        decoded = self.d64(val)
        key = self.md5("test")
        result = ""
        for i in range(len(decoded)):
            result += chr(ord(decoded[i]) ^ ord(key[i % len(key)]))
        return self.d64(result)

    def _de_string(self, key_array, value_array, input_str):
        result = ""
        for char in input_str:
            if re.match(r'^[a-zA-Z]$', char):
                if char in key_array:
                    index = key_array.index(char)
                    result += value_array[index]
                    continue
            result += char
        return result

    def decode2(self, url):
        key = "PXhw7UT1B0a9kQDKZsjIASmOezxYG4CHo5Jyfg2b8FLpEvRr3WtVnlqMidu6cN"
        url = self.d64(url)
        result = ""
        i = 1
        while i < len(url):
            try:
                index = key.find(url[i])
                if index == -1:
                    char = url[i]
                else:
                    char = key[(index + 59) % 62]
                result += char
            except IndexError:
                break
            i += 3
        return result

    def getlist(self, data):
        videos = []
        for k in data.items():
            j = k('.ewave-vodlist__thumb')
            h = k('.text-overflow a')
            if not h.attr('href'): h = j

            raw_name = j.attr('title')
            clean_name = self.clean_vod_name(raw_name)
            videos.append({
                'vod_id': re.findall(r'\d+', h.attr('href'))[0],
                'vod_name': clean_name,
                'vod_pic': j.attr('data-original'),
                'vod_remarks': k('.pic-text').text(),
            })
        return videos

    def e64(self, text):
        try:
            text_bytes = text.encode('utf-8')
            encoded_bytes = b64encode(text_bytes)
            return encoded_bytes.decode('utf-8')
        except Exception as e:
            print(f"Base64编码错误: {str(e)}")
            return ""

    def d64(self, encoded_text):
        try:
            encoded_bytes = encoded_text.encode('utf-8')
            decoded_bytes = b64decode(encoded_bytes)
            return decoded_bytes.decode('utf-8')
        except Exception as e:
            print(f"Base64解码错误: {str(e)}")
            return ""

    def md5(self, text):
        h = MD5.new()
        h.update(text.encode('utf-8'))
        return h.hexdigest()
