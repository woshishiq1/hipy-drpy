# -*- coding: utf-8 -*-
import json
import base64
import urllib.parse
from Crypto.Cipher import AES
from Crypto.Util.Padding import pad, unpad
import binascii

from base.spider import Spider


class Spider(Spider):
    """DJ多多APP爬虫，适配TVBox接口"""

    def __init__(self):
        # 固定参数
        self.host1 = "https://new.djduoduo.com"
        self.host2 = "http://bdcdn.djduoduo.com"
        self.host3 = "http://hscdn.dianyinduoduo.com"
        self.extra = {
            "VerCode": 3966,
            "Ver": "3.9.66",
            "Channel": "Car",
            "Platform": "Android",
            "OSVer": 31,
            "Did": "120611636433",
            "AppId": 128,
            "Ts": 0,
            "VTs": 0
        }
        # AES加密参数（用于请求data和extra）
        self.enc_key = binascii.unhexlify("e82a4a775c295bbbe33f66828a368b90")
        self.enc_iv = binascii.unhexlify("8477d5a085c1d50d8a74811ec3e811e4")
        # AES解密参数（用于播放地址解密）
        self.dec_key = binascii.unhexlify("e4fd094dfcae98f352ddf81ee760d891")
        self.dec_iv = binascii.unhexlify("932ea49cfff68382f0516ccc63a52123")

        # 分类筛选默认值
        self.filter_defaults = {
            'tuijian': 'hot_v2',
            'gedan': 'hot_songlist',
            'pindao': 'Hot',          # 频道内部热歌/新歌筛选
            'yueku': '1',              # 乐库默认中文ID=1
            'shipin': 'new_svideo',
            'paihang': '100',          # 排行默认多多飙升榜
        }

    def aes_cbc_encrypt(self, data_str):
        """AES/CBC/PKCS7加密，返回base64字符串"""
        cipher = AES.new(self.enc_key, AES.MODE_CBC, self.enc_iv)
        data_bytes = data_str.encode('utf-8')
        padded = pad(data_bytes, AES.block_size)
        encrypted = cipher.encrypt(padded)
        return base64.b64encode(encrypted).decode('utf-8')

    def aes_cbc_decrypt(self, data_b64):
        """AES/CBC/PKCS7解密，返回明文字符串"""
        cipher = AES.new(self.dec_key, AES.MODE_CBC, self.dec_iv)
        encrypted = base64.b64decode(data_b64)
        decrypted = cipher.decrypt(encrypted)
        unpadded = unpad(decrypted, AES.block_size)
        return unpadded.decode('utf-8')

    def build_request_url(self, path, data_params):
        """构建带加密参数的请求URL"""
        data_json = json.dumps(data_params, separators=(',', ':'))
        extra_json = json.dumps(self.extra, separators=(',', ':'))

        data_enc = self.aes_cbc_encrypt(data_json)
        extra_enc = self.aes_cbc_encrypt(extra_json)

        encoded_data = urllib.parse.quote(data_enc)
        encoded_extra = urllib.parse.quote(extra_enc)

        return f"{self.host1}{path}&data={encoded_data}&extra={encoded_extra}"

    def fetch_json(self, path, data_params):
        """发送GET请求并解析JSON"""
        url = self.build_request_url(path, data_params)
        # 使用Spider自带的fetch方法
        resp = self.fetch(url)
        if resp and resp.status_code == 200:
            return resp.json()
        return {}

    # ---------- 数据解析辅助函数 ----------
    def parse_song_item(self, item):
        """解析单个歌曲项，返回TVBox列表项格式"""
        item_id = item.get('Id')
        if not item_id:
            return None
        id_str = str(item_id)
        id_suffix = id_str[-3:]  # 取后三位用于拼图

        # 封面图
        cover = item.get('Cover', '')
        if cover:
            if '/dj/' in cover:
                img = self.host2 + cover
            else:
                img = f"{self.host2}/dj/cover/{id_suffix}/150/{cover}"
        else:
            img = "https://icdn.binmt.cc/2506/6847a82912a35.png"

        # 标题
        title = item.get('Name', '未知歌曲')
        # 描述（用户+时长+播放量）
        user = item.get('User', '')
        duration = item.get('Duration', 0)
        play_cnt = item.get('PlCntAll', 0)
        desc = f"{user} • {duration//60}:{duration%60:02d} • {play_cnt}"

        # 播放地址需要解密Path字段
        path_enc = item.get('Path', '')
        if path_enc:
            try:
                real_path = self.aes_cbc_decrypt(path_enc)
                # 完整音频URL
                play_url = f"{self.host2}/dj/{id_suffix}/{real_path}"
            except:
                play_url = ""
        else:
            play_url = ""

        vod = {
            "vod_id": f"music_{item_id}",
            "vod_name": title,
            "vod_pic": img,
            "vod_remarks": desc,
            "vod_content": desc,
            "vod_play_from": "DJ多多",
            "vod_play_url": f"播放${play_url}" if play_url else ""
        }
        return vod

    def parse_video_item(self, item):
        """解析视频项"""
        item_id = item.get('Id')
        id_str = str(item_id)
        id_suffix = id_str[-3:]
        cover = item.get('Cover', '')
        img = f"{self.host2}/v/cover/{id_suffix}/150/{cover}"
        title = item.get('Desc', '未知视频')
        path_enc = item.get('Path', '')
        if path_enc:
            try:
                real_path = self.aes_cbc_decrypt(path_enc)
                play_url = f"{self.host3}/v/480p/{id_suffix}/{real_path}"
            except:
                play_url = ""
        else:
            play_url = ""
        vod = {
            "vod_id": f"video_{item_id}",
            "vod_name": title,
            "vod_pic": img,
            "vod_remarks": "",
            "vod_content": "",
            "vod_play_from": "DJ多多",
            "vod_play_url": f"播放${play_url}" if play_url else ""
        }
        return vod

    def parse_playlist_item(self, item):
        """解析歌单项（用于分类列表）"""
        item_id = item.get('Id')
        name = item.get('Name', '未知歌单')
        cover = item.get('Cover', '')
        if cover:
            if '/dj/' in cover:
                img = self.host2 + cover
            else:
                id_suffix = str(item_id)[-3:] if item_id else '000'
                img = f"{self.host2}/img/songlist/cover/{id_suffix}/150/{cover}"
        else:
            img = "https://icdn.binmt.cc/2506/6847a82912a35.png"
        vod = {
            "vod_id": f"playlist_{item_id}",
            "vod_name": name,
            "vod_pic": img,
            "vod_remarks": "",
            "vod_content": "",
            "vod_play_from": "DJ多多",
            "vod_play_url": ""  # 歌单本身无播放地址，需进入详情
        }
        return vod

    # ---------- TVBox 必需接口 ----------
    def homeContent(self, filter):
        """返回首页分类和推荐列表"""
        result = {}
        # 分类（模拟海阔视界顶部的几个icon）
        classes = [
            {'type_id': 'tuijian', 'type_name': '推荐'},
            {'type_id': 'gedan', 'type_name': '歌单'},
            {'type_id': 'pindao', 'type_name': '频道'},
            {'type_id': 'yueku', 'type_name': '乐库'},
            {'type_id': 'shipin', 'type_name': '视频'},
            {'type_id': 'paihang', 'type_name': '排行'},
        ]

        # 为每个分类添加filter定义
        # 推荐筛选
        classes[0]['filter'] = {
            'tj1': [
                {'n': '热歌', 'v': 'hot_v2'},
                {'n': '3D', 'v': '100'},
                {'n': '电音', 'v': '105'},
                {'n': '车载', 'v': '104'},
                {'n': '无损', 'v': 'sq'},
                {'n': '新歌', 'v': 'new'},
                {'n': '原创', 'v': 'ori'},
                {'n': '中文', 'v': '107'},
                {'n': '伤感', 'v': '103'},
                {'n': '铃声', 'v': '109'},
                {'n': '老歌', 'v': '108'},
                {'n': 'DJ', 'v': '101'},
            ]
        }
        # 歌单筛选
        classes[1]['filter'] = {
            'gd_filter': [
                {'n': '最热', 'v': 'hot_songlist'},
                {'n': '最新', 'v': 'new_songlist'},
                {'n': '抖音', 'v': '10000'},
                {'n': '伤感', 'v': '10003'},
                {'n': '车载', 'v': '10007'},
                {'n': '蹦迪', 'v': '10012'},
                {'n': '3D', 'v': '10009'},
                {'n': '串烧', 'v': '10008'},
            ]
        }
        # 频道筛选（热歌/新歌），频道ID固定为1（中文）
        classes[2]['filter'] = {
            'pd_filter': [
                {'n': '热歌', 'v': 'Hot'},
                {'n': '新歌', 'v': 'New'},
            ]
        }
        # 乐库筛选
        classes[3]['filter'] = {
            'yk_filter': [
                {'n': '中文', 'v': '1'},
                {'n': '英文', 'v': '5'},
                {'n': '电音', 'v': '11'},
                {'n': 'MC喊麦', 'v': '3'},
                {'n': '长DJ', 'v': '29'},
                {'n': '电锯', 'v': '6'},
                {'n': '夜店', 'v': '14'},
                {'n': '铃声', 'v': '10'},
                {'n': '慢摇', 'v': '2'},
                {'n': '车载', 'v': '13'},
                {'n': '社会摇', 'v': '27'},
                {'n': '网友上传', 'v': '30'},
                {'n': '3D环绕', 'v': '31'},
                {'n': '现场', 'v': '16'},
                {'n': '节奏', 'v': '21'},
                {'n': 'House', 'v': '22'},
                {'n': '越南鼓', 'v': '23'},
                {'n': '舞曲', 'v': '8'},
                {'n': '加快', 'v': '24'},
                {'n': '苏荷', 'v': '18'},
                {'n': 'Remix', 'v': '25'},
                {'n': '氛围', 'v': '26'},
                {'n': 'RNB', 'v': '28'},
                {'n': '日韩', 'v': '9'},
                {'n': '串烧', 'v': '4'},
            ]
        }
        # 视频筛选
        classes[4]['filter'] = {
            'sp_filter': [
                {'n': '新榜', 'v': 'new_svideo'},
                {'n': '热榜', 'v': 'hot_svideo'},
                {'n': '电音', 'v': '1010'},
                {'n': '歌曲', 'v': '1001'},
                {'n': '动漫', 'v': '1002'},
                {'n': '情感', 'v': '1003'},
                {'n': '美女', 'v': '1007'},
                {'n': '搞笑', 'v': '1005'},
                {'n': '正能量', 'v': '1006'},
                {'n': '沙雕', 'v': '1009'},
            ]
        }
        # 排行筛选
        classes[5]['filter'] = {
            'ph_filter': [
                {'n': '多多飙升榜', 'v': '100'},
                {'n': '多多TOP500', 'v': '101'},
                {'n': '电音排行榜', 'v': '105'},
                {'n': '车载音乐榜', 'v': '110'},
                {'n': '多多分享榜', 'v': '104'},
                {'n': '中文舞曲榜', 'v': '107'},
                {'n': '英文舞曲榜', 'v': '108'},
                {'n': '串烧舞曲榜', 'v': '109'},
            ]
        }

        result['class'] = classes

        # 首页推荐内容（第一页，act=hot_v2）
        data = self.fetch_json("/v4/getlist.php?act=hot_v2", {"PageNo": 0})
        vod_list = []
        if data and 'List' in data:
            for item in data['List']:
                vod = self.parse_song_item(item)
                if vod and vod.get('vod_play_url'):
                    vod_list.append(vod)
        result['list'] = vod_list
        return result

    def categoryContent(self, tid, pg=1, filter=False, extend=None):
        """分类页面内容，支持filter筛选"""
        pg = int(pg) - 1  # 转换为0起始页码
        vod_list = []

        # 获取筛选值，如果没有则使用默认
        if extend is None:
            extend = {}

        # 根据tid构造请求参数
        if tid == 'tuijian':
            filter_val = extend.get('tj1', self.filter_defaults['tuijian'])
            if filter_val.isdigit():
                act = "homechn"
                data_params = {"Id": int(filter_val), "PageNo": pg}
            else:
                act = filter_val
                data_params = {"PageNo": pg}
            data = self.fetch_json(f"/v4/getlist.php?act={act}", data_params)
            if data and 'List' in data:
                for item in data['List']:
                    vod = self.parse_song_item(item)
                    if vod:
                        vod_list.append(vod)

        elif tid == 'gedan':
            filter_val = extend.get('gd_filter', self.filter_defaults['gedan'])
            if filter_val.isdigit():
                act = "chn_songlist"
                data_params = {"Id": int(filter_val), "PageNo": pg}
            else:
                act = filter_val
                data_params = {"PageNo": pg}
            data = self.fetch_json(f"/v4/getlist.php?act={act}", data_params)
            if data and 'List' in data:
                for item in data['List']:
                    vod = self.parse_playlist_item(item)
                    if vod:
                        vod_list.append(vod)

        elif tid == 'pindao':
            # 频道分类简化：固定使用频道ID=1（中文），筛选热歌/新歌
            filter_val = extend.get('pd_filter', self.filter_defaults['pindao'])
            # 频道ID固定为1
            data_params = {"Id": 1, "PageNo": pg, "Type": filter_val}
            data = self.fetch_json("/v4/getlist.php?act=chn", data_params)
            if data and 'List' in data:
                for item in data['List']:
                    vod = self.parse_song_item(item)
                    if vod:
                        vod_list.append(vod)

        elif tid == 'yueku':
            filter_val = extend.get('yk_filter', self.filter_defaults['yueku'])
            data_params = {"Id": int(filter_val), "PageNo": pg, "Type": "Up"}
            data = self.fetch_json("/v4/getlist.php?act=cat", data_params)
            if data and 'List' in data:
                for item in data['List']:
                    vod = self.parse_song_item(item)
                    if vod:
                        vod_list.append(vod)

        elif tid == 'shipin':
            filter_val = extend.get('sp_filter', self.filter_defaults['shipin'])
            if filter_val.isdigit():
                act = "chn_svideo"
                data_params = {"Id": int(filter_val), "PageNo": pg}
            else:
                act = filter_val
                data_params = {"PageNo": pg}
            data = self.fetch_json(f"/v4/getlist.php?act={act}", data_params)
            if data and 'List' in data:
                for item in data['List']:
                    vod = self.parse_video_item(item)
                    if vod:
                        vod_list.append(vod)

        elif tid == 'paihang':
            filter_val = extend.get('ph_filter', self.filter_defaults['paihang'])
            data_params = {"Id": int(filter_val), "PageNo": pg}
            data = self.fetch_json("/v4/getlist.php?act=rank_detail", data_params)
            if data and 'List' in data:
                for item in data['List']:
                    vod = self.parse_song_item(item)
                    if vod:
                        vod_list.append(vod)

        else:
            # 未知分类返回空
            pass

        return {
            'page': pg + 1,
            'pagecount': 999,  # 假设无限
            'limit': 20,
            'total': len(vod_list),
            'list': vod_list
        }

    def detailContent(self, ids):
        """详情页，支持歌曲ID和歌单ID"""
        vod_id = ids[0]
        vod_list = []

        if vod_id.startswith('music_'):
            # 单个歌曲详情（从ID中提取原ID）
            real_id = vod_id.replace('music_', '')
            # 需要重新获取数据？简单起见，直接构造一个vod对象，但缺少详细信息
            # 可以尝试搜索或单独请求，这里返回一个占位
            vod = {
                "vod_id": vod_id,
                "vod_name": "未知歌曲",
                "vod_pic": "",
                "vod_remarks": "",
                "vod_content": "",
                "vod_play_from": "DJ多多",
                "vod_play_url": ""
            }
            vod_list.append(vod)

        elif vod_id.startswith('playlist_'):
            # 歌单详情，需要请求歌单内歌曲列表
            playlist_id = vod_id.replace('playlist_', '')
            data = self.fetch_json("/v4/getlist.php?act=songlistdetail", {"Id": int(playlist_id), "PageNo": 0})
            songs = []
            if data and 'List' in data:
                for item in data['List']:
                    song = self.parse_song_item(item)
                    if song and song.get('vod_play_url'):
                        # 提取播放地址，拼接到vod_play_url中
                        songs.append(song)

            if songs:
                # 构造详情vod，将歌曲作为“剧集”列表
                play_urls = []
                for song in songs:
                    # 格式：歌曲名$播放地址
                    play_urls.append(f"{song['vod_name']}${song['vod_play_url'].split('$')[1]}")
                vod = {
                    "vod_id": vod_id,
                    "vod_name": f"歌单{playlist_id}",
                    "vod_pic": songs[0].get('vod_pic', ''),
                    "vod_remarks": "",
                    "vod_content": "",
                    "vod_play_from": "DJ多多",
                    "vod_play_url": "#".join(play_urls)
                }
                vod_list.append(vod)
            else:
                # 空歌单
                vod_list.append({
                    "vod_id": vod_id,
                    "vod_name": "空歌单",
                    "vod_pic": "",
                    "vod_remarks": "",
                    "vod_content": "",
                    "vod_play_from": "DJ多多",
                    "vod_play_url": ""
                })

        else:
            # 未知类型
            pass

        return {'list': vod_list}

    def searchContent(self, key, quick=False):
        """搜索歌曲"""
        vod_list = []
        page = 0
        data = self.fetch_json("/v4/search.php?act=sch", {
            "Query": key,
            "From": "HotSearch",
            "Uid": 9447509,
            "PageNo": page
        })
        if data and 'List' in data:
            for item in data['List']:
                vod = self.parse_song_item(item)
                if vod and vod.get('vod_play_url'):
                    vod_list.append(vod)
        return {'list': vod_list}

    def playerContent(self, flag, id, vipFlags):
        """播放器解析，直接返回真实地址"""
        return {"playUrl": id, "flag": flag}

    # ---------- 辅助方法 ----------
    def localProxy(self, param):
        # 不需要本地代理
        return []