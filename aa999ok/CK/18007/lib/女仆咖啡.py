import requests
from bs4 import BeautifulSoup
from urllib.parse import unquote
import re
from base.spider import Spider
import sys
import json
import base64
import urllib.parse

sys.path.append('..')

xurl = "https://a3b4c5d6.npkf56.buzz"

headerx = {
  'User-Agent': "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36"
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
        result = {"class": [
{"type_id": "20", "type_name": "网曝黑料"},
{"type_id": "1", "type_name": "国产传媒"},
{"type_id": "2", "type_name": "国产剧情"},
{"type_id": "3", "type_name": "必射精选"},
{"type_id": "4", "type_name": "精品资源"},
{"type_id": "5", "type_name": "特色仓库"},
{"type_id": "15", "type_name": "中文字幕"},
{"type_id": "170", "type_name": "华语AV"},
{"type_id": "27", "type_name": "精东影业"},
{"type_id": "21", "type_name": "麻豆视频"},
{"type_id": "33", "type_name": "mini传媒"},
{"type_id": "35", "type_name": "开心鬼传媒"},
{"type_id": "37", "type_name": "糖心Vlog"},
{"type_id": "45", "type_name": "欧美无码"},
{"type_id": "41", "type_name": "中文字幕"},
{"type_id": "54", "type_name": "伦理三级"},
{"type_id": "59", "type_name": "女同性恋"},
{"type_id": "56", "type_name": "SM调教"},
{"type_id": "146", "type_name": "巨乳中文"},
{"type_id": "148", "type_name": "制服中文"}]}

        return result

    def homeVideoContent(self):
        videos = []
        try:
            detail = requests.get(url='https://a3b4c5d6.npkf56.buzz/topic/', headers=headerx)
            detail.encoding = "utf-8"
            res = detail.text
            doc = BeautifulSoup(res, "html.parser")

            soups = doc.find_all('ul', class_="content-list")

            for soup in soups:

                vods = soup.find_all('a', class_="video-pic loading")

                for vod in vods:

                    name = vod['title']
                  
                    id = vod['href']

                    pic = vod.find('img')['data-original']
                    if 'http' not in pic:
                        pic = xurl + pic

                    remarks = vod.find('span', class_="note")
                    if remarks:
                        remark = remarks.text.strip()
                    else:
                        remark = ""

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

    def categoryContent(self, cid, pg, filter, ext):
        result = {}
        videos = []
        if pg:
            page = int(pg)
        else:
            page = 1

        if page == '1':

            url = f'{xurl}/vodtype/{cid}.html'
        else:
            url = f'{xurl}/vodtype/{cid}-{str(page)}.html'

        try:
            detail = requests.get(url=url, headers=headerx)
            detail.encoding = "utf-8"
            res = detail.text
            doc = BeautifulSoup(res, "html.parser")

            soups = doc.find_all('ul', class_="content-list")

            for soup in soups:

                vods = soup.find_all('a', class_="video-pic loading")


                for vod in vods:


                    name = vod['title']
                  


                    id = vod['href']


                    pic = vod.find('img')['data-original']
                    if 'http' not in pic:
                        pic = xurl + pic


                    remarks = vod.find('span', class_="note")
                    if remarks:
                        remark = remarks.text.strip()
                    else:
                        remark = ""


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
            
        res1 = requests.get(url=did, headers=headerx)
        res1.encoding = "utf-8"
        res = res1.text
       
        content = '📢请勿相信剧中广告'

        xianlu = '播放线路'

        bofang = self.extract_middle_text(res, '<table class="playlistlink-4 list-15256 clearfix">', '</table>', 3,'href="(.*?)" target="_blank">(.*?)</a>')


        videos.append({
            "vod_id": did,
            "vod_actor": '😸你猜 😸你猜',
            "vod_director": '😸你猜',
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
            res = requests.get(url=after_https, headers=headerx)
            res = res.text

            url = self.extract_middle_text(res, '"},"url":"', '"', 0).replace('\\', '')
            url = unquote(url)
            print(url)
            
           

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
            url = f'{xurl}/vodsearch/-------------.html?wd={key}'
        else:
            url = f'{xurl}/vodsearch/{key}----------{str(page)}---.html'
        detail = requests.get(url=url, headers=headerx)
        detail.encoding = "utf-8"
        res = detail.text
        doc = BeautifulSoup(res, "lxml")
        soups = doc.find_all('ul', class_="content-list")
    
        for soup in soups:
            vods = soup.find_all('a', class_="video-pic loading")
            for vod in vods:
                name = vod['title']
                id = vod['href']
                pic = vod.find('img')['data-original']
                remarks = vod.find('span', class_="note")
                remark = remarks.text.strip()
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