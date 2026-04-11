import requests
from bs4 import BeautifulSoup
import re
import json
from urllib.parse import urljoin
from base.spider import Spider
import sys
sys.path.append('..')

xurl = "https://sxyqtx.cn"
headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
    'Referer': xurl,
}

class Spider(Spider):
    def getName(self):
        return "首页"

    def init(self, extend):
        pass

    def isVideoFormat(self, url):
        pass

    def manualVideoCheck(self):
        pass

    def homeContent(self, filter):
        return {"class": [
            {"type_id": "6","type_name": "动作电影"},{"type_id": "7","type_name": "喜剧电影"},
            {"type_id": "8","type_name": "爱情电影"},{"type_id": "9","type_name": "科幻电影"},
            {"type_id": "10","type_name": "恐怖电影"},{"type_id": "11","type_name": "剧情电影"},
            {"type_id": "12","type_name": "战争电影"},{"type_id": "24","type_name": "纪录电影"},
            {"type_id": "44","type_name": "香港电影"},{"type_id": "45","type_name": "动漫电影"},
            {"type_id": "13","type_name": "国产剧"},{"type_id": "14","type_name": "香港剧"},
            {"type_id": "15","type_name": "台湾剧"},{"type_id": "16","type_name": "日本剧"},
            {"type_id": "20","type_name": "泰国剧"},{"type_id": "21","type_name": "韩国剧"},
            {"type_id": "22","type_name": "欧美剧"},{"type_id": "23","type_name": "海外剧"},
            {"type_id": "25","type_name": "大陆综艺"},{"type_id": "26","type_name": "港台综艺"},
            {"type_id": "27","type_name": "日韩综艺"},{"type_id": "28","type_name": "欧美综艺"},
            {"type_id": "29","type_name": "国产动漫"},{"type_id": "30","type_name": "日韩动漫"},
            {"type_id": "31","type_name": "港台动漫"},{"type_id": "32","type_name": "欧美动漫"},
            {"type_id": "33","type_name": "有声动漫"},{"type_id": "34","type_name": "海外动漫"},
            {"type_id": "35","type_name": "动画片"},{"type_id": "37","type_name": "女频恋爱"},
            {"type_id": "38","type_name": "反转爽剧"},{"type_id": "39","type_name": "年代穿越"},
            {"type_id": "40","type_name": "脑洞悬疑"},{"type_id": "41","type_name": "现代都市"},
            {"type_id": "42","type_name": "古装仙侠"},{"type_id": "43","type_name": "热血剧情"}
        ]}

    def _parse_video_items(self, soup):
        videos = []
        for li in soup.select('li.col-xs-4.col-md-3.col-lg-2'):
            a = li.select_one('.pic a')
            if not a:
                continue
            img = li.select_one('.img-wrapper')
            pic = (img.get('data-original') or img.get('src') or '').strip()
            if pic and not pic.startswith('http'):
                pic = urljoin(xurl, pic)
            remark = li.select_one('.item-status')
            videos.append({
                "vod_id": a.get('href'),
                "vod_name": a.get('title'),
                "vod_pic": pic,
                "vod_remarks": remark.text.strip() if remark else ''
            })
        return videos

    def homeVideoContent(self):
        resp = requests.get(xurl, headers=headers, timeout=10)
        soup = BeautifulSoup(resp.text, 'lxml')
        return {'list': self._parse_video_items(soup)}

    def categoryContent(self, cid, pg, filter, ext):
        page = int(pg) if pg else 1
        url = f'{xurl}/vodtype/{cid}.html' if page == 1 else f'{xurl}/vodtype/{cid}-{page}.html'
        resp = requests.get(url, headers=headers, timeout=10)
        soup = BeautifulSoup(resp.text, 'lxml')
        return {
            'list': self._parse_video_items(soup),
            'page': pg,
            'pagecount': 999,
            'limit': 90,
            'total': 99
        }

    def detailContent(self, ids):
        did = ids[0]
        if 'http' not in did:
            did = xurl + did

        resp = requests.get(url=did, headers=headers, timeout=10)
        soup = BeautifulSoup(resp.text, "lxml")
        vod = {}

        vod["vod_id"] = did.split('/')[-1].replace('.html', '')

        name_tag = soup.select_one('.info h3 a')
        vod["vod_name"] = name_tag.get_text(strip=True) if name_tag else ''

        img = soup.select_one('.pic img')
        if img:
            pic = img.get('data-original') or img.get('src') or ''
            if pic and not pic.startswith('http'):
                pic = urljoin(xurl, pic)
            vod["vod_pic"] = pic
        else:
            vod["vod_pic"] = ''

        status_tag = soup.select_one('.info p span:-soup-contains("状态")')
        vod["vod_remarks"] = status_tag.get_text(strip=True).replace('状态：', '') if status_tag else ''

        intro = soup.select_one('.more-box p') or soup.select_one('.info .text-row')
        vod["vod_content"] = intro.get_text(strip=True).replace('\u3000', '') if intro else ''

        category_tag = soup.select_one('.info p span:-soup-contains("分类")')
        vod["type_name"] = category_tag.get_text(strip=True).replace('分类：', '') if category_tag else ''

        area_tag = soup.select_one('.info p span:-soup-contains("地区")')
        vod["vod_area"] = area_tag.get_text(strip=True).replace('地区：', '') if area_tag else ''

        year_tag = soup.select_one('.info p span:-soup-contains("年份")')
        vod["vod_year"] = year_tag.get_text(strip=True).replace('年份：', '') if year_tag else ''

        director_tag = soup.select_one('.info p span:-soup-contains("导演")')
        vod["vod_director"] = director_tag.get_text(strip=True).replace('导演：', '').replace('/', ' ') if director_tag else ''

        actor_span = soup.select_one('.info p span:-soup-contains("主演")')
        vod["vod_actor"] = ' '.join([a.get_text(strip=True) for a in actor_span.select('a')]) if actor_span else ''

        tabs = soup.select('.playlist-tab .swiper-slide')
        containers = soup.select('.ewave-playlist-content')
        play_from = []
        play_url = []
        seen = set()

        for i, tab in enumerate(tabs):
            if i >= len(containers):
                break
            line_name = tab.get_text(strip=True)
            line_name = re.sub(r'\s*\d+$', '', line_name).strip()
            if not line_name or line_name in seen:
                continue
            seen.add(line_name)
            container = containers[i]
            eps = []
            for a in container.select('a'):
                href = a.get('href')
                if href:
                    title = a.get_text(strip=True)
                    if not href.startswith('http'):
                        href = urljoin(xurl, href)
                    eps.append(f"{title}${href}")
            if eps:
                play_from.append(line_name)
                play_url.append('#'.join(eps))

        vod["vod_play_from"] = '$$$'.join(play_from)
        vod["vod_play_url"] = '$$$'.join(play_url)

        return {'list': [vod]}

    def playerContent(self, flag, id, vipFlags):
        try:
            play_url = id if id.startswith('http') else xurl + id
            resp = requests.get(play_url, headers=headers, timeout=10)
            html = resp.text

            pattern = r'var\s+player_\w+\s*=\s*(\{[\s\S]+?\});'
            match = re.search(pattern, html)
            video_url = ''

            if match:
                obj_str = match.group(1)
                obj_str = re.sub(r'(\w+):', r'"\1":', obj_str)
                try:
                    config = json.loads(obj_str)
                    video_url = config.get('url') or config.get('url_next') or ''
                except json.JSONDecodeError:
                    pass

            if not video_url:
                url_match = re.search(r'"url":"([^"]+)"', html)
                if url_match:
                    video_url = url_match.group(1)

            if video_url and re.search(r'm3u8|mp4|mkv', video_url, re.I):
                parse = 0
                if not video_url.startswith('http'):
                    video_url = urljoin(xurl, video_url)
            else:
                parse = 1
                video_url = play_url

            return {"parse": parse, "playUrl": "", "url": video_url, "header": headers}
        except Exception as e:
            print(f"playerContent error: {e}")
            return {"parse": 1, "playUrl": "", "url": xurl + id, "header": headers}

    def searchContentPage(self, key, quick, page):
        page = page or '1'
        url = f'{xurl}/vodsearch/-------------.html?wd={key}'
        if page != '1':
            url += f'&page={page}'
        resp = requests.get(url, headers=headers, timeout=10)
        soup = BeautifulSoup(resp.text, 'lxml')
        return {
            'list': self._parse_video_items(soup),
            'page': page,
            'pagecount': 60,
            'limit': 30,
            'total': 999999
        }

    def searchContent(self, key, quick, page='1'):
        return self.searchContentPage(key, quick, page)

    def localProxy(self, params):
        if params['type'] == "m3u8":
            return self.proxyM3u8(params)
        if params['type'] == "media":
            return self.proxyMedia(params)
        if params['type'] == "ts":
            return self.proxyTs(params)
        return None