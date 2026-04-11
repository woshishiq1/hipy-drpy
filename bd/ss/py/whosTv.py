import sys
import re
import requests
from bs4 import BeautifulSoup
from base.spider import Spider
from urllib.parse import urljoin, quote,unquote

class Spider(Spider):
    def getName(self):
        return "WhosTV"

    def init(self, extend=""):
        self.host = "https://whos.tv"
        self.header = {
            "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36",
            "Referer": self.host
        }

    def _decode_cover(self, encoded):
        """解密 data-cover-src（还原前端 coolDecrypt 函数）"""
        if not encoded:
            return ""
        try:
            key_hex = encoded[-2:]
            key = int(key_hex, 16)
            data_hex = encoded[:-2]
            chars = []
            for i in range(0, len(data_hex), 2):
                byte_val = int(data_hex[i:i+2], 16)
                chars.append(chr(byte_val ^ key))
            return ''.join(chars)
        except:
            return ""


    def homeContent(self, filter):
        result = {}
        result['class'] = [
            {'type_name': '影片库', 'type_id': '/videos'},
            {'type_name': '女优库', 'type_id': '/actresses'}
        ]
        return result

    def categoryContent(self, tid, pg, filter, extend):
        result = {}
        url = f"{self.host}{tid}"
        if int(pg) > 1:
            url += f"/page-{pg}"

        rsp = self.fetch(url, headers=self.header)
        soup = BeautifulSoup(rsp.text, 'html.parser')
        videos = []

        # 女优名录页
        if tid == "/actresses":
            items = soup.find_all('a', href=re.compile(r'^/actresses/.'))
            for item in items:
                img = item.find('img')
                if not img:
                    continue
                name = img.get('alt', '').strip()
                href = item.get('href')
                if not name or href == "/actresses" or "page-" in href:
                    continue
                pic_url = img.get('src', '')
                count_text = ""
                icon_span = item.find('span', class_=re.compile(r'icon-\[lucide--film\]'))
                if icon_span:
                    parent_flex = icon_span.find_parent('span', class_='flex')
                    if parent_flex:
                        count_text = parent_flex.get_text(strip=True) + "部作品"
                videos.append({
                    "vod_id": href,
                    "vod_name": name,
                    "vod_pic": pic_url,
                    "vod_remarks": count_text if count_text else "作品集",
                    "vod_tag": "folder"
                })
        # 影片网格页（包括女优个人页的作品列表）
        else:
            items = soup.find_all('a', href=re.compile(r'^/videos/.'))
            for item in items:
                h3 = item.find('h3')
                v_name = h3.get_text(strip=True) if h3 else item.get('alt', '')
                if not v_name:
                    continue
                div_cover = item.find('div', attrs={'data-cover-src': True})
                if div_cover:
                    encoded = div_cover.get('data-cover-src')
                    real_pic = self._decode_cover(encoded)
                else:
                    real_pic = ""
                real_pic = real_pic
                remarks = self.regStr(v_name, r'([A-Z0-9]+-[0-9]+)')
                videos.append({
                    "vod_id": item.get('href'),
                    "vod_name": v_name,
                    "vod_pic": real_pic,
                    "vod_remarks": remarks if remarks else ""
                })

        result['list'] = videos
        result['page'] = pg
        result['pagecount'] = 999
        result['limit'] = len(videos)
        result['total'] = 9999

        if tid.startswith("/actresses/"):
            h1_tag = soup.find('h1')
            if h1_tag:
                result['type_name'] = h1_tag.get_text(strip=True)
        return result

    def detailContent(self, ids):
        vodId = ids[0]
        if vodId.startswith("/actresses/"):
            return self.categoryContent(vodId, "1", None, None)

        url = self.host + vodId
        rsp = self.fetch(url, headers=self.header)
        soup = BeautifulSoup(rsp.text, 'html.parser')

        title_meta = soup.find('meta', property="og:title")
        title = title_meta.get('content') if title_meta else ""

        pic_meta = soup.find('meta', property="og:image")
        pic = pic_meta.get('content') if pic_meta else ""
        pic = pic

        source = soup.find('source', type="application/x-mpegURL")
        play_url = source.get('src') if source else ""

        actor_tags = soup.select('a[href^="/actresses/"]')
        actors = ",".join([a.get_text(strip=True) for a in actor_tags if a.get_text(strip=True)])

        tag_tags = soup.select('a[href^="/tags/"] span.truncate')
        tags = ",".join([t.get_text(strip=True) for t in tag_tags])

        vod = {
            "vod_id": vodId,
            "vod_name": title,
            "vod_pic": pic,
            "type_name": tags,
            "vod_actor": actors,
            "vod_content": title,
            "vod_play_from": "WhosTV",
            "vod_play_url": "全高清$" + play_url if play_url else ""
        }
        return {'list': [vod]}

    def playerContent(self, flag, id, vipFlags):
        return {
            "parse": 0,
            "url": id,
            "header": {
                "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36",
                "Referer": "https://whos.tv/",
                "Origin": "https://whos.tv"
            }
        }

    def searchContent(self, key, quick):
        url = f"{self.host}/result?serach={key}"
        rsp = self.fetch(url, headers=self.header)
        soup = BeautifulSoup(rsp.text, 'html.parser')
        videos = []

        items = soup.find_all('a', href=re.compile(r'^/videos/.'))
        for item in items:
            h3 = item.find('h3')
            if h3:
                v_name = h3.get_text(strip=True)
                div_cover = item.find('div', attrs={'data-cover-src': True})
                if div_cover:
                    encoded = div_cover.get('data-cover-src')
                    real_pic = self._decode_cover(encoded)
                else:
                    real_pic = ""
                real_pic = real_pic
                remarks = self.regStr(v_name, r'([A-Z0-9]+-[0-9]+)')
                videos.append({
                    "vod_id": item.get('href'),
                    "vod_name": v_name,
                    "vod_pic": real_pic,
                    "vod_remarks": remarks if remarks else ""
                })
        return {"list": videos}