import requests
from bs4 import BeautifulSoup
import re
import json
from urllib.parse import urljoin, quote
import sys
sys.path.append('..')
from base.spider import Spider

xurl = "https://tkys.one"
headers = {
    'User-Agent': 'Mozilla/5.0 (Linux; Android 13; M2102J2SC Build/TKQ1.221114.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/144.0.7559.31 Mobile Safari/537.36',
    'Referer': xurl,
}

class Spider(Spider):
    def getName(self):
        return "天空影视"

    def init(self, extend):
        pass

    def isVideoFormat(self, url):
        pass

    def manualVideoCheck(self):
        pass

    def homeContent(self, filter):
        return {
            "class": [
                {"type_id": "1", "type_name": "电影"},
                {"type_id": "2", "type_name": "剧集"},
                {"type_id": "3", "type_name": "综艺"},
                {"type_id": "5", "type_name": "动漫"},
                {"type_id": "4", "type_name": "短剧"},
            ],
            "filters": {}
        }

    def _parse_video_items(self, soup):
        videos = []
        for li in soup.select('div.module'):
            a = li.select_one('a.module-item')
            if not a:
                continue
            href = a.get('href')
            name = a.get('title')
            pic = li.select_one('img.lazy.lazyload')
            pic = pic.get('data-original', '') if pic else ''
            if pic and not pic.startswith('http'):
                pic = urljoin(xurl, pic)
            remark = li.select_one('div.module-item-note')
            remark = remark.get_text(strip=True) if remark else ''
            if href and name:
                videos.append({
                    "vod_id": urljoin(xurl, href),
                    "vod_name": name,
                    "vod_pic": pic,
                    "vod_remarks": remark
                })
        return videos

    def homeVideoContent(self):
        resp = requests.get(xurl, headers=headers, timeout=10)
        soup = BeautifulSoup(resp.text, 'lxml')
        return {'list': self._parse_video_items(soup)}

    def categoryContent(self, cid, pg, filter, ext):
        page = int(pg) if pg else 1
        if page == 1:
            url = f"{xurl}/vodshow/{cid}--------1---.html"
        else:
            url = f"{xurl}/vodshow/{cid}--------{page}---.html"
        resp = requests.get(url, headers=headers, timeout=10)
        return {
            'list': self._parse_video_items(BeautifulSoup(resp.text, 'lxml')),
            'page': page,
            'pagecount': page + 1,
            'limit': 90,
            'total': 9999
        }

    def detailContent(self, ids):
        did = ids[0]
        if not did.startswith('http'):
            did = urljoin(xurl, did)
        resp = requests.get(did, headers=headers, timeout=10)
        soup = BeautifulSoup(resp.text, 'lxml')
        info = {'vod_id': did}

        thumb = soup.select_one('.lazy.lazyload')
        if thumb:
            pic = thumb.get('data-original') or thumb.get('src', '')
            if pic and pic.startswith('//'):
                pic = 'https:' + pic
            elif pic and not pic.startswith('http'):
                pic = urljoin(xurl, pic)
            info['vod_pic'] = pic

        detail_div = soup.select_one('.module-info-heading')
        if detail_div:
            title_h1 = detail_div.select_one('h1')
            if title_h1:
                raw_title = title_h1.get_text(strip=True).replace('\n', '')
                info['vod_name'] = raw_title

            for p in detail_div.select('p'):
                text = p.get_text(strip=True)
                if '演员：' in text:
                    info['vod_actor'] = text.split('演员：')[-1].strip()
                if '类型：' in text:
                    info['type_name'] = text.split('类型：')[-1].strip()
                if '导演：' in text:
                    info['vod_director'] = text.split('导演：')[-1].strip()
                if '状态：' in text:
                    info['vod_remarks'] = text.split('状态：')[-1].strip()
                if '年份：' in text:
                    info['vod_year'] = text.split('年份：')[-1].strip()
                if '地区：' in text:
                    info['vod_area'] = text.split('地区：')[-1].strip()

        content_div = soup.select_one('.module-info-tag')
        if content_div:
            p = content_div.find('p')
            if p:
                text = p.get_text(strip=True)
                info['vod_content'] = text.strip()
            else:
                info['vod_content'] = content_div.get_text(strip=True)
        else:
            info['vod_content'] = ''

        tabs = soup.select('.module-tab-item')
        playlists = soup.select('.module-play-list-content')
        play_from = []
        play_url = []
        seen = set()
        for i, tab in enumerate(tabs):
            if i >= len(playlists):
                break
            name = tab.get_text(strip=True)
            name = re.sub(r'\s*\d+$', '', name).strip()
            if name in ['猜您喜欢', '同类型', '同主演', '同'] or name in seen:
                continue
            seen.add(name)
            eps = []
            for a in playlists[i].select('a'):
                href = a.get('href')
                ep_title = a.get_text(strip=True)
                if href and '1080P' not in ep_title:
                    if not href.startswith('http'):
                        href = urljoin(xurl, href)
                    eps.append(f"{ep_title}${href}")
            if eps:
                play_from.append(name)
                play_url.append('#'.join(eps))

        info["vod_play_from"] = '$$$'.join(play_from)
        info["vod_play_url"] = '$$$'.join(play_url)

        return {'list': [info]}

    def searchContent(self, key, quick, page='1'):
        page = int(page) if page else 1
        url = f"{xurl}/vodsearch/{key}----------{page}---.html"
        resp = requests.get(url, headers=headers, timeout=10)
        soup = BeautifulSoup(resp.text, 'lxml')
        return {
            'list': self._parse_video_items(soup),
            'page': page,
            'pagecount': page + 1,
            'limit': 90,
            'total': 9999
        }

    def playerContent(self, flag, id, vipFlags):
        try:
            play_url = id if id.startswith('http') else urljoin(xurl, id)
            resp = requests.get(play_url, headers=headers, timeout=10)
            html = resp.text
            video_url = None

            iframe_pattern = r'<iframe[^>]+src=["\']([^"\']+)["\']'
            matches = re.findall(iframe_pattern, html)
            for match in matches:
                if match.startswith('http') and ('.m3u8' in match or '.mp4' in match):
                    video_url = match
                    break
            if not video_url:
                video_pattern = r'<video[^>]+src=["\']([^"\']+)["\']'
                v_match = re.search(video_pattern, html)
                if v_match:
                    video_url = v_match.group(1)
                else:
                    var_pattern = r'var\s+player\w*\s*=\s*({[^;]+})'
                    var_match = re.search(var_pattern, html)
                    if var_match:
                        try:
                            config = json.loads(var_match.group(1).replace("'", '"'))
                            video_url = config.get('url', '')
                        except:
                            pass
                    if not video_url:
                        url_match = re.search(r'"url":"([^"]+)"', html)
                        if url_match:
                            video_url = url_match.group(1)

            if video_url:
                if not video_url.startswith('http'):
                    video_url = urljoin(play_url, video_url)
                if re.search(r'\.(m3u8|mp4|mkv)', video_url, re.I):
                    parse = 0
                else:
                    parse = 1
                return {"parse": parse, "playUrl": "", "url": video_url, "header": headers}
            else:
                return {"parse": 1, "playUrl": "", "url": play_url, "header": headers}
        except Exception as e:
            print(f"playerContent error: {e}")
            return {"parse": 1, "playUrl": "", "url": urljoin(xurl, id), "header": headers}

    def localProxy(self, params):
        if params['type'] == "m3u8":
            return self.proxyM3u8(params)
        if params['type'] == "media":
            return self.proxyMedia(params)
        if params['type'] == "ts":
            return self.proxyTs(params)
        return None