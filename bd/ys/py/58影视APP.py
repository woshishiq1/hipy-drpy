# coding=utf-8
# !/usr/bin/python

"""

作者 丢丢喵 内容均从互联网收集而来 仅供交流学习使用 严禁用于商业用途 请于24小时内删除
         ====================Diudiumiao====================

"""

from Crypto.Util.Padding import unpad
from Crypto.Util.Padding import pad
from urllib.parse import unquote
from Crypto.Cipher import ARC4
from urllib.parse import quote
from base.spider import Spider
from Crypto.Cipher import AES
from datetime import datetime
from bs4 import BeautifulSoup
from base64 import b64decode
import urllib.request
import urllib.parse
import datetime
import binascii
import requests
import base64
import json
import time
import sys
import re
import os

sys.path.append('..')

xurl = "https://a131.ybbyelc.com"  # https://58ys.app/

headerx = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.87 Safari/537.36'
          }

headers = {
    'User-Agent': 'Dart/3.9 (dart:io)',
    'version': '1.3.86',
    'device': 'android',
    'host': 'a131.ybbyelc.com',
    'content-type': 'application/json',
    'Timestamp': str(int(time.time() * 1000)),
    'clienttype': 'phone',
    'token': '',
    'Accept-Encoding': 'gzip, deflate',
    'Content-Length': '37'
          }

