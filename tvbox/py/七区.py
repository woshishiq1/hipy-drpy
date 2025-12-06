# coding=utf-8
#!/usr/bin/python
import sys
import requests
import re
import json
from urllib.parse import urljoin, unquote
sys.path.append('..')
from base.spider import Spider

class Spider(Spider):
    def init(self, extend=""):
        self.host = "https://618636.xyz"
        self.headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
            'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8',
            'Accept-Language': 'zh-CN,zh;q=0.9',
            'Connection': 'keep-alive',
            'Referer': self.host
        }
        print(f"七区(Manifest修复版) 初始化: {self.host}")

    def getName(self):
        return "苹果视频/七区"

    def isVideoFormat(self, url):
        # 严格校验：必须包含媒体后缀，且不能包含 html 关键字（防止把 .html?v=.m3u8 误判）
        if not url: return False
        url_lower = url.lower()
        if '.html' in url_lower: return False 
        return '.m3u8' in url_lower or '.mp4' in url_lower

    def manualVideoCheck(self):
        return False

    def _decrypt_title(self, encrypted_text):
        try:
            if not encrypted_text: return ""
            decrypted_chars = []
            for char in encrypted_text:
                decrypted_chars.append(chr(ord(char) ^ 128))
            result = ''.join(decrypted_chars)
            # 简单的乱码检测，如果解密后乱码过多，说明不需要解密
            if sum(1 for c in result if ord(c) < 32 and c not in '\t\n\r') > len(result) * 0.3:
                return encrypted_text
            return result
        except:
            return encrypted_text

    def _extractVideoItems(self, html_content):
        vods = []
        try:
            # 兼容多种列表模板
            items = re.findall(r'<a[^>]*class="thumbnail"[^>]*href="([^"]+)"[^>]*>.*?<img[^>]*data-original="([^"]+)"[^>]*>.*?<span[^>]*class="title[^"]*"[^>]*>(.*?)</span>', html_content, re.S)
            if not items:
                items = re.findall(r'<a[^>]*href="([^"]+)"[^>]*title="([^"]*)"[^>]*>.*?<img[^>]*src="([^"]+)"', html_content, re.S)

            for href, img, title_raw in items:
                title = self._decrypt_title(title_raw.strip())
                if not title: title = title_raw.strip()
                
                # 补全链接
                vid_url = href if href.startswith('http') else urljoin(self.host, href)
                pic_url = img if img.startswith('http') else urljoin(self.host, img)
                
                vods.append({
                    'vod_id': vid_url,
                    'vod_name': title,
                    'vod_pic': pic_url,
                    'vod_remarks': ''
                })
        except Exception as e:
            print(f"List parsing error: {e}")
        return vods

    def homeContent(self, filter):
        result = {}
        classes = [
            {'type_id': '/index.php/vod/type/id/37.html', 'type_name': '国产AV'},
            {'type_id': '/index.php/vod/type/id/43.html', 'type_name': '探花AV'},
            {'type_id': '/index.php/vod/type/id/40.html', 'type_name': '网黄UP主'},
            {'type_id': '/index.php/vod/type/id/49.html', 'type_name': '绿帽淫妻'},
            {'type_id': '/index.php/vod/type/id/44.html', 'type_name': '国产传媒'},
            {'type_id': '/index.php/vod/type/id/41.html', 'type_name': '福利姬'},
            {'type_id': '/index.php/vod/type/id/39.html', 'type_name': '字幕'},
            {'type_id': '/index.php/vod/type/id/45.html', 'type_name': '水果派'},
            {'type_id': '/index.php/vod/type/id/42.html', 'type_name': '主播直播'},
            {'type_id': '/index.php/vod/type/id/38.html', 'type_name': '欧美'},
            {'type_id': '/index.php/vod/type/id/66.html', 'type_name': 'FC2'},
            {'type_id': '/index.php/vod/type/id/46.html', 'type_name': '性爱教学'},
            {'type_id': '/index.php/vod/type/id/48.html', 'type_name': '三及片'},
            {'type_id': '/index.php/vod/type/id/47.html', 'type_name': '动漫'}
        ]
        result['class'] = classes
        try:
            res = requests.get(self.host, headers=self.headers, timeout=5)
            result['list'] = self._extractVideoItems(res.text)
        except:
            result['list'] = []
        return result

    def homeVideoContent(self):
        return self.homeContent(False)

    def categoryContent(self, tid, pg, filter, extend):
        result = {}
        pg = int(pg) if pg else 1
        url = tid if tid.startswith('http') else urljoin(self.host, tid)
        if pg > 1:
            url = url.replace('.html', f'/page/{pg}.html') if url.endswith('.html') else f"{url}/page/{pg}.html"
        
        try:
            res = requests.get(url, headers=self.headers, timeout=10)
            res.encoding = 'utf-8'
            vods = self._extractVideoItems(res.text)
            result['list'] = vods
            result['page'] = pg
            result['pagecount'] = pg + 1 if len(vods) > 0 else pg
            result['limit'] = 20
            result['total'] = 9999
        except:
            result['list'] = []
        return result

    def detailContent(self, ids):
        vid = ids[0]
        url = vid if vid.startswith('http') else urljoin(self.host, vid)
        vod = {
            'vod_id': vid,
            'vod_name': '',
            'vod_pic': '',
            'vod_remarks': '',
            'vod_content': ''
        }
        
        try:
            res = requests.get(url, headers=self.headers, timeout=10)
            res.encoding = 'utf-8'
            html = res.text
            
            t_match = re.search(r'<h1[^>]*>(.*?)</h1>', html) or re.search(r'<title>(.*?)</title>', html)
            if t_match:
                raw_title = t_match.group(1).split('-')[0].strip()
                decrypted = self._decrypt_title(raw_title)
                vod['vod_name'] = decrypted if len(decrypted) > 1 else raw_title

            img_match = re.search(r'class="(?:poster|dyimg)"[^>]*src="([^"]+)"', html)
            if img_match:
                vod['vod_pic'] = img_match.group(1) if img_match.group(1).startswith('http') else urljoin(self.host, img_match.group(1))

            # 直接将详情页 URL 传给 playerContent 进行深度解析
            vod['vod_play_from'] = '七区线路'
            vod['vod_play_url'] = f'立即播放${url}'
            
        except Exception as e:
            print(f"Detail error: {e}")
            
        return {'list': [vod]}

    def playerContent(self, flag, id, vipFlags):
        """
        修复核心：严格区分 HTML 和 视频流
        Manifest Malformed 意味着我们把 HTML 喂给了播放器，必须纠正。
        """
        url = id
        headers = self.headers.copy()
        headers['Referer'] = url 
        
        try:
            # 1. 严格检查：如果是纯粹的 m3u8/mp4 且不含 html 字眼，才直接播放
            if self.isVideoFormat(url):
                return {'parse': 0, 'playUrl': '', 'url': url, 'header': headers}

            # 2. 否则，必须请求页面获取真实地址
            res = requests.get(url, headers=headers, timeout=10, verify=False)
            html = res.text
            current_url = res.url
            
            # 3. 提取视频链接
            # 优先级：JSON url > 变量 v= > src= > param value
            video_url = None
            
            # 3.1 尝试 JSON 格式提取 "url":"xxx.m3u8"
            json_matches = re.findall(r'["\'](https?://[^"\']+\.(?:m3u8|mp4)[^"\']*)["\']', html)
            for m in json_matches:
                if '.html' not in m: # 再次过滤
                    video_url = m
                    break
            
            # 3.2 尝试常见参数提取 v="xxx.m3u8"
            if not video_url:
                param_matches = re.findall(r'(?:v|url|src)\s*=\s*["\']([^"\']+\.(?:m3u8|mp4)[^"\']*)["\']', html)
                for m in param_matches:
                    clean = m.replace('\\', '')
                    if not clean.startswith('http'):
                        clean = urljoin(current_url, clean)
                    if '.html' not in clean:
                        video_url = clean
                        break

            # 4. 只有当确实找到了视频流地址，才返回 parse: 0
            if video_url and self.isVideoFormat(video_url):
                return {
                    'parse': 0,
                    'playUrl': '',
                    'url': video_url,
                    'header': headers
                }
            
            # 5. 如果上面的都没找到，说明这个页面太复杂，或者需要 iframe 解析
            # 此时返回 parse: 1 (Webview 嗅探)
            # 重点：不要返回 parse: 0，否则就是 Manifest Malformed
            return {
                'parse': 1, 
                'playUrl': '', 
                'url': url, 
                'header': headers
            }

        except Exception as e:
            print(f"Player error: {e}")
            # 出错也返回嗅探，不要返回 parse: 0
            return {'parse': 1, 'playUrl': '', 'url': url, 'header': headers}

    def searchContent(self, key, quick, pg="1"):
        result = {'list': []}
        try:
            search_url = f"{self.host}/index.php/vod/search/wd/{requests.utils.quote(key)}/page/{pg}.html"
            res = requests.get(search_url, headers=self.headers, timeout=10)
            res.encoding = 'utf-8'
            vods = self._extractVideoItems(res.text)
            result['list'] = vods
            result['page'] = int(pg)
            result['pagecount'] = int(pg) + 1 if len(vods) > 0 else int(pg)
            result['limit'] = 20
            result['total'] = 9999
        except:
            pass
        return result

    def localProxy(self, params):
        return None
