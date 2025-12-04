# -*- coding: utf-8 -*-
# by @汤圆
import re
import sys
from pyquery import PyQuery as pq
sys.path.append('..')
from base.spider import Spider


class Spider(Spider):

    def init(self, extend=""):
        pass

    def getName(self):
        return "DB563"

    def isVideoFormat(self, url):
        pass

    def manualVideoCheck(self):
        pass

    def destroy(self):
        pass

    host = "https://javdb563.com"

    headers = {
        'User-Agent': 'Mozilla/5.0 (Linux; Android 15; 23113RKC6C Build/AQ3A.240912.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/140.0.7339.207 Mobile Safari/537.36',
        'Cookie': '',
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7',
        'Accept-Language': 'zh-CN,zh;q=0.9,en;q=0.8'
    }

    def _fix_mojibake(self, s):
        if not s:
            return s
        # Detect common mojibake markers like 'Ã', 'Â', 'ä', 'å', 'æ' from UTF-8 decoded as Latin-1
        try:
            if re.search(r'[ÃÂäåæçèéìíòóùúÄÅÆÇÈÉÌÍÒÓÙÚ]', s):
                return s.encode('latin1', 'ignore').decode('utf-8', 'ignore')
        except Exception:
            pass
        return s

    def homeContent(self, filter):
        data = self.getpq("/")
        result = {}
        
        # 分类信息
        classes = [
            {'type_name': '全部', 'type_id': ''},       
            {'type_name': '无码', 'type_id': 'uncensored'},
            {'type_name': '人气标题', 'type_id': 'tags/uncensored?c5=117&c10=1'},
            {'type_name': '欧美', 'type_id': 'western'},
            {'type_name': '捆绑', 'type_id': 'tags/uncensored?c10=1&c2=14'},
            {'type_name': '束缚', 'type_id': 'tags/uncensored?c2=7&c10=1'},
            {'type_name': '潮吹', 'type_id': 'tags/uncensored?c2=29&c10=1'},
            {'type_name': '性奴', 'type_id': 'tags/uncensored?c10=1&c2=32'}
        ]
        
        result['class'] = classes
        result['list'] = self.getlist(data)
        return result

    def homeVideoContent(self):
        pass

    def categoryContent(self, tid, pg, filter, extend):
        # 构建URL
        if tid == '':
            # 全部分类
            if pg == 1:
                url = "/"
            else:
                url = f"/?page={pg}"
        else:
            # 其他分类
            if pg == 1:
                url = f"/{tid}"
            else:
                # 检查是否已经包含查询参数
                if '?' in tid:
                    url = f"/{tid}&page={pg}"
                else:
                    url = f"/{tid}?page={pg}"
        
        data = self.getpq(url)
        result = {}
        result['list'] = self.getlist(data)
        result['page'] = pg
        result['pagecount'] = 9999
        result['limit'] = 90
        result['total'] = 999999
        return result

    def detailContent(self, ids):
        data = self.getpq(ids[0])
        
        # 获取基本信息
        title = data('.video-title strong').text()
        if not title:
            title = data('h1').text()
        title = self._fix_mojibake((title or '').strip())
        
        vod = {
            'vod_id': ids[0],
            'vod_name': title,
            'vod_pic': data('.cover img').attr('src'),
            'vod_year': self._fix_mojibake((data('.meta').text() or '').strip()),
            'vod_remarks': self._fix_mojibake((data('.score .value').text() or '').strip()),
            'vod_content': self._fix_mojibake((data('.video-title').text() or '').strip())
        }
        
        # 获取磁力链接
        magnets = []
        magnet_items = data('#magnets-content .item')
        
        for item in magnet_items.items():
            magnet_name_elem = item('.magnet-name a')
            magnet_url = magnet_name_elem.attr('href')
            magnet_title = self._fix_mojibake((magnet_name_elem.text() or '').strip())
            
            if magnet_url and magnet_url.startswith('magnet:'):
                magnets.append(f"{magnet_title}${magnet_url}")
        
        vod["vod_play_from"] = "磁力链接"
        vod["vod_play_url"] = "#".join(magnets) if magnets else f"{title}${ids[0]}"
        
        result = {"list": [vod]}
        return result

    def searchContent(self, key, quick, pg="1"):
        # 构建搜索URL
        search_url = f"/search?q={key}"
        if pg != "1":
            search_url += f"&page={pg}"
        
        data = self.getpq(search_url)
        result = {}
        result['list'] = self.getlist(data)
        result['page'] = int(pg)
        result['pagecount'] = 9999
        result['limit'] = 90
        result['total'] = 999999
        return result

    def playerContent(self, flag, id, vipFlags):
        # 直接返回磁力链接，播放器会处理
        return {'parse': 0, 'url': id, 'header': self.headers}

    def localProxy(self, param):
        pass

    def getlist(self, data):
        videos = []
        items = data('.movie-list .item')
        
        for item in items.items():
            link_elem = item('a.box')
            if not link_elem:
                continue
                
            href = link_elem.attr('href')
            title = self._fix_mojibake((link_elem.attr('title') or '').strip())
            img_src = item('img').attr('src')
            meta_text = self._fix_mojibake((item('.meta').text() or '').strip())
            
            videos.append({
                'vod_id': href,
                'vod_name': title,
                'vod_pic': img_src,
                'vod_remarks': meta_text,
                'vod_year': meta_text  # 使用日期作为年份
            })
        
        return videos

    def getpq(self, path=''):
        url = f"{self.host}{path}" if not path.startswith('http') else path
        rsp = self.fetch(url, headers=self.headers)
        # Prefer raw bytes to avoid wrong intermediate decoding
        content = rsp.content
        try:
            return pq(content)
        except Exception as e:
            print(f"解析错误: {str(e)}")
            try:
                return pq(content.decode('utf-8', 'ignore'))
            except Exception:
                return pq(rsp.text)