class Spider(Spider):

    def getName(self):
        return "丢丢喵"

    def init(self, extend):
        pass

    def isVideoFormat(self, url):
        pass

    def manualVideoCheck(self):
        pass

    def homeContent(self, filter):
        result = {}
        result = {"class": [{"type_id": "电影@影视", "type_name": "丢丢🌠电影"},
                            {"type_id": "连续剧@影视", "type_name": "丢丢🌠连续剧"},
                            {"type_id": "动漫@影视", "type_name": "丢丢🌠动漫"},
                            {"type_id": "综艺@影视", "type_name": "丢丢🌠综艺"},
                            {"type_id": "短剧@短剧", "type_name": "丢丢🌠短剧"}],
                  "list": [],
                  "filters": {"电影@影视": [{"key": "地区",
                                      "name": "地区",
                                      "value": [{"n": "全部", "v": ""},
                                                {"n": "中国大陆", "v": "中国大陆"},
                                                {"n": "中国香港", "v": "中国香港"},
                                                {"n": "中国台湾", "v": "中国台湾"},
                                                {"n": "韩国", "v": "韩国"},
                                                {"n": "泰国", "v": "泰国"},
                                                {"n": "日本", "v": "日本"},
                                                {"n": "美国", "v": "美国"},
                                                {"n": "英国", "v": "英国"},
                                                {"n": "法国", "v": "法国"},
                                                {"n": "德国", "v": "德国"},
                                                {"n": "西班牙", "v": "西班牙"},
                                                {"n": "新加坡", "v": "新加坡"},
                                                {"n": "加拿大", "v": "加拿大"},
                                                {"n": "菲律宾", "v": "菲律宾"},
                                                {"n": "非洲", "v": "非洲"},
                                                {"n": "巴西", "v": "巴西"},
                                                {"n": "捷克", "v": "捷克"},
                                                {"n": "俄罗斯", "v": "俄罗斯"},
                                                {"n": "土耳其", "v": "土耳其"},
                                                {"n": "墨西哥", "v": "墨西哥"},
                                                {"n": "阿根廷", "v": "阿根廷"},
                                                {"n": "马来西亚", "v": "马来西亚"},
                                                {"n": "波兰", "v": "波兰"},
                                                {"n": "乌克兰", "v": "乌克兰"},
                                                {"n": "罗马尼亚", "v": "罗马尼亚"},
                                                {"n": "东南亚", "v": "东南亚"}]},
                                      {"key": "类型",
                                      "name": "类型",
                                      "value": [{"n": "全部", "v": ""},
                                                {"n": "喜剧", "v": "喜剧"},
                                                {"n": "爱情", "v": "爱情"},
                                                {"n": "恐怖", "v": "恐怖"},
                                                {"n": "动作", "v": "动作"},
                                                {"n": "科幻", "v": "科幻"},
                                                {"n": "剧情", "v": "剧情"},
                                                {"n": "战争", "v": "战争"},
                                                {"n": "警匪", "v": "警匪"},
                                                {"n": "纪录片", "v": "纪录片"},
                                                {"n": "犯罪", "v": "犯罪"},
                                                {"n": "动画", "v": "动画"},
                                                {"n": "奇幻", "v": "奇幻"},
                                                {"n": "武侠", "v": "武侠"},
                                                {"n": "冒险", "v": "冒险"},
                                                {"n": "枪战", "v": "枪战"},
                                                {"n": "悬疑", "v": "悬疑"},
                                                {"n": "惊悚", "v": "惊悚"},
                                                {"n": "经典", "v": "经典"},
                                                {"n": "青春", "v": "青春"},
                                                {"n": "文艺", "v": "文艺"},
                                                {"n": "微电影", "v": "微电影"},
                                                {"n": "古装", "v": "古装"},
                                                {"n": "历史", "v": "历史"},
                                                {"n": "运动", "v": "运动"},
                                                {"n": "农村", "v": "农村"},
                                                {"n": "儿童", "v": "儿童"},
                                                {"n": "网络电影", "v": "网络电影"},
                                                {"n": "情色", "v": "情色"},
                                                {"n": "同性", "v": "同性"}]},
                                      {"key": "列表",
                                      "name": "列表",
                                      "value": [{"n": "全部", "v": ""},
                                                {"n": "最新上传", "v": "Time"},
                                                {"n": "人气高", "v": "Hits"},
                                                {"n": "评分高", "v": "Score"}]},
                                      {"key": "年代",
                                      "name": "年代",
                                      "value": [{"n": "全部", "v": ""},
                                                {"n": "2026", "v": "2026"},
                                                {"n": "2025", "v": "2025"},
                                                {"n": "2024", "v": "2024"},
                                                {"n": "2023", "v": "2023"},
                                                {"n": "2022", "v": "2022"},
                                                {"n": "2021", "v": "2021"},
                                                {"n": "2020", "v": "2020"},
                                                {"n": "2019", "v": "2019"},
                                                {"n": "2018", "v": "2018"},
                                                {"n": "2017", "v": "2017"},
                                                {"n": "2016", "v": "2016"},
                                                {"n": "2015", "v": "2015"},
                                                {"n": "2014", "v": "2014"},
                                                {"n": "2013", "v": "2013"},
                                                {"n": "2012", "v": "2012"},
                                                {"n": "2011", "v": "2011"},
                                                {"n": "2010", "v": "2010"},
                                                {"n": "2009", "v": "2009"},
                                                {"n": "2008", "v": "2008"},
                                                {"n": "2007", "v": "2007"},
                                                {"n": "2006", "v": "2006"},
                                                {"n": "2005", "v": "2005"},
                                                {"n": "2004", "v": "2004"},
                                                {"n": "2003", "v": "2003"},
                                                {"n": "2002", "v": "2002"},
                                                {"n": "2001", "v": "2001"},
                                                {"n": "2000", "v": "2000"},
                                                {"n": "更早", "v": "更早"}]}],
                            "连续剧@影视": [{"key": "地区",
                                      "name": "地区",
                                      "value": [{"n": "全部", "v": ""},
                                                {"n": "中国大陆", "v": "中国大陆"},
                                                {"n": "中国香港", "v": "中国香港"},
                                                {"n": "中国台湾", "v": "中国台湾"},
                                                {"n": "韩国", "v": "韩国"},
                                                {"n": "泰国", "v": "泰国"},
                                                {"n": "日本", "v": "日本"},
                                                {"n": "美国", "v": "美国"},
                                                {"n": "英国", "v": "英国"},
                                                {"n": "法国", "v": "法国"},
                                                {"n": "德国", "v": "德国"},
                                                {"n": "西班牙", "v": "西班牙"},
                                                {"n": "新加坡", "v": "新加坡"},
                                                {"n": "加拿大", "v": "加拿大"},
                                                {"n": "菲律宾", "v": "菲律宾"},
                                                {"n": "非洲", "v": "非洲"},
                                                {"n": "巴西", "v": "巴西"},
                                                {"n": "捷克", "v": "捷克"},
                                                {"n": "俄罗斯", "v": "俄罗斯"},
                                                {"n": "土耳其", "v": "土耳其"},
                                                {"n": "墨西哥", "v": "墨西哥"},
                                                {"n": "阿根廷", "v": "阿根廷"},
                                                {"n": "马来西亚", "v": "马来西亚"},
                                                {"n": "波兰", "v": "波兰"},
                                                {"n": "乌克兰", "v": "乌克兰"},
                                                {"n": "罗马尼亚", "v": "罗马尼亚"},
                                                {"n": "东南亚", "v": "东南亚"}]},
                                      {"key": "类型",
                                      "name": "类型",
                                      "value": [{"n": "全部", "v": ""},
                                                {"n": "古装", "v": "古装"},
                                                {"n": "战争", "v": "战争"},
                                                {"n": "青春", "v": "青春"},
                                                {"n": "偶像", "v": "偶像"},
                                                {"n": "喜剧", "v": "喜剧"},
                                                {"n": "家庭", "v": "家庭"},
                                                {"n": "犯罪", "v": "犯罪"},
                                                {"n": "动作", "v": "动作"},
                                                {"n": "科幻", "v": "科幻"},
                                                {"n": "奇幻", "v": "奇幻"},
                                                {"n": "仙侠", "v": "仙侠"},
                                                {"n": "武侠", "v": "武侠"},
                                                {"n": "剧情", "v": "剧情"},
                                                {"n": "历史", "v": "历史"},
                                                {"n": "综艺", "v": "综艺"},
                                                {"n": "真人秀", "v": "真人秀"},
                                                {"n": "音乐", "v": "音乐"},
                                                {"n": "经典", "v": "经典"},
                                                {"n": "乡村", "v": "乡村"},
                                                {"n": "情景", "v": "情景"},
                                                {"n": "商战", "v": "商战"},
                                                {"n": "网剧", "v": "网剧"},
                                                {"n": "其他", "v": "其他"},
                                                {"n": "同性", "v": "同性"}]},
                                      {"key": "列表",
                                      "name": "列表",
                                      "value": [{"n": "全部", "v": ""},
                                                {"n": "最新上传", "v": "Time"},
                                                {"n": "人气高", "v": "Hits"},
                                                {"n": "评分高", "v": "Score"}]},
                                      {"key": "年代",
                                      "name": "年代",
                                      "value": [{"n": "全部", "v": ""},
                                                {"n": "2026", "v": "2026"},
                                                {"n": "2025", "v": "2025"},
                                                {"n": "2024", "v": "2024"},
                                                {"n": "2023", "v": "2023"},
                                                {"n": "2022", "v": "2022"},
                                                {"n": "2021", "v": "2021"},
                                                {"n": "2020", "v": "2020"},
                                                {"n": "2019", "v": "2019"},
                                                {"n": "2018", "v": "2018"},
                                                {"n": "2017", "v": "2017"},
                                                {"n": "2016", "v": "2016"},
                                                {"n": "2015", "v": "2015"},
                                                {"n": "2014", "v": "2014"},
                                                {"n": "2013", "v": "2013"},
                                                {"n": "2012", "v": "2012"},
                                                {"n": "2011", "v": "2011"},
                                                {"n": "2010", "v": "2010"},
                                                {"n": "2009", "v": "2009"},
                                                {"n": "2008", "v": "2008"},
                                                {"n": "2007", "v": "2007"},
                                                {"n": "2006", "v": "2006"},
                                                {"n": "2005", "v": "2005"},
                                                {"n": "2004", "v": "2004"},
                                                {"n": "2003", "v": "2003"},
                                                {"n": "2002", "v": "2002"},
                                                {"n": "2001", "v": "2001"},
                                                {"n": "2000", "v": "2000"},
                                                {"n": "更早", "v": "更早"}]}],
                              "动漫@影视": [{"key": "地区",
                                      "name": "地区",
                                      "value": [{"n": "全部", "v": ""},
                                                {"n": "中国大陆", "v": "中国大陆"},
                                                {"n": "中国香港", "v": "中国香港"},
                                                {"n": "中国台湾", "v": "中国台湾"},
                                                {"n": "韩国", "v": "韩国"},
                                                {"n": "泰国", "v": "泰国"},
                                                {"n": "日本", "v": "日本"},
                                                {"n": "美国", "v": "美国"},
                                                {"n": "英国", "v": "英国"},
                                                {"n": "法国", "v": "法国"},
                                                {"n": "德国", "v": "德国"},
                                                {"n": "西班牙", "v": "西班牙"},
                                                {"n": "新加坡", "v": "新加坡"},
                                                {"n": "加拿大", "v": "加拿大"},
                                                {"n": "菲律宾", "v": "菲律宾"},
                                                {"n": "非洲", "v": "非洲"},
                                                {"n": "巴西", "v": "巴西"},
                                                {"n": "捷克", "v": "捷克"},
                                                {"n": "俄罗斯", "v": "俄罗斯"},
                                                {"n": "土耳其", "v": "土耳其"},
                                                {"n": "墨西哥", "v": "墨西哥"},
                                                {"n": "阿根廷", "v": "阿根廷"},
                                                {"n": "马来西亚", "v": "马来西亚"},
                                                {"n": "波兰", "v": "波兰"},
                                                {"n": "乌克兰", "v": "乌克兰"},
                                                {"n": "罗马尼亚", "v": "罗马尼亚"},
                                                {"n": "东南亚", "v": "东南亚"}]},
                                      {"key": "类型",
                                      "name": "类型",
                                      "value": [{"n": "全部", "v": ""},
                                                {"n": "情感", "v": "情感"},
                                                {"n": "科幻", "v": "科幻"},
                                                {"n": "热血", "v": "热血"},
                                                {"n": "推理", "v": "推理"},
                                                {"n": "搞笑", "v": "搞笑"},
                                                {"n": "冒险", "v": "冒险"},
                                                {"n": "萝莉", "v": "萝莉"},
                                                {"n": "校园", "v": "校园"},
                                                {"n": "动作", "v": "动作"},
                                                {"n": "机战", "v": "机战"},
                                                {"n": "运动", "v": "运动"},
                                                {"n": "战争", "v": "战争"},
                                                {"n": "少年", "v": "少年"},
                                                {"n": "少女", "v": "少女"},
                                                {"n": "社会", "v": "社会"},
                                                {"n": "原创", "v": "原创"},
                                                {"n": "亲子", "v": "亲子"},
                                                {"n": "益智", "v": "益智"},
                                                {"n": "励志", "v": "励志"},
                                                {"n": "其他", "v": "其他"}]},
                                      {"key": "列表",
                                      "name": "列表",
                                      "value": [{"n": "全部", "v": ""},
                                                {"n": "最新上传", "v": "Time"},
                                                {"n": "人气高", "v": "Hits"},
                                                {"n": "评分高", "v": "Score"}]},
                                      {"key": "年代",
                                      "name": "年代",
                                      "value": [{"n": "全部", "v": ""},
                                                {"n": "2026", "v": "2026"},
                                                {"n": "2025", "v": "2025"},
                                                {"n": "2024", "v": "2024"},
                                                {"n": "2023", "v": "2023"},
                                                {"n": "2022", "v": "2022"},
                                                {"n": "2021", "v": "2021"},
                                                {"n": "2020", "v": "2020"},
                                                {"n": "2019", "v": "2019"},
                                                {"n": "2018", "v": "2018"},
                                                {"n": "2017", "v": "2017"},
                                                {"n": "2016", "v": "2016"},
                                                {"n": "2015", "v": "2015"},
                                                {"n": "2014", "v": "2014"},
                                                {"n": "2013", "v": "2013"},
                                                {"n": "2012", "v": "2012"},
                                                {"n": "2011", "v": "2011"},
                                                {"n": "2010", "v": "2010"},
                                                {"n": "2009", "v": "2009"},
                                                {"n": "2008", "v": "2008"},
                                                {"n": "2007", "v": "2007"},
                                                {"n": "2006", "v": "2006"},
                                                {"n": "2005", "v": "2005"},
                                                {"n": "2004", "v": "2004"},
                                                {"n": "2003", "v": "2003"},
                                                {"n": "2002", "v": "2002"},
                                                {"n": "2001", "v": "2001"},
                                                {"n": "2000", "v": "2000"},
                                                {"n": "更早", "v": "更早"}]}],
                              "综艺@影视": [{"key": "地区",
                                      "name": "地区",
                                      "value": [{"n": "全部", "v": ""},
                                                {"n": "中国大陆", "v": "中国大陆"},
                                                {"n": "中国香港", "v": "中国香港"},
                                                {"n": "中国台湾", "v": "中国台湾"},
                                                {"n": "韩国", "v": "韩国"},
                                                {"n": "泰国", "v": "泰国"},
                                                {"n": "日本", "v": "日本"},
                                                {"n": "美国", "v": "美国"},
                                                {"n": "英国", "v": "英国"},
                                                {"n": "法国", "v": "法国"},
                                                {"n": "德国", "v": "德国"},
                                                {"n": "西班牙", "v": "西班牙"},
                                                {"n": "新加坡", "v": "新加坡"},
                                                {"n": "加拿大", "v": "加拿大"},
                                                {"n": "菲律宾", "v": "菲律宾"},
                                                {"n": "非洲", "v": "非洲"},
                                                {"n": "巴西", "v": "巴西"},
                                                {"n": "捷克", "v": "捷克"},
                                                {"n": "俄罗斯", "v": "俄罗斯"},
                                                {"n": "土耳其", "v": "土耳其"},
                                                {"n": "墨西哥", "v": "墨西哥"},
                                                {"n": "阿根廷", "v": "阿根廷"},
                                                {"n": "马来西亚", "v": "马来西亚"},
                                                {"n": "波兰", "v": "波兰"},
                                                {"n": "乌克兰", "v": "乌克兰"},
                                                {"n": "罗马尼亚", "v": "罗马尼亚"},
                                                {"n": "东南亚", "v": "东南亚"}]},
                                      {"key": "类型",
                                      "name": "类型",
                                      "value": [{"n": "全部", "v": ""},
                                                {"n": "真人秀", "v": "真人秀"},
                                                {"n": "脱口秀", "v": "脱口秀"},
                                                {"n": "情感", "v": "情感"},
                                                {"n": "访谈", "v": "访谈"},
                                                {"n": "播报", "v": "播报"},
                                                {"n": "旅游", "v": "旅游"},
                                                {"n": "音乐", "v": "音乐"},
                                                {"n": "美食", "v": "美食"},
                                                {"n": "纪实", "v": "纪实"},
                                                {"n": "曲艺", "v": "曲艺"},
                                                {"n": "生活", "v": "生活"},
                                                {"n": "游戏互动", "v": "游戏互动"},
                                                {"n": "财经", "v": "财经"},
                                                {"n": "求职", "v": "求职"}]},
                                      {"key": "列表",
                                      "name": "列表",
                                      "value": [{"n": "全部", "v": ""},
                                                {"n": "最新上传", "v": "Time"},
                                                {"n": "人气高", "v": "Hits"},
                                                {"n": "评分高", "v": "Score"}]},
                                      {"key": "年代",
                                      "name": "年代",
                                      "value": [{"n": "全部", "v": ""},
                                                {"n": "2026", "v": "2026"},
                                                {"n": "2025", "v": "2025"},
                                                {"n": "2024", "v": "2024"},
                                                {"n": "2023", "v": "2023"},
                                                {"n": "2022", "v": "2022"},
                                                {"n": "2021", "v": "2021"},
                                                {"n": "2020", "v": "2020"},
                                                {"n": "2019", "v": "2019"},
                                                {"n": "2018", "v": "2018"},
                                                {"n": "2017", "v": "2017"},
                                                {"n": "2016", "v": "2016"},
                                                {"n": "2015", "v": "2015"},
                                                {"n": "2014", "v": "2014"},
                                                {"n": "2013", "v": "2013"},
                                                {"n": "2012", "v": "2012"},
                                                {"n": "2011", "v": "2011"},
                                                {"n": "2010", "v": "2010"},
                                                {"n": "2009", "v": "2009"},
                                                {"n": "2008", "v": "2008"},
                                                {"n": "2007", "v": "2007"},
                                                {"n": "2006", "v": "2006"},
                                                {"n": "2005", "v": "2005"},
                                                {"n": "2004", "v": "2004"},
                                                {"n": "2003", "v": "2003"},
                                                {"n": "2002", "v": "2002"},
                                                {"n": "2001", "v": "2001"},
                                                {"n": "2000", "v": "2000"},
                                                {"n": "更早", "v": "更早"}]}],
                              "短剧@短剧": [{"key": "地区",
                                      "name": "地区",
                                      "value": [{"n": "全部", "v": ""},
                                                {"n": "中国大陆", "v": "中国大陆"},
                                                {"n": "中国香港", "v": "中国香港"},
                                                {"n": "中国台湾", "v": "中国台湾"},
                                                {"n": "韩国", "v": "韩国"},
                                                {"n": "泰国", "v": "泰国"},
                                                {"n": "日本", "v": "日本"},
                                                {"n": "美国", "v": "美国"},
                                                {"n": "英国", "v": "英国"},
                                                {"n": "法国", "v": "法国"},
                                                {"n": "德国", "v": "德国"},
                                                {"n": "西班牙", "v": "西班牙"},
                                                {"n": "新加坡", "v": "新加坡"},
                                                {"n": "加拿大", "v": "加拿大"},
                                                {"n": "菲律宾", "v": "菲律宾"},
                                                {"n": "非洲", "v": "非洲"},
                                                {"n": "巴西", "v": "巴西"},
                                                {"n": "捷克", "v": "捷克"},
                                                {"n": "俄罗斯", "v": "俄罗斯"},
                                                {"n": "土耳其", "v": "土耳其"},
                                                {"n": "墨西哥", "v": "墨西哥"},
                                                {"n": "阿根廷", "v": "阿根廷"},
                                                {"n": "马来西亚", "v": "马来西亚"},
                                                {"n": "波兰", "v": "波兰"},
                                                {"n": "乌克兰", "v": "乌克兰"},
                                                {"n": "罗马尼亚", "v": "罗马尼亚"},
                                                {"n": "东南亚", "v": "东南亚"}]},
                                      {"key": "类型",
                                      "name": "类型",
                                      "value": [{"n": "全部", "v": ""},
                                                {"n": "动作运动", "v": "动作运动"},
                                                {"n": "爱情言情", "v": "爱情言情"},
                                                {"n": "科幻灾难", "v": "科幻灾难"},
                                                {"n": "玄幻奇幻", "v": "玄幻奇幻"},
                                                {"n": "惊悚恐怖", "v": "惊悚恐怖"},
                                                {"n": "推理侦探", "v": "推理侦探"},
                                                {"n": "喜剧幽默", "v": "喜剧幽默"},
                                                {"n": "古装宫庭", "v": "古装宫庭"},
                                                {"n": "都市社会", "v": "都市社会"},
                                                {"n": "冒险探险", "v": "冒险探险"},
                                                {"n": "青春校园", "v": "青春校园"},
                                                {"n": "仙侠武侠", "v": "仙侠武侠"},
                                                {"n": "大佬大神", "v": "大佬大神"},
                                                {"n": "娇妻宝爸", "v": "娇妻宝爸"},
                                                {"n": "霸道总裁", "v": "霸道总裁"},
                                                {"n": "屌丝逆袭", "v": "屌丝逆袭"},
                                                {"n": "穿越重生", "v": "穿越重生"},
                                                {"n": "战争历史", "v": "战争历史"},
                                                {"n": "医道医生", "v": "医道医生"},
                                                {"n": "玄门道法", "v": "玄门道法"}]},
                                      {"key": "列表",
                                      "name": "列表",
                                      "value": [{"n": "全部", "v": ""},
                                                {"n": "最新上传", "v": "Time"},
                                                {"n": "人气高", "v": "Hits"},
                                                {"n": "评分高", "v": "Score"}]},
                                      {"key": "年代",
                                      "name": "年代",
                                      "value": [{"n": "全部", "v": ""},
                                                {"n": "2026", "v": "2026"},
                                                {"n": "2025", "v": "2025"},
                                                {"n": "2024", "v": "2024"},
                                                {"n": "2023", "v": "2023"},
                                                {"n": "2022", "v": "2022"},
                                                {"n": "2021", "v": "2021"},
                                                {"n": "2020", "v": "2020"},
                                                {"n": "2019", "v": "2019"},
                                                {"n": "2018", "v": "2018"},
                                                {"n": "2017", "v": "2017"},
                                                {"n": "2016", "v": "2016"},
                                                {"n": "2015", "v": "2015"},
                                                {"n": "2014", "v": "2014"},
                                                {"n": "2013", "v": "2013"},
                                                {"n": "2012", "v": "2012"},
                                                {"n": "2011", "v": "2011"},
                                                {"n": "2010", "v": "2010"},
                                                {"n": "2009", "v": "2009"},
                                                {"n": "2008", "v": "2008"},
                                                {"n": "2007", "v": "2007"},
                                                {"n": "2006", "v": "2006"},
                                                {"n": "2005", "v": "2005"},
                                                {"n": "2004", "v": "2004"},
                                                {"n": "2003", "v": "2003"},
                                                {"n": "2002", "v": "2002"},
                                                {"n": "2001", "v": "2001"},
                                                {"n": "2000", "v": "2000"},
                                                {"n": "更早", "v": "更早"}]}]}}

        return result

    def homeVideoContent(self):
        data = self.build_home_request_data()
        json_data = self.convert_to_json(data)
        urlz = self.get_home_video_url()
        response = self.send_home_video_request(urlz, json_data)
        data = self.parse_home_video_response(response)
        videos = self.process_home_video_list(data)
        result = self.build_home_video_result(videos)
        return result

    def build_home_request_data(self):
        return {"Id": 0,"Type": 0,"Page": 1,"Limit": 10}

    def convert_to_json(self, data):
        return json.dumps(data)

    def get_home_video_url(self):
        return f'{xurl}/addons/appto/app.php/tindex/home_vod_list2'

    def send_home_video_request(self, urlz, json_data):
        response = requests.post(url=urlz, headers=headers, data=json_data)
        return response

    def parse_home_video_response(self, response):
        response.encoding = "utf-8"
        return response.json()

    def process_home_video_list(self, data):
        videos = []
        for vod in data['data']['vods']:
            video = self.parse_home_video_item(vod)
            videos.append(video)
        return videos

    def parse_home_video_item(self, vod):
        return {
            "vod_id": vod['vod_id'],
            "vod_name": vod['vod_name'],
            "vod_pic": vod['vod_pic'].replace('mac:', 'https:'),
            "vod_year": vod.get('vod_pubdate', '暂无备注'),
            "vod_remarks": vod.get('vod_remarks', '暂无备注')
               }

    def build_home_video_result(self, videos):
        return {'list': videos}

    def categoryContent(self, cid, pg, filter, ext):
        result = {}
        videos = []
        fenge = self.split_cid(cid)
        page = self.get_page_number(pg)
        NdType = self.get_ext_value(ext, '年代')
        DqType = self.get_ext_value(ext, '地区')
        LxType = self.get_ext_value(ext, '类型')
        LbType = self.get_ext_value(ext, '列表')
        data = self.build_category_request_data(fenge, page, NdType, DqType, LxType, LbType)
        json_data = self.convert_to_json(data)
        urlz = self.get_category_url()
        response = self.send_category_request(urlz, json_data)
        data = self.parse_category_response(response)
        videos = self.process_category_list(data)
        result = self.build_category_result(videos, pg)
        return result

    def split_cid(self, cid):
        return cid.split("@")

    def get_page_number(self, pg):
        return int(pg) if pg else 1

    def get_ext_value(self, ext, key):
        return ext[key] if key in ext else ''

    def build_category_request_data(self, fenge, page, NdType, DqType, LxType, LbType):
        return {"Area": DqType,"Class": LxType,"Limit": 10,"Page": page,"Sort": LbType,"Tab": fenge[1],"Type": fenge[0],"Year": NdType,"topic_id": "Null"}

    def convert_to_json(self, data):
        return json.dumps(data)

    def get_category_url(self):
        return f'{xurl}/addons/appto/app.php/tindex/page_vod_lists'

    def send_category_request(self, urlz, json_data):
        response = requests.post(url=urlz, headers=headers, data=json_data)
        return response

    def parse_category_response(self, response):
        response.encoding = "utf-8"
        return response.json()

    def process_category_list(self, data):
        videos = []
        for vod in data['data']['list']:
            if not self.should_skip_video(vod):
                video = self.parse_category_video_item(vod)
                videos.append(video)
        return videos

    def should_skip_video(self, vod):
        name = vod['vod_name']
        skip_names = ["PG电子"]
        return name in skip_names

    def parse_category_video_item(self, vod):
        return {
            "vod_id": vod['vod_id'],
            "vod_name": vod['vod_name'],
            "vod_pic": vod['vod_pic'].replace('mac:', 'https:'),
            "vod_year": vod.get('vod_pubdate', '暂无备注'),
            "vod_remarks": vod.get('vod_remarks', '暂无备注')
               }

    def build_category_result(self, videos, pg):
        result = {'list': videos}
        result['page'] = pg
        result['pagecount'] = 9999
        result['limit'] = 90
        result['total'] = 999999
        return result

    def detailContent(self, ids):
        did = self.get_first_id(ids)
        data = self.build_detail_request_data(did)
        json_data = self.convert_to_json(data)
        urlz = self.get_detail_url()
        response_data = self.send_detail_request(urlz, json_data)
        content = self.build_vod_content(response_data)
        director = self.get_nested_value(response_data, 'vod_director')
        actor = self.get_nested_value(response_data, 'vod_actor')
        remarks = self.get_nested_value(response_data, 'vod_remarks')
        year = self.get_nested_value(response_data, 'vod_year')
        area = self.get_nested_value(response_data, 'vod_area')
        bofang = self.get_nested_value(response_data, 'vod_play_url')
        videos = self.build_video_info(did, director, actor, remarks, year, area, content, bofang)
        result = self.build_detail_result(videos)
        return result

    def get_first_id(self, ids):
        return ids[0]

    def build_detail_request_data(self, did):
        return {"id": did}

    def convert_to_json(self, data):
        return json.dumps(data)

    def get_detail_url(self):
        return f'{xurl}/addons/appto/app.php/tindex/page_player'

    def send_detail_request(self, urlz, json_data):
        response = requests.post(url=urlz, headers=headers, data=json_data)
        response.encoding = "utf-8"
        return response.json()

    def build_vod_content(self, response_data):
        return '😸丢丢为您介绍剧情📢' + response_data.get('data', {}).get('vod_blurb', '')

    def get_nested_value(self, response_data, key):
        return response_data.get('data', {}).get(key, '')

    def build_video_info(self, did, director, actor, remarks, year, area, content, bofang):
        return [{"vod_id": did,"vod_director": director,"vod_actor": actor,"vod_remarks": remarks,"vod_year": year,"vod_area": area,"vod_content": content,"vod_play_from": "丢丢58专线","vod_play_url": bofang}]

    def build_detail_result(self, videos):
        result = {}
        result['list'] = videos
        return result

    def playerContent(self, flag, id, vipFlags):
        result = {}
        result["parse"] = 0
        result["playUrl"] = ''
        result["url"] = id
        result["header"] = headerx
        return result

    def searchContentPage(self, key, quick, pg):
        page = self.get_page_number(pg)
        data = self.build_search_request_data(key, page)
        json_data = self.convert_to_json(data)
        urlz = self.get_search_url()
        response = self.send_search_request(urlz, json_data)
        data = self.parse_search_response(response)
        videos = self.process_search_list(data)
        result = self.build_search_result(videos, pg)
        return result

    def get_page_number(self, pg):
        return int(pg) if pg else 1

    def build_search_request_data(self, key, page):
        return {"Limit": 10,"Page": page,"Search": key,"type": None}

    def convert_to_json(self, data):
        return json.dumps(data)

    def get_search_url(self):
        return f'{xurl}/addons/appto/app.php/tindex/search_film'

    def send_search_request(self, urlz, json_data):
        response = requests.post(url=urlz, headers=headers, data=json_data)
        return response

    def parse_search_response(self, response):
        response.encoding = "utf-8"
        return response.json()

    def process_search_list(self, data):
        videos = []
        for vod in data['data']['vods']['list']:
            video = self.parse_search_video_item(vod)
            videos.append(video)
        return videos

    def parse_search_video_item(self, vod):
        return {
            "vod_id": vod['vod_id'],
            "vod_name": vod['vod_name'],
            "vod_pic": vod['vod_pic'].replace('mac:', 'https:'),
            "vod_remarks": vod.get('vod_remarks', '暂无备注')
               }

    def build_search_result(self, videos, pg):
        result = {'list': videos}
        result['page'] = pg
        result['pagecount'] = 9999
        result['limit'] = 90
        result['total'] = 999999
        return result

    def searchContent(self, key, quick, pg="1"):
        return self.searchContentPage(key, quick, '1')

    def localProxy(self, params):
        if params['type'] == "m3u8":
            return self.proxyM3u8(params)
        elif params['type'] == "media":
            return self.proxyMedia(params)
        elif params['type'] == "ts":
            return self.proxyTs(params)
        return None









