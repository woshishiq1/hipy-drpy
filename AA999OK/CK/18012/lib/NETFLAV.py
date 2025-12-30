# coding=utf-8
# !/usr/bin/python
import sys
import requests
import json
import re
from base.spider import Spider

sys.path.append('..')
xurl = "https://netflav5.com"
headerx = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.87 Safari/537.36'
}
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

    def homeVideoContent(self):
        videos = []
        try:
            detail = requests.get(url=xurl, headers=headerx, timeout=10)
            detail.encoding = "utf-8"
            source_match = re.search(r'type="application/json">(.*?)</script>', detail.text)
            if source_match:
                json_data = source_match.group(1)
                js1 = json.loads(json_data)
                for item in js1['props']['initialState']['censored']['docs']:
                    name = item['title_zh']
                    id = item['videoId']
                    pic = item['preview_hp']
                    remark = item['sourceDate']
                    video = {
                        "vod_id": id,
                        "vod_name": name,
                        "vod_pic": pic,
                        "vod_remarks": remark
                    }
                    videos.append(video)
            result = {'list': videos}
            return result
        except:
            pass

    def homeContent(self, filter):
        result = {}
        result['class'] = []
        result['class'].append({'type_id': '/trending?', 'type_name': '最受欢迎'})
        result['class'].append({'type_id': '/all?genre=%E5%81%B6%E5%83%8F%E8%97%9D%E4%BA%BA&', 'type_name': '偶像艺人'})
        result['class'].append({'type_id': '/censored?', 'type_name': '日本有码'})
        result['class'].append({'type_id': '/uncensored?', 'type_name': '日本无码'})
        result['class'].append({'type_id': '/chinese-sub?', 'type_name': '中文字幕'})
        result['class'].append({'type_id': '/browse/fc2ppv?', 'type_name': 'FC2PPV'})
        result['class'].append({'type_id': '/browse/1pondo?/amateur_jav?', 'type_name': '素人'})
        result['class'].append({'type_id': '/browse/un_leak?', 'type_name': 'UN-Leak'})
        result['class'].append({'type_id': '/browse/1pondo?', 'type_name': '一本道'})
        result['class'].append({'type_id': '/browse/pacopacomama?', 'type_name': 'パコパコママ 無修正'})
        result['class'].append({'type_id': '/browse/caribbeancompr?', 'type_name': 'Caribbeancompr'})
        result['class'].append({'type_id': '/browse/heyzo?', 'type_name': 'HEYZO'})
        return result

    def categoryContent(self, cid, pg, filter, ext):
        result = {}
        videos = []
        if not pg:
            pg = 1

        url = xurl + cid + "page=" + str(pg)
        detail = requests.get(url=url, headers=headerx, timeout=10)
        detail.encoding = "utf-8"
        source_match = re.search(r'type="application/json">(.*?)</script>', detail.text)
        if source_match:
            json_data = source_match.group(1)
            js1 = json.loads(json_data)
            if 'props' in js1 and 'initialState' in js1['props']:
                initial_state = js1['props']['initialState']
                for key, value in initial_state.items():
                    if value:
                        jz = key
                        jsondata = json.dumps(value)

                        break

            js2 = json.loads(jsondata)

            for item in js2['docs']:
                name = item['title_zh']
                id = item['videoId']
                pic = item['preview_hp']
                remark = item['sourceDate']
                video = {
                    "vod_id": id,
                    "vod_name": name,
                    "vod_pic": pic,
                    "vod_remarks": remark
                }
                videos.append(video)

        result['list'] = videos
        result['page'] = pg
        result['pagecount'] = 9999
        result['limit'] = 90
        result['total'] = 999999
        return result

    def detailContent(self, ids):
        did = ids[0]
        result = {}
        videos = []
        playform = ''
        playurl = ''
        detail = requests.get(url=xurl + '/video?id=' + did, headers=headerx, timeout=10)
        detail.encoding = "utf-8"
        source_match = re.search(r'type="application/json">(.*?)</script>', detail.text)
        xh = 1
        if source_match:
            json_data = source_match.group(1)
            js1 = json.loads(json_data)
            for item in js1['props']['initialState']['video']['data']['srcs']:
                playform = playform + '线路' + str(xh) + '$$$'
                playurl = playurl + item + '$$$'
                xh = xh + 1

            xh = 1
            for item in js1['props']['initialState']['video']['data']['magnets']:
                playform = playform + '磁力' + str(xh) + '$$$'
                playurl = playurl + item['fileSize'] + "$" + item['src'] + '$$$'
                xh = xh + 1
            tx = js1['props']['initialState']['video']['data']['title']
            playform = playform[:-3]
            playurl = playurl[:-3]

        videos.append({
            "vod_id": did,
            "vod_name": tx,
            "vod_pic": "",
            "type_name": "ぃぅおか🍬 คิดถึง",
            "vod_year": "",
            "vod_area": "",
            "vod_remarks": "",
            "vod_actor": "",
            "vod_director": "",
            "vod_content": "",
            "vod_play_from": playform,
            "vod_play_url": playurl
        })

        result['list'] = videos
        return result

    def playerContent(self, flag, id, vipFlags):
        result = {}
        str3 = id
        if 'magnet' in str3:
            result["parse"] = 0
        else:
            result["parse"] = 1
        result["playUrl"] = ''
        result["url"] = str3
        result["header"] = headerx
        return result

    def searchContent(self, key, quick):
        return self.searchContentPage(key, quick, '1')

    def searchContentPage(self, key, quick, page):
        videos = []
        result = {}
        if not page:
            pg = 1
        else:
            pg = page
        
        url = xurl + '/search?keyword=' + key + "&page=" + str(pg) + '&type=title'

        detail = requests.get(url=url, headers=headerx)
        detail.encoding = "utf-8"
        source_match = re.search(r'type="application/json">(.*?)</script>', detail.text)
        if source_match:
            json_data = source_match.group(1)
            js1 = json.loads(json_data)
            for item in js1['props']['initialState']['search']['docs']:
                name = item['title_zh']
                id = item['videoId']
                pic = item['preview_hp']
                remark = item['sourceDate']
                video = {
                    "vod_id": id,
                    "vod_name": name,
                    "vod_pic": pic,
                    "vod_remarks": remark
                }
                videos.append(video)
        result = {'list': videos}

        result['list'] = videos
        result['page'] = pg
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
