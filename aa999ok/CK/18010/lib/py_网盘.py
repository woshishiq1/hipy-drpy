# coding=utf-8
# !/usr/bin/python
import sys
sys.path.append('..')
from base.spider import Spider
import json


class Spider(Spider):  # 元类 默认的元类 type
    def getName(self):
        return "Alist"

    def init(self, extend=""):
        print("============{0}============".format(extend))
        pass

    def isVideoFormat(self, url):
        pass

    def manualVideoCheck(self):
        pass

    def homeContent(self, filter):
        result = {}
        cateManual = {
              "嗨翻":"https://pan.hikerfans.com",
              "弱水分享站":"http://shicheng.wang:555/我的影视",
              "小雅":"http://alist.xiaoya.pro",
              "9T(Adult)":"https://drive.9t.ee",
              "梓澪の妙妙屋":"https://xn--i0v44m.xyz",
              "资源小站":"https://pan.142856.xyz",
              "晴园的宝藏库":"https://alist.52qy.repl.co",
              "米奇妙妙屋":"https://anime.mqmmw.ga",
              "小兵组网盘影视":"https://6vv.app",
              "小光盘":"https://alist.xiaoguanxiaocheng.life",
              "一只鱼":"https://alist.youte.ml",
              "七米蓝":"https://al.chirmyram.com", 
              "非盘":"http://www.feifwp.top",
              "帅盘":"https://hi.shuaipeng.wang",
              "神族九帝":"https://alist.shenzjd.com",
              "姬路白雪":"https://pan.jlbx.xyz",
              "听闻网盘":"https://wangpan.sangxuesheng.com",
              "DISK":"http://124.222.140.243:8080",
              "云播放":"https://quanzi.laoxianghuijia.cn",
              "星梦":"https://pan.bashroot.top",
              "小江":"https://dyj.me",
              "触光":"https://pan.ichuguang.com",
              "好汉吧":"https://8023.haohanba.cn",
              "AUNEY":"http://121.227.25.116:8008",
              "资源小站":"https://960303.xyz/",
              "神器云": "https://quanzi.laoxianghuijia.cn",
              "fenwe":"http://www.fenwe.tk:5244",
              "轻弹浅唱":"https://g.xiang.lol"
        }
        classes = []
        for k in cateManual:
            classes.append({
                'type_name': k,
				"type_flag": "1",
                'type_id': cateManual[k]
            })
        result['class'] = classes
        if (filter):
            result['filters'] = self.config['filter']
        return result

    def homeVideoContent(self):
        result = {
            'list': []
        }
        return result

    def categoryContent(self, tid, pg, filter, extend):
        result = {}
        ulen = len(self.config['url'])
        pat = tid[ulen:] + '/'
        param = {
            "path": pat
        }
        rsp = self.postJson(self.config['url'] + '/api/fs/list', param)
        jo = json.loads(rsp.text)
        videos = []
        vodList = jo['data']['content']
        for vod in vodList:
            img = vod['thumb']
            if len(img) == 0:
                if vod['type'] == 1:
                    img = "http://img1.3png.com/281e284a670865a71d91515866552b5f172b.png"
            aid = pat
            tag = "file"
            remark = "文件"
            if vod['type'] == 1:
                tag = "folder"
                remark = "文件夹"
                aid = self.config['url'] + aid + vod['name']
            else:
                aid = aid + vod['name']
            videos.append({
                "vod_id":  aid,
                "vod_name": vod['name'],
                "vod_pic": img,
                "vod_tag": tag,
                "vod_remarks": remark
            })
        result['list'] = videos
        result['page'] = 1
        result['pagecount'] = 1
        result['limit'] = 999
        result['total'] = 999999
        return result

    def detailContent(self, array):
        fileName = array[0]
        param = {
            "path": fileName,
            "password": "",
            "page_num": 1,
            "page_size": 100
        }
        rsp = self.postJson(self.config['url'] + '/api/fs/get', param)
        jo = json.loads(rsp.text)
        videos = []
        vodList = jo['data']
        url = vodList['raw_url']
        vId = self.config['url'] + fileName
        name = vodList['name']
        pic = vodList['thumb']
        tag = "file"
        if vodList['type'] == 1:
            tag = "folder"
        vod = {
            "vod_id": vId,
            "vod_name": name,
            "vod_pic": pic,
            "vod_tag": tag,
            "vod_play_from": "播放",
            "vod_play_url": name + '$' + url
        }
        result = {
            'list': [
                vod
            ]
        }
        return result

    def searchContent(self, key, quick):
        result = {
            'list': []
        }
        return result

    def playerContent(self, flag, id, vipFlags):
        result = {}
        url = id
        result["parse"] = 0
        result["playUrl"] = ''
        result["url"] = url
        return result

    config = {
        "player": {},
        "filter": {},
        "url": 'https://al.chirmyram.com'
    }
    header = {}

    def localProxy(self, param):
        return [200, "video/MP2T", action, ""]
