# -*- coding: utf-8 -*-
# @Author  : Doubebly
# @Time    : 2025/5/1 21:38

import re
import sys
import requests
import base64
sys.path.append('..')
from base.spider import Spider


class Spider(Spider):
    def getName(self):
        return "live_GanChengTv"

    def init(self, extend):
        pass

    def getDependence(self):
        return []

    def isVideoFormat(self, url):
        pass

    def manualVideoCheck(self):
        pass


    def liveContent(self, url):
        data_list = [
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/CCTV1.png','group-title': '赣橙TV', 'name': 'CCTV1综合', 'fun': 'ganchengtv', 'pid': 'CCTV1HD'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/CCTV2.png','group-title': '赣橙TV', 'name': 'CCTV2财经', 'fun': 'ganchengtv', 'pid': 'CCTV2HD'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/CCTV3.png','group-title': '赣橙TV', 'name': 'CCTV3综艺', 'fun': 'ganchengtv', 'pid': 'CCTV3'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/CCTV4.png','group-title': '赣橙TV', 'name': 'CCTV4中文国际', 'fun': 'ganchengtv', 'pid': 'CCTV4HD'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/CCTV5.png','group-title': '赣橙TV', 'name': 'CCTV5体育', 'fun': 'ganchengtv', 'pid': 'CCTV5'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/CCTV6.png','group-title': '赣橙TV', 'name': 'CCTV6电影', 'fun': 'ganchengtv', 'pid': 'CCTV6'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/CCTV8.png','group-title': '赣橙TV', 'name': 'CCTV8电视剧', 'fun': 'ganchengtv', 'pid': 'CCTV8'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/CCTV9.png','group-title': '赣橙TV', 'name': 'CCTV9纪录', 'fun': 'ganchengtv', 'pid': 'CCTV9HD'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/CCTV10.png','group-title': '赣橙TV', 'name': 'CCTV10科教', 'fun': 'ganchengtv', 'pid': 'CCTV10HD'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/CCTV11.png','group-title': '赣橙TV', 'name': 'CCTV11戏曲', 'fun': 'ganchengtv', 'pid': 'CCTV11'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/CCTV12.png','group-title': '赣橙TV', 'name': 'CCTV12社会与法', 'fun': 'ganchengtv', 'pid': 'CCTV12HD'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/CCTV13.png','group-title': '赣橙TV', 'name': 'CCTV13新闻', 'fun': 'ganchengtv', 'pid': 'CCTV13'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/CCTV14.png','group-title': '赣橙TV', 'name': 'CCTV14少儿', 'fun': 'ganchengtv', 'pid': 'CCTV14HD'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/CCTV15.png','group-title': '赣橙TV', 'name': 'CCTV15音乐', 'fun': 'ganchengtv', 'pid': 'CCTV15'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/CETV1.png','group-title': '赣橙TV', 'name': '中国教育台1', 'fun': 'ganchengtv', 'pid': 'CETV1HD'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/CETV4.png','group-title': '赣橙TV', 'name': '中国教育台4', 'fun': 'ganchengtv', 'pid': 'CETV4'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/北京卫视.png','group-title': '赣橙TV', 'name': '北京卫视', 'fun': 'ganchengtv', 'pid': 'BEIJHD'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/东方卫视.png','group-title': '赣橙TV', 'name': '东方卫视', 'fun': 'ganchengtv', 'pid': 'DONGFHD'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/天津卫视.png','group-title': '赣橙TV', 'name': '天津卫视', 'fun': 'ganchengtv', 'pid': 'TIANJHD'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/重庆卫视.png','group-title': '赣橙TV', 'name': '重庆卫视', 'fun': 'ganchengtv', 'pid': 'CHONGQHD'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/黑龙江卫视.png','group-title': '赣橙TV', 'name': '黑龙江卫视', 'fun': 'ganchengtv', 'pid': 'HEILJHD'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/吉林卫视.png','group-title': '赣橙TV', 'name': '吉林卫视', 'fun': 'ganchengtv', 'pid': 'JILHD'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/辽宁卫视.png','group-title': '赣橙TV', 'name': '辽宁卫视', 'fun': 'ganchengtv', 'pid': 'LIAONHD'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/内蒙古卫视.png','group-title': '赣橙TV', 'name': '内蒙古卫视', 'fun': 'ganchengtv', 'pid': 'NMGWS'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/宁夏卫视.png','group-title': '赣橙TV', 'name': '宁夏卫视', 'fun': 'ganchengtv', 'pid': 'NXWS'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/甘肃卫视.png','group-title': '赣橙TV', 'name': '甘肃卫视', 'fun': 'ganchengtv', 'pid': 'GSWS'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/青海卫视.png','group-title': '赣橙TV', 'name': '青海卫视', 'fun': 'ganchengtv', 'pid': 'QHWS'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/陕西卫视.png','group-title': '赣橙TV', 'name': '陕西卫视', 'fun': 'ganchengtv', 'pid': 'SXTV'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/河北卫视.png','group-title': '赣橙TV', 'name': '河北卫视', 'fun': 'ganchengtv', 'pid': 'HAIBHD'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/山西卫视.png','group-title': '赣橙TV', 'name': '山西卫视', 'fun': 'ganchengtv', 'pid': 'SXWS'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/山东卫视.png','group-title': '赣橙TV', 'name': '山东卫视', 'fun': 'ganchengtv', 'pid': 'SHANDHD'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/安徽卫视.png','group-title': '赣橙TV', 'name': '安徽卫视', 'fun': 'ganchengtv', 'pid': 'ANHUIHD'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/河南卫视.png','group-title': '赣橙TV', 'name': '河南卫视', 'fun': 'ganchengtv', 'pid': 'HENHD'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/湖北卫视.png','group-title': '赣橙TV', 'name': '湖北卫视', 'fun': 'ganchengtv', 'pid': 'HUBEIHD'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/湖南卫视.png','group-title': '赣橙TV', 'name': '湖南卫视', 'fun': 'ganchengtv', 'pid': 'HUNANHD'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/江西卫视.png','group-title': '赣橙TV', 'name': '江西卫视', 'fun': 'ganchengtv', 'pid': 'JXWSHD'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/江苏卫视.png','group-title': '赣橙TV', 'name': '江苏卫视', 'fun': 'ganchengtv', 'pid': 'JIANGSHD'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/浙江卫视.png','group-title': '赣橙TV', 'name': '浙江卫视', 'fun': 'ganchengtv', 'pid': 'ZHEJHD'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/东南卫视.png','group-title': '赣橙TV', 'name': '东南卫视', 'fun': 'ganchengtv', 'pid': 'DONGNHD'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/广东卫视.png','group-title': '赣橙TV', 'name': '广东卫视', 'fun': 'ganchengtv', 'pid': 'GUANGDHD'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/深圳卫视.png','group-title': '赣橙TV', 'name': '深圳卫视', 'fun': 'ganchengtv', 'pid': 'SHENZHD'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/广西卫视.png','group-title': '赣橙TV', 'name': '广西卫视', 'fun': 'ganchengtv', 'pid': 'GUANGXHD'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/云南卫视.png','group-title': '赣橙TV', 'name': '云南卫视', 'fun': 'ganchengtv', 'pid': 'YUNNHD'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/贵州卫视.png','group-title': '赣橙TV', 'name': '贵州卫视', 'fun': 'ganchengtv', 'pid': 'GUIZHD'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/四川卫视.png','group-title': '赣橙TV', 'name': '四川卫视', 'fun': 'ganchengtv', 'pid': 'SICHD'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/新疆卫视.png','group-title': '赣橙TV', 'name': '新疆卫视', 'fun': 'ganchengtv', 'pid': 'XJWS'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/兵团卫视.png','group-title': '赣橙TV', 'name': '兵团卫视', 'fun': 'ganchengtv', 'pid': 'BTWS'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/西藏卫视.png','group-title': '赣橙TV', 'name': '西藏卫视', 'fun': 'ganchengtv', 'pid': 'XZWS'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/海南卫视.png','group-title': '赣橙TV', 'name': '海南卫视', 'fun': 'ganchengtv', 'pid': 'HAINHD'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/哈哈炫动.png','group-title': '赣橙TV', 'name': '哈哈炫动', 'fun': 'ganchengtv', 'pid': 'XDKT'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/金鹰纪实.png','group-title': '赣橙TV', 'name': '金鹰纪实', 'fun': 'ganchengtv', 'pid': 'JYJSHD'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/金鹰卡通.png','group-title': '赣橙TV', 'name': '金鹰卡通', 'fun': 'ganchengtv', 'pid': 'JXKT'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/江西都市.png','group-title': '赣橙TV', 'name': '江西都市', 'fun': 'ganchengtv', 'pid': 'JXDS'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/江西公共农业.png','group-title': '赣橙TV', 'name': '江西公共农业', 'fun': 'ganchengtv', 'pid': 'JXGGNY'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/江西经济生活.png','group-title': '赣橙TV', 'name': '江西经济生活', 'fun': 'ganchengtv', 'pid': 'JXJJSH'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/江西少儿.png','group-title': '赣橙TV', 'name': '江西少儿', 'fun': 'ganchengtv', 'pid': 'JXSE'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/江西新闻.png','group-title': '赣橙TV', 'name': '江西新闻', 'fun': 'ganchengtv', 'pid': 'JXXWHD'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/江西影视旅游.png','group-title': '赣橙TV', 'name': '江西影视旅游', 'fun': 'ganchengtv', 'pid': 'JXYS'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/江西风尚购物.png','group-title': '赣橙TV', 'name': '江西风尚购物', 'fun': 'ganchengtv', 'pid': 'FSGW'},
            {'tvg-id': '', 'tvg-name': '', 'tvg-logo': 'https://logo.doube.eu.org/江西教育.png','group-title': '赣橙TV', 'name': '江西教育', 'fun': 'ganchengtv', 'pid': 'JXJY'},
        ]
        tv_list = ['#EXTM3U']

        for i in data_list:
            tvg_id = i['tvg-id']
            tvg_name = i['tvg-name']
            tvg_logo = i['tvg-logo']
            group_name = i['group-title']
            name = i['name']
            fun = i['fun']
            pid = i['pid']
            tv_list.append(f'#EXTINF:-1 tvg-id="{tvg_id}" tvg-name="{tvg_name}" tvg-logo="{tvg_logo}" group-title="{group_name}",{name}')
            tv_list.append(f'{self.getProxyUrl()}&fun={fun}&pid={pid}')

        return '\n'.join(tv_list)

    def homeContent(self, filter):
        return {}

    def homeVideoContent(self):
        return {}

    def categoryContent(self, cid, page, filter, ext):
        return {}

    def detailContent(self, did):
        return {}

    def searchContent(self, key, quick, page='1'):
        return {}

    def searchContentPage(self, keywords, quick, page):
        return {}

    def playerContent(self, flag, pid, vipFlags):
        return {}

    def localProxy(self, params):
        _fun = params.get('fun', None)
        _type = params.get('type', None)
        if _fun is not None:
            fun = getattr(self, f'fun_{_fun}')
            return fun(params)
        return [302, "text/plain", None, {'Location': 'https://sf1-cdn-tos.huoshanstatic.com/obj/media-fe/xgplayer_doc_video/mp4/xgplayer-demo-720p.mp4'}]


    def fun_ganchengtv(self, params):
        pid = params.get('pid')
        url = f'https://api-playerlive-jx.skysrt.com/rights/getChannelPlayUrl?appId=cc725834911498506790&channelId={pid}&token=9369b7b3d27936006480582ca7dc1518'
        h = {'User-Agent': 'com.coocaa.iptv.IPTVApplication'}
        r = requests.get(url, headers=h)
        play_url = r.json()['data']['playUrlModel']['url'] + "&us=9369b7b3d27936006480582ca7dc1518"
        return [302, "text/plain", None, {'Location': play_url}]

    def proxyM3u8(self, params):
        pass

    def destroy(self):

        return '正在Destroy'

    def b64encode(self, data):
        return base64.b64encode(data.encode('utf-8')).decode('utf-8')

    def b64decode(self, data):
        return base64.b64decode(data.encode('utf-8')).decode('utf-8')



if __name__ == '__main__':
    pass
