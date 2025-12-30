# -*- coding: utf-8 -*-
# @Author  : Doubebly
# @Time    : 2025/4/9 22:22
import base64
import re
import sys
import requests
sys.path.append('..')
from base.spider import Spider



class Spider(Spider):
    def getName(self):
        return "非凡资源"

    def init(self, extend):
        self.home_url = 'http://ffzy5.tv'
        self.headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36'
        }

    def getDependence(self):
        return []

    def isVideoFormat(self, url):
        pass

    def manualVideoCheck(self):
        pass

    def homeContent(self, filter):
        return {
            'class': [{'type_id': '1', 'type_name': '电影片'},
                      {'type_id': '2', 'type_name': '连续剧'},
                      {'type_id': '3', 'type_name': '综艺片'},
                      {'type_id': '4', 'type_name': '动漫片'}],
            'filters': {
                '1': [{'key': 'cid',
                       'name': '分类',
                       'value': [{'n': '动作片', 'v': '6'},
                                 {'n': '喜剧片', 'v': '7'},
                                 {'n': '爱情片', 'v': '8'},
                                 {'n': '科幻片', 'v': '9'},
                                 {'n': '恐怖片', 'v': '10'},
                                 {'n': '剧情片', 'v': '11'},
                                 {'n': '战争片', 'v': '12'},
                                 {'n': '记录片', 'v': '20'},
                                 {'n': '伦理片', 'v': '34'}]}],
                '2': [{'key': 'cid',
                       'name': '分类',
                       'value': [{'n': '国产剧', 'v': '13'},
                                 {'n': '香港剧', 'v': '14'},
                                 {'n': '韩国剧', 'v': '15'},
                                 {'n': '欧美剧', 'v': '16'},
                                 {'n': '台湾剧', 'v': '21'},
                                 {'n': '日本剧', 'v': '22'},
                                 {'n': '海外剧', 'v': '23'},
                                 {'n': '泰国剧', 'v': '24'},
                                 {'n': '短剧', 'v': '36'}]}],
                '3': [{'key': 'cid',
                       'name': '分类',
                       'value': [{'n': '大陆综艺', 'v': '25'},
                                 {'n': '港台综艺', 'v': '26'},
                                 {'n': '日韩综艺', 'v': '27'},
                                 {'n': '欧美综艺', 'v': '28'}]}],
                '4': [{'key': 'cid',
                       'name': '分类',
                       'value': [{'n': '国产动漫', 'v': '29'},
                                 {'n': '日韩动漫', 'v': '30'},
                                 {'n': '欧美动漫', 'v': '31'},
                                 {'n': '港台动漫', 'v': '32'},
                                 {'n': '海外动漫', 'v': '33'}]}]
            }
        }

    def homeVideoContent(self):
        video_list = []
        try:
            res = requests.get(f'{self.home_url}/index.php/ajax/data?mid=1', headers=self.headers)
            data_list = res.json()['list']
            for i in data_list:
                video_list.append(
                    {
                        'vod_id': i['vod_id'],
                        'vod_name': i['vod_name'],
                        'vod_pic': i['vod_pic'],
                        'vod_remarks': i['vod_remarks']
                    }
                )
        except requests.RequestException as e:
            return {
                'list': [],
                'parse': 0,
                'jx': 0
            }

        return {
            'list': video_list,
            'parse': 0,
            'jx': 0
        }

    def categoryContent(self, cid, page, filter, ext):
        cid = ext.get('cid', cid)
        url = f'{self.home_url}/index.php/ajax/data?mid=1&tid={cid}&page={page}&limit=20'
        video_list = []
        try:
            res = requests.get(url,headers=self.headers)
            data_list = res.json()['list']
            for i in data_list:
                video_list.append(
                    {
                        'vod_id': i['vod_id'],
                        'vod_name': i['vod_name'],
                        'vod_pic': i['vod_pic'],
                        'vod_remarks': i['vod_remarks']
                    }
                )
        except requests.RequestException as e:
            return {'list': [], 'msg': e}
        return {'list': video_list, 'parse': 0, 'jx': 0}

    def detailContent(self, did):
        ids = did[0]
        video_list = []
        try:
            res = requests.get(f'{self.home_url}/api.php/provide/vod?ac=detail&ids={ids}', headers=self.headers)
            i = res.json()['list'][0]
            video_list.append(
                {
                    'type_name': i['type_name'],
                    'vod_id': i['vod_id'],
                    'vod_name': i['vod_name'],
                    'vod_remarks': i['vod_remarks'],
                    'vod_year': i['vod_year'],
                    'vod_area': i['vod_area'],
                    'vod_actor': i['vod_actor'],
                    'vod_director': i['vod_director'],
                    'vod_content': i['vod_content'],
                    'vod_play_from': i['vod_play_from'].split('$$$')[-1],
                    'vod_play_url': i['vod_play_url'].split('$$$')[-1],

                }
            )
        except requests.RequestException as e:
            return {'list': [], 'msg': e}
        return {"list": video_list, 'parse': 0, 'jx': 0}

    def searchContent(self, key, quick, page='1'):
        wd = key
        video_list = []
        if page != '1':
            return {'list': video_list, 'parse': 0, 'jx': 0}
        try:
            response = requests.get(f'{self.home_url}/api.php/provide/vod?ac=detail&wd={wd}',headers=self.headers,)
            data_list = response.json()['list']
            for i in data_list:
                video_list.append(
                    {
                        'vod_id': i['vod_id'],
                        'vod_name': i['vod_name'],
                        'vod_pic': i['vod_pic'],
                        'vod_remarks': i['vod_remarks']
                    }
                )
        except requests.RequestException as e:
            return {'list': [], 'msg': e}
        return {'list': video_list, 'parse': 0, 'jx': 0}

    def playerContent(self, flag, pid, vipFlags):
        # url = pid
        url = f'{self.getProxyUrl()}&url={self.b64encode(pid)}'
        return {"url": url, "header": self.headers, "parse": 0, "jx": 0}

    def localProxy(self, params):
        url = self.b64decode(params['url'])
        r = requests.get(url, headers=self.headers)
        a =r.text.strip().split('\n')[-1]
        url = url.replace('index.m3u8', a)
        home_url = url.replace('mixed.m3u8', '')
        try:
            r = requests.get(url, headers=self.headers)
            data = r.text
            c = []
            data_list = data.strip().split('\n')
            for index, data in enumerate(data_list):
                if '#EXT-X-DISCONTINUITY' in data:
                    c.append(index)
            ads = []
            for index, i in enumerate(c[:-1]):
                aa = c[index + 1] - c[index]
                if aa == 17 or aa == 15:
                    # print(data_list[c[index] + 2])
                    # print(c[index + 1] - c[index])
                    ads.append([c[index], c[index + 1]])
            ads.reverse()
            for ad in ads:
                s = ad[0]
                e = ad[1]
                while True:
                    if e < s:
                        break
                    data_list.pop(e)
                    e = e - 1
            text = '\n'.join(data_list)
            m3u8_text = re.sub('(.*ts.*)', home_url + '\\1', text)
            return [200, "application/vnd.apple.mpegurl", m3u8_text]
        except requests.RequestException as e:
            return [302, "text/plain", None, {'Location': url}]


    def destroy(self):
        return '正在Destroy'

    def b64encode(self, data):
        return base64.b64encode(data.encode('utf-8')).decode('utf-8')

    def b64decode(self, data):
        return base64.b64decode(data.encode('utf-8')).decode('utf-8')


if __name__ == '__main__':
    pass
