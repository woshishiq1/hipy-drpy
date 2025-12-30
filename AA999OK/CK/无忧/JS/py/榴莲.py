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
        self.host = 'https://appcms.ll4k.xyz'
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

    def clean_name(self, name):
        """移除名称中的(4K)和(HD)前缀"""
        return re.sub(r'^\((4K|HD)\)\s*', '', name)

    def homeContent(self, filter):
        data = self.getdata("/api.php/getappapi.index/initV119")
        dy = {"class": "类型", "area": "地区", "lang": "语言", "year": "年份", "letter": "字母", "by": "排序", "sort": "排序"}
        filters = {}
        classes = []
        json_data = data["type_list"]
        homedata = data["banner_list"][8:]
        
        for item in json_data:
            if item["type_name"] == "全部":
                continue
            # 清理分类名称
            item["type_name"] = self.clean_name(item["type_name"])
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
                        value_array = [{"n": value.strip(), "v": value.strip()} for value in values if value.strip() != ""]
                        filters[str(item["type_id"])].append({"key": dkey, "name": dy[dkey], "value": value_array})
        
        # 清理首页推荐影片名称
        cleaned_homedata = []
        for video in homedata[1:]:
            video["vod_name"] = self.clean_name(video["vod_name"])
            cleaned_homedata.append(video)
        
        result = {}
        result["class"] = classes
        result["filters"] = filters
        result["list"] = cleaned_homedata
        return result

    def homeVideoContent(self):
        pass

    def categoryContent(self, tid, pg, filter, extend):
        body = {
            "area": extend.get('area', '全部'),
            "year": extend.get('year', '全部'),
            "type_id": tid,
            "page": pg,
            "sort": extend.get('sort', '最新'),
            "lang": extend.get('lang', '全部'),
            "class": extend.get('class', '全部')
        }
        result = {}
        data = self.getdata("/api.php/getappapi.index/typeFilterVodList", body)
        
        # 清理分类影片名称
        cleaned_list = []
        for video in data["recommend_list"]:
            video["vod_name"] = self.clean_name(video["vod_name"])
            cleaned_list.append(video)
        
        result["list"] = cleaned_list
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
        all_play_lines = []  # 存储所有线路信息 (权重, 线路名称, 播放内容)
        main_vod = None
        
        for vid in all_ids:
            body = f"vod_id={vid}"
            data = self.getdata("/api.php/getappapi.index/vodDetail", body)
            vod = data["vod"]
            
            # 清理影片名称
            vod["vod_name"] = self.clean_name(vod["vod_name"])
            
            # 设置主影片信息（只取第一个）
            if main_vod is None:
                main_vod = vod
            
            # 收集播放来源
            for itt in data["vod_play_list"]:
                a = []
                source_name = itt["player_info"]["show"]
                for it in itt['urls']:
                    it['user_agent'] = itt["player_info"].get("user_agent")
                    it["parse"] = itt["player_info"].get("parse")
                    a.append(f"{it['name']}${self.e64(json.dumps(it))}")
                play_string = "#".join(a)
                
                # 确定权重：4K最高，HD次之
                weight = 2  # 默认权重
                if "4K" in source_name:
                    weight = 0
                elif "HD" in source_name:
                    weight = 1
                
                # 添加到线路列表
                all_play_lines.append((weight, source_name, play_string))
        
        # 去除重复线路：使用字典来跟踪已添加的线路
        unique_play_lines = {}
        for weight, source_name, play_string in all_play_lines:
            # 如果线路名称已经存在，保留权重更高的那个
            if source_name in unique_play_lines:
                existing_weight, existing_play = unique_play_lines[source_name]
                # 如果新线路权重更低（数字更大），则跳过
                if weight >= existing_weight:
                    continue
            # 添加或更新线路
            unique_play_lines[source_name] = (weight, play_string)
        
        # 转换为列表并排序
        sorted_play_lines = []
        for source_name, (weight, play_string) in unique_play_lines.items():
            sorted_play_lines.append((weight, source_name, play_string))
        
        # 对所有线路进行全局排序：4K > HD > 其他
        sorted_play_lines.sort(key=lambda x: x[0])
        
        # 提取排序后的播放来源
        all_play_from = [item[1] for item in sorted_play_lines]
        all_play_url = [item[2] for item in sorted_play_lines]
        
        # 设置合并后的播放来源
        main_vod["vod_play_from"] = "$$$".join(all_play_from)
        main_vod["vod_play_url"] = "$$$".join(all_play_url)
        
        result = {"list": [main_vod]}
        return result

    def searchContent(self, key, quick, pg="1"):
        body = f"keywords={key}&type_id=0&page={pg}"
        data = self.getdata("/api.php/getappapi.index/searchList", body)
        
        # 清理搜索结果影片名称并合并相同影片
        merged_results = defaultdict(list)
        for video in data["search_list"]:
            # 清理影片名称
            original_name = video["vod_name"]
            cleaned_name = self.clean_name(original_name)
            # 添加到合并字典
            merged_results[cleaned_name].append(video)
        
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
                # 单个来源的影片：直接清理名称
                video = sources[0]
                video["vod_name"] = name
                cleaned_list.append(video)
        
        result = {"list": cleaned_list, "page": pg}
        return result

    def playerContent(self, flag, id, vipFlags):
        # 处理播放内容
        ids = json.loads(self.d64(id))
        h = {"User-Agent": (ids['user_agent'] or "okhttp/3.14.9")}
        try:
            if re.search(r'url=', ids['parse_api_url']):
                data = self.fetch(ids['parse_api_url'], headers=h, timeout=10).json()
                url = data.get('url') or data['data'].get('url')
            else:
                body = f"parse_api={ids.get('parse') or ids['parse_api_url'].replace(ids['url'], '')}&url={quote(self.aes(ids['url'], True))}&token={ids.get('token')}"
                b = self.getdata("/api.php/getappapi.index/vodParse", body)['json']
                url = json.loads(b)['url']
            if 'error' in url:
                raise ValueError(f"解析失败: {url}")
            p = 0
        except Exception as e:
            print('错误信息：', e)
            url, p = ids['url'], 1
        
        if re.search(r'\.jpg|\.png|\.jpeg', url):
            url = self.Mproxy(url)
        
        result = {}
        result["parse"] = p
        result["url"] = url
        result["header"] = h
        return result

    def localProxy(self, param):
        return self.Mlocal(param)

    def aes(self, text, b=None):
        key = b"NiDGaKiVnkO3QX1Q"
        iv = b"NiDGaKiVnkO3QX1Q"
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
        header = {
            "Referer": self.host,
            "User-Agent": "okhttp/3.14.9",
            "app-version-code": "101",
            "app-ui-mode": "light",
            "app-api-verify-time": t,
            "app-user-device-id": self.did,
            "app-api-verify-sign": self.aes(t, True),
            "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"
        }
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
        data = ydata.content.decode('utf-8')
        
        if ydata.headers.get('Location'):
            url = ydata.headers['Location']
            data = self.fetch(url, headers=header).content.decode('utf-8')
        
        parsed_url = urlparse(url)
        durl = parsed_url.scheme + "://" + parsed_url.netloc
        lines = data.strip().split('\n')
        
        for index, string in enumerate(lines):
            if '#EXT' not in string and 'http' not in string:
                last_slash_index = string.rfind('/')
                lpath = string[:last_slash_index + 1]
                lines[index] = durl + ('' if lpath.startswith('/') else '/') + lpath
        
        data = '\n'.join(lines)
        return [200, "application/vnd.apple.mpegur", data]

    def e64(self, text):
        try:
            text_bytes = text.encode('utf-8')
            encoded_bytes = b64encode(text_bytes)
            return encoded_bytes.decode('utf-8')
        except Exception as e:
            print(f"Base64编码错误: {str(e)}")
            return ""

    def d64(self, encoded_text):
        try:
            encoded_bytes = encoded_text.encode('utf-8')
            decoded_bytes = b64decode(encoded_bytes)
            return decoded_bytes.decode('utf-8')
        except Exception as e:
            print(f"Base64解码错误: {str(e)}")
            return ""

    def md5(self, text):
        h = MD5.new()
        h.update(text.encode('utf-8'))
        return h.hexdigest()