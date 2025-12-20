# coding = utf-8
#!/usr/bin/python

"""

作者 丢丢喵推荐 🚓 内容均从互联网收集而来 仅供交流学习使用 版权归原创者所有 如侵犯了您的权益 请通知作者 将及时删除侵权内容
                    ====================Diudiumiao====================

"""

from base.spider import Spider
import requests
import sys

sys.path.append('..')

xurl = "https://new.tianjinzhitongdaohe.com"

headers = {
    "Cache-Control": "no-cache",
    "Content-Type": "application/json;charset=UTF-8",
    "User-Agent": "okhttp/4.12.0"
}

headerx = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.87 Safari/537.36'
}

class Spider(Spider):
    global xurl
    global headers
    global headerx

    def getName(self):
        return "牛牛短剧[短]"

    def init(self, extend):
        pass

    def isVideoFormat(self, url):
        pass

    def manualVideoCheck(self):
        pass

    def homeContent(self, filter):
        result = {"class": []}
        
        # 使用聚合规则中牛牛短剧的固定分类
        fixed_categories = ["现言", "古言", "现代", "都市", "穿越", "逆袭", "总裁", "虐恋", "甜宠", "重生", "玄幻"]
        for cat in fixed_categories:
            result["class"].append({"type_id": cat, "type_name": cat})
        return result

    def homeVideoContent(self):
        result = {}
        videos = []
        
        try:
            payload = {
                "condition": {
                    "classify": "现言",  # 默认分类改为"现言"
                    "typeId": "S1"
                },
                "pageNum": "1",
                "pageSize": 20
            }
            
            url = f"{xurl}/api/v1/app/screen/screenMovie"
            response = requests.post(url=url, headers=headers, json=payload, timeout=10)
            if response.status_code == 200:
                data = response.json()
                
                if data.get('data') and data['data'].get('records'):
                    setup = data['data']['records']
                    
                    for vod in setup:
                        name = vod['name']
                        id = vod['id']
                        pic = vod['cover']
                        remark = f"{vod.get('totalEpisode', '0')}集"
                        
                        video = {
                            "vod_id": id,
                            "vod_name": name,
                            "vod_pic": pic,
                            "vod_remarks": remark
                        }
                        videos.append(video)
            
            result = {'list': videos}
            return result
        except Exception as e:
            print(f"首页视频加载失败: {e}")
            return {'list': []}

    def categoryContent(self, cid, pg, filter, ext):
        result = {}
        videos = []

        try:
            if pg:
                page = int(pg)
            else:
                page = 1

            payload = {
                "condition": {
                    "classify": cid,
                    "typeId": "S1"
                },
                "pageNum": str(page),
                "pageSize": 40
            }

            url = f"{xurl}/api/v1/app/screen/screenMovie"
            response = requests.post(url=url, headers=headers, json=payload, timeout=10)
            if response.status_code == 200:
                data = response.json()
                
                if data.get('data') and data['data'].get('records'):
                    setup = data['data']['records']

                    for vod in setup:
                        name = vod['name']
                        id = vod['id']
                        pic = vod['cover']
                        remark = f"{vod.get('totalEpisode', '0')}集"

                        video = {
                            "vod_id": id,
                            "vod_name": name,
                            "vod_pic": pic,
                            "vod_remarks": remark
                        }
                        videos.append(video)
            
            result = {'list': videos}
            result['page'] = pg
            result['pagecount'] = 9999
            result['limit'] = 40
            result['total'] = 999999
            return result
        except Exception as e:
            print(f"分类内容加载失败: {e}")
            result = {'list': []}
            result['page'] = pg
            result['pagecount'] = 1
            result['limit'] = 40
            result['total'] = 0
            return result

    def detailContent(self, ids):
        did = ids[0]
        result = {}
        videos = []
        xianlu = ''
        bofang = ''

        try:
            payload = {
                "id": did,
                "source": 0,
                "typeId": "S1",
                "userId": "223664"
            }

            print(f"详情请求参数: {payload}")
            
            url = f"{xurl}/api/v1/app/play/movieDetails"
            response = requests.post(url=url, headers=headers, json=payload, timeout=10)
            print(f"详情请求状态码: {response.status_code}")
            
            if response.status_code == 200:
                data = response.json()
                print(f"详情请求返回数据: {data}")
                
                vod_data = data.get('data', {})
                
                content = vod_data.get('introduce', '暂无剧情介绍')
                vod_name = vod_data.get('name', '未知名称')
                vod_pic = vod_data.get('cover', '')
                
                # 按照聚合规则的格式构造播放地址
                if 'episodeList' in vod_data and vod_data['episodeList']:
                    episode_list = []
                    for episode in vod_data['episodeList']:
                        episode_name = episode.get('episode', '')
                        episode_id = episode.get('id', '')
                        if episode_name and episode_id:
                            # 格式：剧集名称$视频ID@集ID
                            episode_list.append(f"{episode_name}${did}@{episode_id}")
                    
                    if episode_list:
                        bofang = "#".join(episode_list)
                        xianlu = '牛牛短剧'
                        print(f"构造的播放列表: {bofang}")
            
            videos.append({
                "vod_id": did,
                "vod_name": vod_name,
                "vod_pic": vod_pic,
                "vod_content": content,
                "vod_play_from": xianlu,
                "vod_play_url": bofang
            })

            result['list'] = videos
            return result
        except Exception as e:
            print(f"详情加载异常: {e}")
            import traceback
            traceback.print_exc()
            videos.append({
                "vod_id": did,
                "vod_name": "加载失败",
                "vod_pic": "",
                "vod_content": "详情加载失败，请稍后重试",
                "vod_play_from": "暂无资源",
                "vod_play_url": "暂无播放地址$0"
            })
            result['list'] = videos
            return result

    def playerContent(self, flag, id, vipFlags):
        try:
            # 根据聚合规则，id 的格式是 "videoId@episodeId"
            fenge = id.split("@")
            
            if len(fenge) < 2:
                return {
                    "parse": 0,
                    "playUrl": '',
                    "url": '',
                    "header": headerx
                }

            # 根据聚合规则构造请求体
            payload = {
                "episodeId": fenge[1],
                "id": fenge[0],
                "source": 0,
                "typeId": "S1",
                "userId": "223664"
            }

            print(f"请求播放地址参数: {payload}")
            
            url = f"{xurl}/api/v1/app/play/movieDetails"
            response = requests.post(url=url, headers=headers, json=payload, timeout=10)
            print(f"播放请求状态码: {response.status_code}")
            
            if response.status_code == 200:
                data = response.json()
                print(f"播放请求返回数据: {data}")
                
                # 根据聚合规则，播放地址在 data.data.url
                if data.get('data') and data['data'].get('url'):
                    play_url = data['data']['url']
                    print(f"获取到播放地址: {play_url}")
                    
                    result = {}
                    result["parse"] = 0
                    result["playUrl"] = ''
                    result["url"] = play_url
                    result["header"] = headerx
                    return result
                else:
                    print(f"播放地址不存在: {data}")
            else:
                print(f"播放请求失败: {response.status_code} - {response.text}")
            
            # 如果获取失败，返回空结果
            return {
                "parse": 0,
                "playUrl": '',
                "url": '',
                "header": headerx
            }
        except Exception as e:
            print(f"播放地址获取异常: {e}")
            import traceback
            traceback.print_exc()
            return {
                "parse": 0,
                "playUrl": '',
                "url": '',
                "header": headerx
            }

    def searchContentPage(self, key, quick, pg):
        result = {}
        videos = []

        try:
            if pg:
                page = int(pg)
            else:
                page = 1

            # 修正搜索参数，使用"name"字段而不是"value"
            payload = {
                "condition": {
                    "typeId": "S1",
                    "name": key  # 修改为"name"字段
                },
                "pageNum": str(page),
                "pageSize": 40
            }

            url = f"{xurl}/api/v1/app/search/searchMovie"
            response = requests.post(url=url, headers=headers, json=payload, timeout=10)
            if response.status_code == 200:
                data = response.json()
                
                if data.get('data') and data['data'].get('records'):
                    setup = data['data']['records']

                    for vod in setup:
                        name = vod['name']
                        id = vod['id']
                        pic = vod['cover']
                        remark = f"{vod.get('totalEpisode', '0')}集"

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
            result['limit'] = 40
            result['total'] = 999999
            return result
        except Exception as e:
            print(f"搜索失败: {e}")
            result['list'] = []
            result['page'] = pg
            result['pagecount'] = 1
            result['limit'] = 40
            result['total'] = 0
            return result

    def searchContent(self, key, quick, pg="1"):
        return self.searchContentPage(key, quick, pg)

    def localProxy(self, params):
        return None