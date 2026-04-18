import requests
from bs4 import BeautifulSoup
import re
from base.spider import Spider
import sys
import json
import base64
import urllib.parse

sys.path.append('..')

xurl = "https://www.qlys.cc"
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

    def homeContent(self, filter):
        result = {}
        result = {"class": [
            {"type_id": "1", "type_name": "电影"},
            {"type_id": "2", "type_name": "连续剧"},
            {"type_id": "3", "type_name": "综艺"},
            {"type_id": "4", "type_name": "动漫"},
            {"type_id": "5", "type_name": "短剧"},
            {"type_id": "46", "type_name": "少儿"}
            ]}
        return result

    def homeVideoContent(self):
        #请求数据
        源码 = BeautifulSoup(requests.get(url=xurl, headers=headerx).text, "lxml")
        #print(源码)
        
        # 查找所有视频列表
        二次截取 = 源码.find_all('div', class_="public-list-box")
        
        # 遍历数据
        videos = []
        for 数组 in 二次截取:
            数组 = 数组.find_all('div', class_="public-list-div")
            #print(数组)
        
        # 遍历数据
            for 数组 in 数组:
                # 获取标题
                标题 = 数组.find('a')['title']
                #print(标题)
                
                # 获取链接
                链接 = 数组.find('a')['href']
                #print(链接)
                
                # 获取封面
                图片 = 数组.find('img')['data-src']
                if 'http' not in 图片:
                    图片 = xurl + 图片  # 补全封面URL
                #print(图片)
                
                # 获取副标题
                副标题 = 数组.find('span', class_="public-list-prb hide ft2")
                副标题 = 副标题.text.strip()
                #print(副标题)
                
                video = {
                          "vod_id": 链接,
                          "vod_name": 标题,
                          "vod_pic": 图片,
                          "vod_remarks": 副标题
                                     }
                videos.append(video)
                #print(video)
                
        result = {'list': videos}
        return result

    def categoryContent(self, cid, pg, filter, ext):
        result = {}
        videos = []
        if pg:
            page = int(pg)
        else:
            page = 1
        if page == '1':
            url = f'{xurl}/index.php/vod/type/id/{cid}/1.html'
        else:
            url = f'{xurl}/index.php/vod/type/id/{cid}/page/{page}.html'
        #请求数据
        源码 = BeautifulSoup(requests.get(url=url, headers=headerx).text, "lxml")
        #print(源码)
        
        # 查找所有视频列表
        二次截取 = 源码.find_all('div', class_="public-list-box")
        
        # 遍历数据
        videos = []
        for 数组 in 二次截取:
            数组 = 数组.find_all('div', class_="public-list-div")
            #print(数组)
        
        # 遍历数据
            for 数组 in 数组:
                # 获取标题
                标题 = 数组.find('a')['title']
                #print(标题)
                
                # 获取链接
                链接 = 数组.find('a')['href']
                #print(链接)
                
                # 获取封面
                图片 = 数组.find('img')['data-src']
                if 'http' not in 图片:
                    图片 = xurl + 图片  # 补全封面URL
                #print(图片)
                
                # 获取副标题
                副标题 = 数组.find('span', class_="public-list-prb hide ft2")
                副标题 = 副标题.text.strip()
                #print(副标题)
                
                video = {
                          "vod_id": 链接,
                          "vod_name": 标题,
                          "vod_pic": 图片,
                          "vod_remarks": 副标题
                                     }
                videos.append(video)
                #print(video)
                
        result = {'list': videos}
        result['page'] = pg
        result['pagecount'] = 99
        result['limit'] = 90
        result['total'] = 99
        return result

    def detailContent(self, ids):
        global pm    
        did = ids[0]
        result = {}
        videos = []
        playurl = ''
        if 'http' not in did:
            did = xurl + did
        # 请求详情页
        源码 = BeautifulSoup(requests.get(url=did, headers=headerx).text, "lxml")
        
        # 初始化VOD字典
        vod = {}
        
        # ========== 提取视频基本信息 ==========
        #视频ID
        vod["vod_id"] = xurl
        
        # 标题
        vod["vod_name"] = 源码.select_one('div.this-desc-title').get_text()
        
        # 类型
        vod["type_name"] = 源码.select_one('.this-desc-tags').get_text().replace('类型：', '').replace('/', ' ').strip()
        
        # 封面图
        vod["vod_pic"] = 源码.select_one('.lazy').get('data-src', '').replace('', '').strip()
        
        # 备注
        vod["vod_remarks"] = 源码.select_one('.this-desc-info').get_text().replace('更新：', '').strip()       
        
        # 简介
        vod["vod_content"] = 源码.select_one('.this-desc').get_text().replace('描述：', '').strip()
            
        # ========== 提取播放列表 ==========
        
        # 提取播放源标签
        ktabs = []
        线路数组 = 源码.select('.anthology-tab .swiper-wrapper a')
        for XL in 线路数组:
            线路标题 = XL.get_text()
            线路标题 = re.sub(r'\s*\d+$', '', 线路标题).strip()
            ktabs.append(线路标题)
        vod["vod_play_from"] = '$$$'.join(ktabs)
  
        # 提取播放列表
        klists = []
        播放数组 = 源码.select('.anthology-list-play')
        for BF in 播放数组:
            播放列表 = BF.select('a')
            klist = []
            for LB in 播放列表:
                播放标题 = LB.get_text()
                播放链接 = LB.get('href', '')
                剧集 = f'{播放标题}${播放链接}'
                klist.append(剧集)
            # 用#连接同一播放源的剧集
            klists.append('#'.join(klist))
        
        # 用$$$连接不同播放源
        vod["vod_play_url"] = '$$$'.join(klists)
        
        result = {'list': [vod]}
        #print(result)
        return result

    def playerContent(self, flag, id, vipFlags):
        result = {}       
        try:
            # 第一步：尝试提取直链播放
            源码 = BeautifulSoup(requests.get(url=xurl + id, headers=headerx).text, "lxml")
            url = re.search(r'var\s+now\s*=\s*"([^"]+)"', str(源码)).group(1)            
            # 正则提取成功，使用直链播放
            result["parse"] = 0
            result["playUrl"] = ''
            result["url"] = url
            result["header"] = headerx
            
        except (AttributeError, Exception):
            # 提取失败（正则未匹配到或请求异常），使用嗅探播放
            result["parse"] = 1
            result["playUrl"] = ''
            result["url"] = xurl + id
            result["header"] = headerx        
        return result

    def searchContentPage(self, key, quick, page):
        result = {}
        videos = []
        if not page:
            page = '1'
        if page == '1':
            url = f'{xurl}/index.php/vod/search.html?wd={key}'
        else:
            url = f'{xurl}/index.php/vod/search/page/{page}/wd/{key}.html'        
        源码 = BeautifulSoup(requests.get(url=url, headers=headerx).text, "lxml")
        #print(源码)
        
        # 查找所有视频列表
        二次截取 = 源码.find_all('div', class_="public-list-box")
        
        # 遍历数据
        videos = []
        for 数组 in 二次截取:
            数组 = 数组.find_all('div', class_="public-list-div")
            #print(数组)
        
        # 遍历数据
            for 数组 in 数组:
                # 获取标题
                标题 = 数组.find('a')['title']
                #print(标题)
                
                # 获取链接
                链接 = 数组.find('a')['href']
                #print(链接)
                
                # 获取封面
                图片 = 数组.find('img')['data-src']
                if 'http' not in 图片:
                    图片 = xurl + 图片  # 补全封面URL
                #print(图片)
                
                # 获取副标题
                副标题 = 数组.find('span', class_="public-list-prb hide ft2")
                副标题 = 副标题.text.strip()
                #print(副标题)
                
                video = {
                          "vod_id": 链接,
                          "vod_name": 标题,
                          "vod_pic": 图片,
                          "vod_remarks": 副标题
                                     }
                videos.append(video)
                #print(video)
                
        result = {'list': videos}
        result['page'] = page
        result['pagecount'] = 60
        result['limit'] = 30
        result['total'] = 999999
        return result

    def searchContent(self, key, quick, page='1'):
        return self.searchContentPage(key, quick, page)

    def localProxy(self, params):
        if params['type'] == "m3u8":
            return self.proxyM3u8(params)
        elif params['type'] == "media":
            return self.proxyMedia(params)
        elif params['type'] == "ts":
            return self.proxyTs(params)
        return None
        
        
if __name__ == "__main__":
    spider = Spider()
    spider.init("")

    # 调用首页视频内容测试
    #result = spider.homeVideoContent()
    #print("首页视频内容测试结果：")
    #print(result)

    # 调用分类内容测试
    #category_result = spider.categoryContent("1", "1", {}, {})
    #print("\n分类内容测试结果：")
    #print(category_result)

    # 调用详情内容测试
    #detail_result = spider.detailContent(["/hanjuzaixian/4375.html"])
    #print("\n详情内容测试结果：")
    #print(detail_result)

    # 调用播放内容测试
    player_result = spider.playerContent("m3u8", "/play/4375-1-0.html", {})
    #print("\n播放内容测试结果：")
    print(player_result)

    # 调用搜索内容测试
    #search_result = spider.searchContent("橘子果酱", False)
    # print("\n搜索内容测试结果：")
    #print(search_result)