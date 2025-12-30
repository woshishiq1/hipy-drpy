import re
import sys
from Crypto.Hash import MD5
sys.path.append("..")
from Crypto.Cipher import AES
from Crypto.Util.Padding import pad, unpad
from urllib.parse import quote, urlparse
from base64 import b64encode, b64decode
import json
import time
from base.spider import Spider
from collections import defaultdict


class Spider(Spider):

    def init(self, extend=""):
        self.host = 'https://mfsp33.top'
        self.did = self.getdid()
        pass

    def isVideoFormat(self, url):
        pass

    def manualVideoCheck(self):
        pass

    def action(self, action):
        pass

    def destroy(self):
        pass

    def homeContent(self, filter):
        data = self.getdata("/api.php/getappapi.index/initV119")
        dy = {"class": "类型", "area": "地区", "lang": "语言", "year": "年份", "letter": "字母", "by": "排序",
              "sort": "排序"}
        filters = {}
        classes = []
        json_data = data["type_list"]
        homedata = data["banner_list"][8:]
        for item in json_data:
            if item["type_name"] == "全部":
                continue
            has_non_empty_field = False
            jsontype_extend = json.loads(item["type_extend"])
            homedata.extend(item["recommend_list"])
            jsontype_extend["sort"] = "最新,最热,最赞"
            classes.append({"type_name": item["type_name"], "type_id": item["type_id"]})
            for key in dy:
                if key in jsontype_extend and jsontype_extend[key].strip() != "":
                    has_non_empty_field = True
                    break
            if has_non_empty_field:
                filters[str(item["type_id"])] = []
                for dkey in jsontype_extend:
                    if dkey in dy and jsontype_extend[dkey].strip() != "":
                        values = jsontype_extend[dkey].split(",")
                        value_array = [{"n": value.strip(), "v": value.strip()} for value in values if
                                       value.strip() != ""]
                        filters[str(item["type_id"])].append({"key": dkey, "name": dy[dkey], "value": value_array})
        result = {}
        result["class"] = classes
        result["filters"] = filters
        result["list"] = homedata[1:]
        return result

    def homeVideoContent(self):
        pass

    def categoryContent(self, tid, pg, filter, extend):
        body = {"area": extend.get('area', '全部'), "year": extend.get('year', '全部'), "type_id": tid, "page": pg,
                "sort": extend.get('sort', '最新'), "lang": extend.get('lang', '全部'),
                "class": extend.get('class', '全部')}
        result = {}
        data = self.getdata("/api.php/getappapi.index/typeFilterVodList", body)
        result["list"] = data["recommend_list"]
        result["page"] = pg
        result["pagecount"] = 9999
        result["limit"] = 90
        result["total"] = 999999
        return result

    def detailContent(self, ids):
        # 检查是否是合并的影片ID（多个ID用逗号分隔）
        if ',' in ids[0]:
            all_ids = ids[0].split(',')
        else:
            all_ids = [ids[0]]
        
        # 收集所有播放来源
        all_play_from = []
        all_play_url = []
        main_vod = None
        
        # 存储播放来源信息，用于合并同名播放来源
        play_source_info = defaultdict(list)
        
        for vid in all_ids:
            body = f"vod_id={vid}"
            data = self.getdata("/api.php/getappapi.index/vodDetail", body)
            vod = data["vod"]
            
            # 设置主影片信息（只取第一个）
            if main_vod is None:
                main_vod = vod
            
            # 收集播放来源
            for itt in data["vod_play_list"]:
                source_name = itt["player_info"]["show"]
                episode_count = len(itt['urls'])
                
                # 存储播放来源信息
                play_source_info[source_name].append({
                    "episode_count": episode_count,
                    "urls": itt['urls'],
                    "player_info": itt["player_info"]
                })
        
        # 处理同名播放来源，只保留集数最多的那个
        for source_name, sources in play_source_info.items():
            # 按集数排序（降序）
            sorted_sources = sorted(sources, key=lambda x: x["episode_count"], reverse=True)
            best_source = sorted_sources[0]
            
            # 构建播放列表
            a = []
            for it in best_source['urls']:
                it['user_agent'] = best_source["player_info"].get("user_agent")
                it["parse"] = best_source["player_info"].get("parse")
                a.append(f"{it['name']}${self.e64(json.dumps(it))}")
            
            # 添加到总播放列表
            all_play_from.append(source_name)
            all_play_url.append("#".join(a))
        
        # 对播放线路进行排序：名称包含"4K"的放在最前面
        sorted_play_from = []
        sorted_play_url = []
        
        # 先添加包含"4K"的线路
        for i, name in enumerate(all_play_from):
            if "4K" in name.upper():
                sorted_play_from.append(name)
                sorted_play_url.append(all_play_url[i])
        
        # 再添加其他线路
        for i, name in enumerate(all_play_from):
            if "4K" not in name.upper():
                sorted_play_from.append(name)
                sorted_play_url.append(all_play_url[i])
        
        # 设置合并后的播放来源
        main_vod["vod_play_from"] = "$$$".join(sorted_play_from)
        main_vod["vod_play_url"] = "$$$".join(sorted_play_url)
        
        result = {"list": [main_vod]}
        return result
                
    def searchContent(self, key, quick, pg="1"):
        body = f"keywords={key}&type_id=0&page={pg}"
        data = self.getdata("/api.php/getappapi.index/searchList", body)
        
        # 合并搜索结果（按原始影片名称）
        merged_results = defaultdict(list)
        for video in data["search_list"]:
            # 使用原始影片名称（不移除前缀）
            original_name = video["vod_name"]
            merged_results[original_name].append(video)
        
        # 创建合并后的结果列表
        cleaned_list = []
        for name, sources in merged_results.items():
            if len(sources) > 1:
                # 多个来源的影片：合并播放来源
                # 创建合并后的影片条目
                merged_video = sources[0].copy()
                merged_video["vod_name"] = name
                
                # 合并所有ID（用于详情页获取所有播放来源）
                merged_video["vod_id"] = ",".join([str(v["vod_id"]) for v in sources])
                
                # 添加来源数量标记
                merged_video["vod_remarks"] = f"{len(sources)}个来源"
                
                cleaned_list.append(merged_video)
            else:
                # 单个来源的影片：直接使用
                cleaned_list.append(sources[0])
        
        result = {"list": cleaned_list, "page": pg}
        return result

    def playerContent(self, flag, id, vipFlags):
        ids = json.loads(self.d64(id))
        h = {"User-Agent": (ids['user_agent'] or "okhttp/3.14.9")}
        try:
            if 'url=' in ids.get('parse_api_url', ''):
                data = self.fetch(ids['parse_api_url'], headers=h, timeout=10).json()
                url = data.get('url') or data.get('data', {}).get('url')
            else:
                parse_api = ids.get('parse') or ids.get('parse_api_url', '').replace(ids['url'], '')
                body = f"parse_api={parse_api}&url={quote(self.aes(ids['url'], True))}&token={ids.get('token', '')}"
                b = self.getdata("/api.php/getappapi.index/vodParse", body)['json']
                url = json.loads(b)['url']
                if 'error' in url: 
                    raise ValueError(f"解析失败: {url}")
            p = 0
        except Exception as e:
            print('播放解析错误：', e)
            url, p = ids['url'], 1

        if re.search(r'\.(jpg|png|jpeg)', url, re.IGNORECASE):
            url = self.Mproxy(url)
        result = {}
        result["parse"] = p
        result["url"] = url
        result["header"] = h
        return result

    def localProxy(self, param):
        return self.Mlocal(param)

    def aes(self, text, b=None):
        key = b"1234567887654321"
        iv = b"1234567887654321"
        cipher = AES.new(key, AES.MODE_CBC, iv)
        if b:
            ct_bytes = cipher.encrypt(pad(text.encode("utf-8"), AES.block_size))
            ct = b64encode(ct_bytes).decode("utf-8")
            return ct
        else:
            pt = unpad(cipher.decrypt(b64decode(text)), AES.block_size)
            return pt.decode("utf-8")

    def header(self):
        t = str(int(time.time()))
        header = {"Referer": self.host,
                  "User-Agent": "okhttp/3.14.9", 
                  "app-version-code": "101", 
                  "app-ui-mode": "light",
                  "app-api-verify-time": t, 
                  "app-user-device-id": self.did,
                  "app-api-verify-sign": self.aes(t, True),
                  "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"}
        return header

    def getdid(self):
        did = self.getCache('did')
        if not did:
            t = str(int(time.time()))
            did = self.md5(t)
            self.setCache('did', did)
        return did

    def getdata(self, path, data=None):
        vdata = self.post(f"{self.host}{path}", headers=self.header(), data=data, timeout=10).json()['data']
        data1 = self.aes(vdata)
        return json.loads(data1)

    def Mproxy(self, url):
        return f"{self.getProxyUrl()}&url={self.e64(url)}&type=m3u8"

    def Mlocal(self, param, header=None):
        url = self.d64(param["url"])
        ydata = self.fetch(url, headers=header, allow_redirects=False)
        if ydata.status_code == 302:
            url = ydata.headers['Location']
            ydata = self.fetch(url, headers=header)
        data = ydata.content.decode('utf-8')
        parsed_url = urlparse(url)
        durl = f"{parsed_url.scheme}://{parsed_url.netloc}"
        lines = data.strip().split('\n')
        for index, line in enumerate(lines):
            if not line.startswith('#') and not line.startswith('http'):
                if line.startswith('/'):
                    lines[index] = durl + line
                else:
                    base_path = url.rsplit('/', 1)[0]
                    lines[index] = f"{base_path}/{line}"
        data = '\n'.join(lines)
        return [200, "application/vnd.apple.mpegurl", data]

    def e64(self, text):
        try:
            return b64encode(text.encode('utf-8')).decode('utf-8')
        except Exception as e:
            print(f"Base64编码错误: {str(e)}")
            return ""

    def d64(self, encoded_text):
        try:
            return b64decode(encoded_text).decode('utf-8')
        except Exception as e:
            print(f"Base64解码错误: {str(e)}")
            return ""

    def md5(self, text):
        h = MD5.new()
        h.update(text.encode('utf-8'))
        return h.hexdigest()