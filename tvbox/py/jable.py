import sys, re, requests
from requests.adapters import HTTPAdapter
from requests.packages.urllib3.util.retry import Retry
from base.spider import Spider

requests.packages.urllib3.disable_warnings()

class Spider(Spider):
    def getName(self): return "Jable"

    def init(self, extend=""):
        self.siteUrl = "https://jable.tv"
        self.headers = {
            "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36",
            "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8",
            "Accept-Language": "zh-CN,zh;q=0.9,en;q=0.8",
            "Referer": "https://jable.tv/",
        }
        self.sess = requests.Session()
        self.sess.mount('https://', HTTPAdapter(max_retries=Retry(total=3, status_forcelist=[500, 502, 503, 504])))

    def fetch(self, url):
        try: return self.sess.get(url, headers=self.headers, timeout=15, verify=False)
        except: return None

    def homeContent(self, filter):
        r = self.fetch(self.siteUrl)
        cats = []
        if r and r.ok:
            # 修复优化：放弃失效的 class="tag"，改为直接抓取带有 categories/tags/hot 等真实路径的 A 标签
            pattern = r'href=["\'](?:https://jable\.tv)?/((?:categories|tags)/[^"\'/]+|latest-updates|hot)/?["\'][^>]*>(.*?)</a>'
            for m in re.finditer(pattern, r.text, re.I):
                tid = m.group(1).strip('/')
                name = re.sub(r'<[^>]+>', '', m.group(2)).strip()
                
                # 过滤掉空值及重复项，确保抓取到的分类合法
                if tid and name and len(name) > 0 and not name.isspace() and tid not in [c['type_id'] for c in cats]:
                    cats.append({"type_id": tid, "type_name": name})
        
        # 兜底静态分类优化：增加常用分类，以防极端网络情况下首页解析为空
        if not cats:
            cats = [
                {"type_id": "latest-updates", "type_name": "最近更新"},
                {"type_id": "hot", "type_name": "热门影片"},
                {"type_id": "categories/chinese-subtitle", "type_name": "中文字幕"},
                {"type_id": "categories/uncensored", "type_name": "無碼"},
                {"type_id": "categories/lesbian", "type_name": "女同"},
                {"type_id": "categories/creampie", "type_name": "中出"}
            ]
        return {'class': cats}

    def categoryContent(self, tid, pg, filter, extend):
        url = f"{self.siteUrl}/{tid}/{pg}/" if str(pg) != '1' else f"{self.siteUrl}/{tid}/"
        return self.postList(url, int(pg))

    def searchContent(self, key, quick, pg=1):
        url = f"{self.siteUrl}/search/{key}/{pg}/" if str(pg) != '1' else f"{self.siteUrl}/search/{key}/"
        return self.postList(url, int(pg))

    def postList(self, url, pg):
        r = self.fetch(url)
        l = []
        if r and r.ok:
            blocks = r.text.split('<div class="video-img-box')[1:]
            for block in blocks:
                href_match = re.search(r'href=["\']([^"\']+/videos/[^"\']+)["\']', block)
                if not href_match: continue
                u = href_match.group(1)

                title_match = re.search(r'<h6 class="title"[^>]*>\s*<a[^>]*>(.*?)</a>', block, re.S)
                t = re.sub(r'<[^>]+>', '', title_match.group(1)).strip() if title_match else "未知"

                pic_match = re.search(r'data-src=["\']([^"\']+)["\']', block) or re.search(r'src=["\']([^"\']+)["\']', block)
                p = pic_match.group(1) if pic_match else ""

                u = u if u.startswith("http") else f"{self.siteUrl}/{u.lstrip('/')}"
                
                l.append({
                    'vod_id': f"{u}@@@{t}@@@{p}",
                    'vod_name': t,
                    'vod_pic': p,
                    'vod_remarks': '1080P',
                    'style': {"type": "rect", "ratio": 1.33}
                })
        return {'list': l, 'page': pg, 'pagecount': pg + 1 if len(l) else pg, 'limit': 24, 'total': 9999}

    def detailContent(self, ids):
        vid = ids[0]
        name, pic = "未知", ""
        
        if "@@@" in vid:
            parts = vid.split("@@@")
            vid = parts[0]
            name = parts[1] if len(parts) > 1 else name
            pic = parts[2] if len(parts) > 2 else pic

        r = self.fetch(vid)
        m3u8_url = ""
        if r and r.ok:
            m_m3u8 = re.search(r"https?://[^\s'\" ]+\.m3u8", r.text)
            if m_m3u8: m3u8_url = m_m3u8.group(0)

        vod = {
            'vod_id': ids[0],
            'vod_name': name,
            'vod_pic': pic,
            'type_name': '视频',
            'vod_play_from': 'Jable',
            'vod_play_url': f"播放${m3u8_url}" if m3u8_url else f"播放${vid}"
        }
        return {'list': [vod]}

    def playerContent(self, flag, id, vipFlags):
        return {
            "parse": 0, 
            "url": id, 
            "header": {
                "Referer": "https://jable.tv/",
                "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
            }
        }
