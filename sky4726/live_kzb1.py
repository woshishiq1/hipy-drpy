#!/usr/bin/python3
# -*- coding: utf-8 -*-
# @Author  : Doubebly
# @Time    : 2025/11/23 22:55
# @file    : 快直播.min.py

G=print
F=Exception
B=False
import sys,requests as E,json
sys.path.append('..')
from base.spider import Spider as A
class Spider(A):
	def __init__(A):super(Spider,A).__init__();A.name='live_kzb';A.url='https://jzb5kqln.huajiaedu.com/prod-api/iptv/getIptvList';A.headers={'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36','Accept':'application/json, text/plain, */*','referer':'https://jzb5kqln.huajiaedu.com/tvs'};A.ck=None
	def getName(A):return A.name
	def init(A,extend='{}'):A.init_ck();A.extend=json.loads(extend)
	def liveContent(A,url):
		C=[]
		try:
			H=A.headers.copy()
			if A.ck:H.update({'Cookie':A.ck})
			M=E.get(A.url,headers=H,allow_redirects=B);I=M.json()['list'];I.sort(key=lambda x:x['id']);D=''
			for J in I:
				K=J['play_source_name'];L='卫视频道'if'卫视'in K else'央视频道'
				if D!=L:D=L;C.append(D+',#genre#')
				C.append(K+','+J['play_source_url'])
		except F as N:G(N)
		return'\n'.join(C)
	def init_ck(A):
		try:
			D=E.get(A.url,headers=A.headers,allow_redirects=B);C=D.headers.get('Set-Cookie')
			if C:A.ck=C
		except F as H:G(H)
		return B
if __name__=='__main__':0
