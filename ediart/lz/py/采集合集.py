# -*- coding: utf-8 -*-
# @Author  : AI Assistant
# @Desc    : 单文件无感版 (JSON已内置 + 7天缓存 + 异步并发)

import json
import os
import time
import hashlib
import requests
from requests.adapters import HTTPAdapter
from concurrent.futures import ThreadPoolExecutor, as_completed
from base.spider import Spider

class Spider(Spider):
    def getName(self):
        return "CjJson_SingleFile_Ultimate"

    def init(self, extend):
        self.sites = []
        self.session = requests.Session()
        
        # [内置 JSON 数据]
        self.embedded_data = {
            "api_site": [
                {"name": "TV-电影天堂资源", "api": "http://caiji.dyttzyapi.com/api.php/provide/vod", "detail": "http://caiji.dyttzyapi.com", "bz": "0", "paichu": "1,2,3,4"},
                {"name": "TV-量子资源", "api": "https://cj.lziapi.com/api.php/provide/vod", "detail": "", "bz": "1", "paichu": "1,2,3,4"},
                {"name": "TV-1080资源", "api": "https://api.1080zyku.com/inc/api_mac10.php", "detail": "https://api.1080zyku.com", "bz": "0", "paichu": "1,2,3,4"},
                {"name": "AV-155资源", "api": "https://155api.com/api.php/provide/vod", "detail": "https://155api.com", "bz": "0", "paichu": ""},
                {"name": "TV-360资源", "api": "https://360zy.com/api.php/provide/vod", "detail": "https://360zy.com", "bz": "1", "paichu": "1,2,3,4"},
                {"name": "TV-天涯资源", "api": "https://tyyszy.com/api.php/provide/vod", "detail": "https://tyyszy.com", "bz": "1", "paichu": "20,39,45,50"},
                {"name": "TV-暴风资源", "api": "https://bfzyapi.com/api.php/provide/vod", "detail": "", "bz": "1", "paichu": ""},
                {"name": "TV-索尼-闪电资源", "api": "https://xsd.sdzyapi.com/api.php/provide/vod", "detail": "", "bz": "0", "paichu": "1,2,3,4"},
                {"name": "TV-索尼资源", "api": "https://suoniapi.com/api.php/provide/vod", "detail": "", "bz": "0", "paichu": "1,2,3,4"},
                {"name": "TV-红牛资源", "api": "https://www.hongniuzy2.com/api.php/provide/vod", "detail": "https://www.hongniuzy2.com", "bz": "1", "paichu": "1,2,3,4"},
                {"name": "TV-茅台资源", "api": "https://caiji.maotaizy.cc/api.php/provide/vod", "detail": "https://caiji.maotaizy.cc", "bz": "1", "paichu": "1,2,3,4"},
                {"name": "TV-虎牙资源", "api": "https://www.huyaapi.com/api.php/provide/vod", "detail": "https://www.huyaapi.com", "bz": "0", "paichu": "1,2,17"},
                {"name": "TV-豆瓣资源", "api": "https://caiji.dbzy.tv/api.php/provide/vod", "detail": "https://caiji.dbzy.tv", "bz": "1", "paichu": "1,2,3,4,42,51,52"},
                {"name": "TV-豆瓣资源2", "api": "https://dbzy.tv/api.php/provide/vod", "detail": "https://dbzy.tv", "bz": "1", "paichu": "1,2,3,4,42,51,52"},
                {"name": "TV-豆瓣资源3", "api": "https://caiji.dbzy5.com/api.php/provide/vod/from/dbm3u8/at/josn", "detail": "https://dbzy.tv", "bz": "1", "paichu": "1,2,3,4,42,51,52"},
                {"name": "TV-豪华资源", "api": "https://hhzyapi.com/api.php/provide/vod", "detail": "https://hhzyapi.com", "bz": "1", "paichu": "1,2,17,27"},
                {"name": "TV-CK资源", "api": "https://ckzy.me/api.php/provide/vod", "detail": "https://ckzy.me", "bz": "1", "paichu": "21,39"},
                {"name": "TV-U酷资源", "api": "https://api.ukuapi.com/api.php/provide/vod", "detail": "https://api.ukuapi.com", "bz": "1", "paichu": "1,2,3,4"},
                {"name": "TV-U酷资源2", "api": "https://api.ukuapi88.com/api.php/provide/vod", "detail": "https://api.ukuapi88.com", "bz": "1", "paichu": "1,2,3,4"},
                {"name": "TV-ikun资源", "api": "https://ikunzyapi.com/api.php/provide/vod", "detail": "https://ikunzyapi.com", "bz": "1", "paichu": "1,2,3,4"},
                {"name": "TV-wujinapi无尽", "api": "https://api.wujinapi.cc/api.php/provide/vod", "detail": "", "bz": "0", "paichu": "1,2,3,4,5"},
                {"name": "TV-丫丫点播", "api": "https://cj.yayazy.net/api.php/provide/vod", "detail": "https://cj.yayazy.net", "bz": "0", "paichu": "1,2,3,4"},
                {"name": "TV-光速资源", "api": "https://api.guangsuapi.com/api.php/provide/vod", "detail": "https://api.guangsuapi.com", "bz": "1", "paichu": "1,2,3,4"},
                {"name": "TV-卧龙点播", "api": "https://collect.wolongzyw.com/api.php/provide/vod", "detail": "https://collect.wolongzyw.com", "bz": "1", "paichu": ""},
                {"name": "TV-卧龙资源", "api": "https://collect.wolongzy.cc/api.php/provide/vod", "detail": "", "bz": "1", "paichu": "1,2,3,4"},
                {"name": "TV-卧龙资源2", "api": "https://wolongzyw.com/api.php/provide/vod", "detail": "https://wolongzyw.com", "bz": "1", "paichu": "1,2,3,4"},
                {"name": "TV-新浪点播", "api": "https://api.xinlangapi.com/xinlangapi.php/provide/vod", "detail": "https://api.xinlangapi.com", "bz": "1", "paichu": "1,2,3,4"},
                {"name": "TV-无尽资源", "api": "https://api.wujinapi.com/api.php/provide/vod", "detail": "", "bz": "1", "paichu": "1,2,3,4,5"},
                {"name": "TV-无尽资源2", "api": "https://api.wujinapi.me/api.php/provide/vod", "detail": "", "bz": "1", "paichu": "1,2,3,4,5"},
                {"name": "TV-无尽资源3", "api": "https://api.wujinapi.net/api.php/provide/vod", "detail": "", "bz": "1", "paichu": "1,2,3,4,5"},
                {"name": "TV-旺旺短剧", "api": "https://wwzy.tv/api.php/provide/vod", "detail": "https://wwzy.tv", "bz": "1", "paichu": "2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18"},
                {"name": "TV-旺旺资源", "api": "https://api.wwzy.tv/api.php/provide/vod", "detail": "https://api.wwzy.tv", "bz": "1", "paichu": "2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18"},
                {"name": "TV-最大点播", "api": "http://zuidazy.me/api.php/provide/vod", "detail": "http://zuidazy.me", "bz": "1", "paichu": "1,2,3,4"},
                {"name": "TV-最大资源", "api": "https://api.zuidapi.com/api.php/provide/vod", "detail": "https://api.zuidapi.com", "bz": "1", "paichu": "1,2,3,4"},
                {"name": "TV-樱花资源", "api": "https://m3u8.apiyhzy.com/api.php/provide/vod", "detail": "", "bz": "0", "paichu": "1,2,3,4,5"},
                {"name": "TV-步步高资源", "api": "https://api.yparse.com/api/json", "detail": "", "bz": "0", "paichu": ""},
                {"name": "TV-牛牛点播", "api": "https://api.niuniuzy.me/api.php/provide/vod", "detail": "https://api.niuniuzy.me", "bz": "0", "paichu": "1,2,3,4"},
                {"name": "AV-gay资源", "api": "https://gayapi.com/api.php/provide/vod/at/json", "detail": "https://api.bwzyz.com", "bz": "0", "paichu": ""},
                {"name": "TV-百度云资源", "api": "https://api.apibdzy.com/api.php/provide/vod", "detail": "https://api.apibdzy.com", "bz": "1", "paichu": "1,2,3,4"},
                {"name": "TV-神马云", "api": "https://api.1080zyku.com/inc/apijson.php/", "detail": "https://api.1080zyku.com", "bz": "1", "paichu": "1,2,3,4"},
                {"name": "TV-速博资源", "api": "https://subocaiji.com/api.php/provide/vod", "detail": "", "bz": "1", "paichu": "1,2,3,4"},
                {"name": "TV-金鹰点播", "api": "https://jinyingzy.com/api.php/provide/vod", "detail": "https://jinyingzy.com", "bz": "1", "paichu": "1,2,17,27"},
                {"name": "TV-金鹰资源", "api": "https://jyzyapi.com/api.php/provide/vod", "detail": "https://jyzyapi.com", "bz": "1", "paichu": "1,2,17,27"},
                {"name": "TV-閃電资源", "api": "https://sdzyapi.com/api.php/provide/vod", "detail": "https://sdzyapi.com", "bz": "0", "paichu": "1,2,3,4"},
                {"name": "TV-非凡资源", "api": "https://cj.ffzyapi.com/api.php/provide/vod", "detail": "https://cj.ffzyapi.com", "bz": "0", "paichu": "1,2,3,4"},
                {"name": "TV-飘零资源", "api": "https://p2100.net/api.php/provide/vod", "detail": "https://p2100.net", "bz": "1", "paichu": "1,2,3,4"},
                {"name": "TV-魔爪资源", "api": "https://mozhuazy.com/api.php/provide/vod", "detail": "https://mozhuazy.com", "bz": "1", "paichu": "1,25,34,40"},
                {"name": "TV-魔都动漫", "api": "https://caiji.moduapi.cc/api.php/provide/vod", "detail": "https://caiji.moduapi.cc", "bz": "1", "paichu": ""},
                {"name": "TV-魔都资源", "api": "https://www.mdzyapi.com/api.php/provide/vod", "detail": "https://www.mdzyapi.com", "bz": "1", "paichu": ""},
                {"name": "AV-91麻豆", "api": "https://91md.me/api.php/provide/vod", "detail": "https://91md.me", "bz": "0", "paichu": ""},
                {"name": "AV-AIvin", "api": "http://lbapiby.com/api.php/provide/vod", "detail": "", "bz": "0", "paichu": ""},
                {"name": "AV-JKUN资源", "api": "https://jkunzyapi.com/api.php/provide/vod", "detail": "https://jkunzyapi.com", "bz": "0", "paichu": ""},
                {"name": "AV-souav资源", "api": "https://api.souavzy.vip/api.php/provide/vod", "detail": "https://api.souavzy.vip", "bz": "0", "paichu": ""},
                {"name": "AV-乐播资源", "api": "https://lbapi9.com/api.php/provide/vod", "detail": "", "bz": "0", "paichu": ""},
                {"name": "AV-奥斯卡资源", "api": "https://aosikazy.com/api.php/provide/vod", "detail": "https://aosikazy.com", "bz": "0", "paichu": ""},
                {"name": "AV-奶香香", "api": "https://Naixxzy.com/api.php/provide/vod", "detail": "https://Naixxzy.com", "bz": "0", "paichu": ""},
                {"name": "AV-森林资源", "api": "https://slapibf.com/api.php/provide/vod", "detail": "https://slapibf.com", "bz": "0", "paichu": ""},
                {"name": "AV-淫水机资源", "api": "https://www.xrbsp.com/api/json.php", "detail": "https://www.xrbsp.com", "bz": "0", "paichu": ""},
                {"name": "AV-玉兔资源", "api": "https://apiyutu.com/api.php/provide/vod", "detail": "https://apiyutu.com", "bz": "0", "paichu": ""},
                {"name": "AV-番号资源", "api": "http://fhapi9.com/api.php/provide/vod", "detail": "", "bz": "0", "paichu": ""},
                {"name": "AV-白嫖资源", "api": "https://www.kxgav.com/api/json.php", "detail": "https://www.kxgav.com", "bz": "0", "paichu": ""},
                {"name": "AV-精品资源", "api": "https://www.jingpinx.com/api.php/provide/vod", "detail": "https://www.jingpinx.com", "bz": "0", "paichu": ""},
                {"name": "AV-美少女资源", "api": "https://www.msnii.com/api/json.php", "detail": "https://www.msnii.com", "bz": "0", "paichu": ""},
                {"name": "AV-老色逼资源", "api": "https://apilsbzy1.com/api.php/provide/vod", "detail": "https://apilsbzy1.com", "bz": "0", "paichu": ""},
                {"name": "AV-色南国", "api": "https://api.sexnguon.com/api.php/provide/vod", "detail": "https://api.sexnguon.com", "bz": "0", "paichu": ""},
                {"name": "AV-色猫资源", "api": "https://api.maozyapi.com/inc/apijson_vod.php", "detail": "https://api.maozyapi.com", "bz": "0", "paichu": ""},
                {"name": "AV-辣椒资源", "api": "https://apilj.com/api.php/provide/vod", "detail": "https://apilj.com", "bz": "0", "paichu": ""},
                {"name": "AV-香奶儿资源", "api": "https://www.gdlsp.com/api/json.php", "detail": "https://www.gdlsp.com", "bz": "0", "paichu": ""},
                {"name": "AV-鲨鱼资源", "api": "https://shayuapi.com/api.php/provide/vod", "detail": "https://shayuapi.com", "bz": "0", "paichu": ""},
                {"name": "AV-黄AV资源", "api": "https://www.pgxdy.com/api/json.php", "detail": "https://www.pgxdy.com", "bz": "0", "paichu": ""},
                {"name": "TV-极速资源", "api": "https://jszyapi.com/api.php/provide/vod", "detail": "https://jszyapi.com", "bz": "0", "paichu": "1,2,17,27"},
                {"name": "TV-魔爪资源", "api": "https://mozhuazy.com/api.php/provide/vod", "detail": "", "bz": "0", "paichu": "1,25,34,40"},
                {"name": "TV-魔都资源", "api": "https://www.mdzyapi.com/api.php/provide/vod", "bz": "0", "detail": "", "paichu": ""},
                {"name": "AV-杏吧资源", "api": "https://xingba111.com/api.php/provide/vod", "detail": "", "bz": "0", "paichu": ""},
                {"name": "TV-量子资源", "api": "https://cj.lziapi.com/api.php/provide/vod", "detail": "", "bz": "0", "paichu": "1,2,3,4"},
                {"name": "森林资源", "api": "https://slapibf.com/api.php/provide/vod", "detail": "", "bz": "0", "paichu": ""},
                {"name": "TV-红牛资源", "api": "https://www.hongniuzy3.com/api.php/provide/vod", "detail": "", "bz": "0", "paichu": "1,2"},
                {"name": "TV-鸭鸭资源", "api": "https://cj.yayazy.net/api.php/provide/vod", "detail": "", "bz": "0", "paichu": "1,2,3,4"},
                {"name": "TV-海洋资源", "api": "http://www.seacms.org/api.php/provide/vod", "detail": "", "bz": "0", "paichu": ""},
                {"name": "AV-黄色资源啊啊", "api": "https://hsckzy888.com/api.php/provide/vod", "detail": "", "bz": "0", "paichu": ""},
                {"name": "AV-小鸡资源", "api": "https://api.xiaojizy.live/provide/vod", "detail": "", "bz": "0", "paichu": ""},
                {"name": "TV-新浪资源阿", "api": "https://api.xinlangapi.com/xinlangapi.php/provide/vod", "detail": "", "bz": "0", "paichu": "1,2"},
                {"name": "AV-辣椒资源黄黄", "api": "https://apilj.com/api.php/provide", "detail": "", "bz": "0", "paichu": ""},
                {"name": "AV-细胞采集黄色", "api": "https://www.xxibaozyw.com/api.php/provide/vod", "detail": "", "bz": "0", "paichu": ""}
            ]
        }

        # [核心优化1] 极速连接池
        adapter = HTTPAdapter(pool_connections=100, pool_maxsize=100, max_retries=1)
        self.session.mount('http://', adapter)
        self.session.mount('https://', adapter)
        self.session.headers.update({
            "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36",
            "Connection": "keep-alive"
        })

        # [核心优化2] 缓存系统初始化
        self.cache_dir = "/storage/emulated/0/lz/cache/"
        self.memory_cache = {}
        self.disk_ttl = 604800 # 7天
        
        if not os.path.exists(self.cache_dir):
            try: os.makedirs(self.cache_dir)
            except: pass

        # 处理模式切换 (0:全部, 1:仅成人, 2:非成人)
        # extend 参数现在只用来传模式 "0", "1", "2"
        self.mode = extend if extend in ["0", "1", "2"] else "0"
        
        # 直接使用内置数据进行过滤
        all_sites = self.embedded_data.get("api_site", [])
        self.sites = self._filter_sites(all_sites, self.mode)

    # --- 以下逻辑保持不变 ---
    def _get_disk_cache(self, key):
        try:
            md5_key = hashlib.md5(key.encode('utf-8')).hexdigest()
            path = os.path.join(self.cache_dir, f"{md5_key}.json")
            if os.path.exists(path):
                if time.time() - os.path.getmtime(path) < self.disk_ttl:
                    with open(path, "r", encoding="utf-8") as f:
                        return json.load(f)
                else:
                    os.remove(path)
        except: pass
        return None

    def _set_disk_cache(self, key, data):
        try:
            if not data or not data.get("list"): return 
            md5_key = hashlib.md5(key.encode('utf-8')).hexdigest()
            path = os.path.join(self.cache_dir, f"{md5_key}.json")
            with open(path, "w", encoding="utf-8") as f:
                json.dump(data, f, ensure_ascii=False)
        except: pass

    def _filter_sites(self, sites, mode):
        if mode == "0": return sites
        adult_kws = {"AV", "色", "福利", "成人", "18+", "偷拍", "自拍", "淫", "激情", "GAY", "SEX"}
        def is_adult(name):
            if not name: return False
            name_upper = name.upper()
            if name_upper.startswith("AV"): return True
            return any(k in name_upper for k in adult_kws)

        if mode == "1": return [s for s in sites if not is_adult(s.get("name", ""))]
        elif mode == "2": return [s for s in sites if is_adult(s.get("name", ""))]
        return sites

    def _fetch(self, api_url, params=None):
        try:
            sep = "&" if "?" in api_url else "?"
            qs = "&".join([f'{k}={v}' for k, v in params.items()]) if params else ""
            full_url = f"{api_url}{sep}{qs}" if qs else api_url
            timeout = 2.5 if params and "wd" in params else 4.0
            res = self.session.get(full_url, timeout=timeout, verify=False)
            if res.status_code == 200:
                try: return res.json()
                except: return json.loads(res.text.strip().lstrip('﻿'))
        except: pass
        return {}

    def homeContent(self, filter):
        classes = []
        filters = {}
        universal_filter = [{"key": "cateId", "name": "分类", "value": [{"n": "全部", "v": ""}, {"n": "动作片", "v": "动作"}, {"n": "喜剧片", "v": "喜剧"}, {"n": "爱情片", "v": "爱情"}, {"n": "科幻片", "v": "科幻"}, {"n": "恐怖片", "v": "恐怖"}, {"n": "剧情片", "v": "剧情"}, {"n": "战争片", "v": "战争"}, {"n": "国产剧", "v": "国产"}, {"n": "港剧", "v": "香港"}, {"n": "韩剧", "v": "韩国"}, {"n": "欧美剧", "v": "欧美"}, {"n": "台剧", "v": "台湾"}, {"n": "日剧", "v": "日本"}, {"n": "纪录片", "v": "记录"}, {"n": "动漫", "v": "动漫"}, {"n": "综艺", "v": "综艺"}]}]
        for i, s in enumerate(self.sites):
            type_id = str(i)
            clean_name = s.get("name", f"站{i}").replace("TV-", "").replace("AV-", "")
            classes.append({"type_id": type_id, "type_name": clean_name})
            filters[type_id] = universal_filter
        return {"class": classes, "filters": filters}

    def homeVideoContent(self): return {"list": []}

    def categoryContent(self, tid, pg, filter, ext):
        try:
            idx = int(tid)
            if idx >= len(self.sites): return {"list": []}
            site = self.sites[idx]
            api_sign = hashlib.md5(site.get("api", "").encode("utf-8")).hexdigest()
            cache_key = f"CAT_{api_sign}_{pg}_{json.dumps(ext)}"
            cached = self._get_disk_cache(cache_key)
            if cached: return cached
            
            cate_id_val = ext.get("cateId", "") if ext else ""
            paichu = set(str(site.get("paichu", "")).split(",")) if site.get("paichu") else set()
            data = self._fetch(site["api"], {"ac": "detail", "pg": pg})
            video_list = []
            if data and "list" in data:
                for item in data["list"]:
                    if str(item.get("type_id")) in paichu: continue
                    if cate_id_val and cate_id_val not in item.get("type_name", ""): continue
                    item["vod_id"] = f"{idx}@@{item['vod_id']}"
                    video_list.append(item)
            res = {"page": int(data.get("page", 1)), "pagecount": int(data.get("pagecount", 1)), "limit": 20, "total": int(data.get("total", 0)), "list": video_list}
            self._set_disk_cache(cache_key, res)
            return res
        except: return {"list": []}

    def detailContent(self, array):
        if not array: return {"list": []}
        v_id = str(array[0])
        if v_id in self.memory_cache: return self.memory_cache[v_id]
        try:
            idx, vid = v_id.split("@@")
            site = self.sites[int(idx)]
            data = self._fetch(site["api"], {"ac": "detail", "ids": vid})
            if data and "list" in data:
                item = data["list"][0]
                item["vod_id"] = v_id
                res = {"list": [item]}
                self.memory_cache[v_id] = res
                return res
        except: pass
        return {"list": []}

    def searchContent(self, key, quick, pg="1"):
        if not key: return {"list": []}
        cache_key = f"SEARCH_{self.mode}_{key}"
        cached = self._get_disk_cache(cache_key)
        if cached: return cached
        
        targets = [(i, s) for i, s in enumerate(self.sites) if str(s.get("bz", "1")) != "0"]
        def search_one(t):
            idx, site = t
            try:
                paichu = set(str(site.get("paichu", "")).split(",")) if site.get("paichu") else set()
                data = self._fetch(site["api"], {"ac": "detail", "wd": key})
                res = []
                for item in data.get("list", []):
                    if str(item.get("type_id")) not in paichu:
                        site_name = site.get("name", "").replace("TV-", "").replace("AV-", "")
                        item["vod_name"] = f"[{site_name}] {item['vod_name']}"
                        item["vod_id"] = f"{idx}@@{item['vod_id']}"
                        res.append(item)
                return idx, res
            except: return idx, []

        temp = {}
        with ThreadPoolExecutor(max_workers=40) as ex:
            futures = [ex.submit(search_one, t) for t in targets]
            for f in as_completed(futures):
                idx, r = f.result()
                if r: temp[idx] = r
        
        final = []
        for i in sorted(temp.keys()): final.extend(temp[i])
        result = {"list": final}
        self._set_disk_cache(cache_key, result)
        return result

    def playerContent(self, flag, id, vipFlags):
        parse = 0 if (".m3u8" in id or ".mp4" in id) else 1
        return {"url": id, "header": {"User-Agent": "Mozilla/5.0"}, "parse": parse, "jx": 0}

    def localProxy(self, params): return [200, "video/MP2T", "", ""]
