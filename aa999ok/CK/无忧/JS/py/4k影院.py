# 作者：老王叔叔

import requests
from bs4 import BeautifulSoup
import re
from base.spider import Spider
import sys
import json
import base64
import urllib.parse

sys.path.append('..')

xurl = "https://www.4kvm.net"

headerx = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36 Edg/129.0.0.0'}

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
        result = {"class": [{"type_id": "movies", "type_name": "电影"},
                            {"type_id": "tvshows", "type_name": "剧集"},
                            {"type_id": "trending", "type_name": "热门"}]}

        return result

    def homeVideoContent(self):
        videos = []
        try:
            detail = requests.get(url=xurl, headers=headerx)
            detail.encoding = "utf-8"
            res = detail.text
            doc = BeautifulSoup(res, "lxml")

            soups = doc.find_all('div', class_="items")

            for soup in soups:
                vods = soup.find_all('article', class_="item")

                for vod in vods:
                    names = vod.find('div', class_="poster")
                    name = names.find('img')['alt']

                    ids = vod.find('div', class_="poster")
                    id = ids.find('a')['href']

                    pics = vod.find('div', class_="poster")
                    pic = pics.find('img')['src']

                    remark = self.extract_middle_text(str(vod), '<div class="upinfo">', '</div>', 0)

                    video = {
                        "vod_id": id,
                        "vod_name":  name,
                        "vod_pic": pic,
                        "vod_remarks":  remark
                    }
                    videos.append(video)

            result = {'list': videos}
            return result
        except:
            pass

    def categoryContent(self, cid, pg, filter, ext):
        result = {}
        if pg:
            page = int(pg)
        else:
            page = 1
        page = int(pg)
        videos = []

        if page == '1':
            url = f'{xurl}/{cid}'

        else:
            url = f'{xurl}/{cid}/page/{str(page)}'

        try:
            detail = requests.get(url=url, headers=headerx)
            detail.encoding = "utf-8"
            res = detail.text
            doc = BeautifulSoup(res, "lxml")

            soups = doc.find_all('div', class_="poster")

            for vod in soups:

                name = vod.find('img')['alt']

                id = vod.find('a')['href']

                pic = vod.find('img')['src']

                remark = self.extract_middle_text(str(vod), 'class="update">', '</div>', 0)

                video = {
                    "vod_id": id,
                    "vod_name": name,
                    "vod_pic": pic,
                    "vod_remarks": remark
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
        playurl = ''
        if 'http' not in did:
            did = xurl + did

        if 'tvshows' in did or 'trending' in did:
            tiaozhuan = '1'
        elif 'movies' in did:
            tiaozhuan = '2'

        if tiaozhuan == '1':
            res1 = requests.get(url=did, headers=headerx)
            res1.encoding = "utf-8"
            res = res1.text
            did = self.extract_middle_text(res, '<h2>播放列表</h2>', '</div>', 1, 'href="(.*?)"')
            if 'http' not in did:
                did = xurl + did
            res1 = requests.get(url=did, headers=headerx)
            res1.encoding = "utf-8"
            res = res1.text
            bofang = self.extract_middle_text(res, "videourls:[", "],", 0, )
            id = self.extract_middle_text(res, "t single single-seasons postid-", '"', 0, )
            array = json.loads(bofang)
            purl = ''
            for vod in array:
                name = vod['name']
                js = vod['url']
                purl = purl + str(name) + '$' + xurl + '/artplayer?id=' + id + '&source=0&ep=' + str(js) + '#'
            purl = purl[:-1]

        if tiaozhuan == '2':
            res1 = requests.get(url=did, headers=headerx)
            res1.encoding = "utf-8"
            res = res1.text
            id = self.extract_middle_text(res, "single single-movies postid-", '"', 0, )
            name = self.extract_middle_text(res, "</i><span class='title'>", '</span>', 0, )
            purl = ''
            purl = purl + str(name) + '$' + xurl + '/artplayer?mvsource=0&id=' + id + '&type=hls'

        content = self.extract_middle_text(res, '<p>', '</p>',0)

        videos.append({
            "vod_id": did,
            "vod_actor": '',
            "vod_director": '',
            "vod_content": content,
            "vod_play_from": '專線',
            "vod_play_url": purl
        })

        result['list'] = videos
        return result

    def playerContent(self, flag, id, vipFlags):
        parts = id.split("http")
        xiutan = 0
        if xiutan == 0:
            if len(parts) > 1:
                before_https, after_https = parts[0], 'http' + parts[1]

            res = requests.get(url=after_https, headers=headerx)
            res = res.text

            url = self.extract_middle_text(res, 'fetch("', '"', 0).replace('\\', '')

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
            url = f'{xurl}/xssearch?s={key}'

        else:
            url = f'{xurl}/xssearch?s={key}'

        detail = requests.get(url=url, headers=headerx)
        detail.encoding = "utf-8"
        res = detail.text
        doc = BeautifulSoup(res, "lxml")

        soups = doc.find_all('div', class_="result-item")

        for vod in soups:
            names = vod.find('div', class_="title")
            name = names.find('a').text

            id = vod.find('a')['href']

            pic = vod.find('img')['src']

            remark = self.extract_middle_text(str(vod), 'class="rating">', '</span>', 0)

            video = {
                "vod_id": id,
                "vod_name": name,
                "vod_pic": pic,
                "vod_remarks": remark
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



