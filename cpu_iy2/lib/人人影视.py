# -*- coding: utf-8 -*-
# 本资源来源于互联网公开渠道，仅可用于个人学习爬虫技术。
# 严禁将其用于任何商业用途，下载后请于 24 小时内删除，搜索结果均来自源站，本人不承担任何责任。

import re,sys,json,urllib3
from base.spider import Spider
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)
sys.path.append('..')

class Spider(Spider):
    def_headers,host = {
        'User-Agent': 'rrsp.wang',
        'origin': '*',
        'sec-fetch-dest': 'empty',
        'sec-fetch-mode': 'cors',
        'sec-fetch-site': 'cross-site',
        'sec-ch-ua': '"Not_A Brand";v="8", "Chromium";v="120"',
        'sec-ch-ua-mobile': '?0',
        'sec-ch-ua-platform': '"Windows"',
    },'https://rrsp-api.kejiqianxian.com:60425'
    headers = {
        **def_headers,
        'Accept': 'application/json, text/plain, */*',
        'Content-Type': 'application/json',
        'accept-language': 'zh-CN'
    }

    def homeContent(self, filter):
        return {'class':[{'type_id':'1','type_name':'电影'},{'type_id':'2','type_name':'电视剧'},{'type_id':'3','type_name':'综艺'},{'type_id':'5','type_name':'动漫'},{'type_id':'4','type_name':'纪录片'},{'type_id':'6','type_name':'短剧'},{'type_id':'7','type_name':'特别节目'},{'type_id':'8','type_name':'少儿内容'}]}

    def homeVideoContent(self):
        return self.categoryContent('',1,{},{})

    def categoryContent(self, tid, pg, filter, extend):
        payload = {
            'type': str(tid),
            'sort': 'vod_time',
            'area': '',
            'style': '',
            'time': '',
            'pay': '',
            'page': pg,
            'limit': '60'
        }
        response = self.post(f'{self.host}/api.php/main_program/moviesAll/', data=json.dumps(payload), headers=self.headers, verify=False).json()
        data = response['data']
        return {'list': self.arr2vods(data['list']), 'pagecount':data['pagecount'], 'page': pg}

    def searchContent(self, key, quick, pg='1'):
        if str(pg) != '1': return None
        response = self.post(f'{self.host}/api.php/search/syntheticalSearch/', data=f'{{"keyword": "{key}"}}', headers=self.headers, verify=False).json()
        data = response['data']
        videos = []
        videos.extend(self.arr2vods(data['chasingFanCorrelation']))
        videos.extend(self.arr2vods(data['moviesCorrelation']))
        return {'list': videos, 'page': pg}

    def detailContent(self, ids):
        response = self.post(f'{self.host}/api.php/player/details/', data=f'{{"id": "{ids[0]}"}}', headers=self.headers, verify=False).json()
        data = response['detailData']
        video = {
            'vod_id': data['vod_id'],
            'vod_name': data['vod_name'],
            'vod_pic': data['vod_pic'],
            'vod_remarks': data['vod_remarks'],
            'vod_year': data['vod_year'],
            'vod_area': data['vod_area'],
            'vod_actor': data['vod_actor'],
            'vod_director': data['vod_director'],
            'vod_content': data['vod_content'],
            'vod_play_from': data['vod_play_from'],
            'vod_play_url': data['vod_play_url'],
            'type_name': data['vod_class']
        }
        return {'list': [video]}

    def playerContent(self, flag, vid, vip_flags):
        jx,url = 0,''
        try:
            response = self.post(f'{self.host}/api.php/player/payVideoUrl/',data=f'{{"url":"{vid}"}}', headers=self.headers,timeout=30,verify=False).json()
            play_url = response['data']['url']
            if play_url.startswith('http'): url = play_url
        except Exception:
            pass
        if not url:
            url = vid
            if re.search(r'(?:www\.iqiyi|v\.qq|v\.youku|www\.mgtv|www\.bilibili)\.com', vid): jx = 1
        return { 'jx': jx, 'parse': 0, 'url': url, 'header': {**self.def_headers,'accept-language': 'zh-CN',  'referer':'https://docs.qq.com/'}}

    def arr2vods(self, arr):
        videos = []
        for i in arr:
            if i['vod_serial'] == '1':
                remarks = f"{i['vod_serial']}集"
            else:
                remarks = f"评分：{i.get('vod_score',i.get('vod_douban_score'))}"
            videos.append({
                'vod_id': i['vod_id'],
                'vod_name': i['vod_name'],
                'vod_pic': i['vod_pic'],
                'vod_remarks': remarks,
                'vod_year': None
            })
        return videos

    def init(self, extend=''):
        pass

    def getName(self):
        pass

    def isVideoFormat(self, url):
        pass

    def manualVideoCheck(self):
        pass

    def destroy(self):
        pass

    def localProxy(self, param):
        pass