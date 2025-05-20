#coding=utf-8
#!/usr/bin/python
import sys
sys.path.append('..') 
from base.spider import Spider
import json
import time
import base64

class Spider(Spider):  # 元类 默认的元类 type
	def getName(self):
		return "央视科教"
	def init(self,extend=""):
		print("============{0}============".format(extend))
		pass
	def isVideoFormat(self,url):
		pass
	def manualVideoCheck(self):
		pass
	def homeContent(self,filter):
		result = {}
		cateManual = {
		    "天涯共此时":"TOPC1451540858793305",
"国宝档案":"TOPC1451540268188575",
"外国人在中国":"TOPC1451541113743615",
"文明之旅":"TOPC1451541205513705",
"记住乡愁第六季":"TOPC1577672009520911",
"跟着书本去旅行":"TOPC1575253587571324",
"百家讲坛":"TOPC1451557052519584",
"自然传奇":"TOPC1451558150787467",
"探索·发现":"TOPC1451557893544236",
"地理·中国":"TOPC1451557421544786",
"动物世界":"TOPC1451378967257534",
"人与自然":"TOPC1451525103989666",
"中华民族":"TOPC1451525460925648",
"国家记忆":"TOPC1473235107169415",
"国宝·发现":"TOPC1571034869935436",
"记住乡愁第七季":"TOPC1608533695279753",
"时尚科技秀":"TOPC1570874587435537",
"读书":"TOPC1451557523542854",
"创新进行时":"TOPC1570875218228998",
"解码科技史":"TOPC1570876640457386",
"科学动物园":"TOPC1571021385508957",
"考古公开课":"TOPC1571021251454875",
"科幻地带":"TOPC1571021323137369",
"实验现场":"TOPC1571021159595290",
"人物·故事":"TOPC1570780618796536",
"百家说故事":"TOPC1574995326079121",
"透视新科技":"TOPC1576631973420833",
"夕阳红":"TOPC1451543312252987",
"心理访谈":"TOPC1451543382680164",
"夜线":"TOPC1451543426689237",
"我爱发明":"TOPC1569314345479107",
"环球科技视野":"TOPC1451463780801881",
"状元360":"TOPC1451528493821255",
"1起聊聊":"TOPC1451374975347585",
"秘境之眼":"TOPC1554187056533820",
"文化视点":"TOPC1451536118642783",
"文化正午":"TOPC1451538455169283",
"文化大百科":"TOPC1451536035602751",
"动物传奇":"TOPC1451984181884527",
"文化讲坛":"TOPC1451984533334125",
"流行无限":"TOPC1451540644606949",
"天涯共此时":"TOPC1451540858793305",
"国宝档案":"TOPC1451540268188575",
"外国人在中国":"TOPC1451541113743615",
"文明之旅":"TOPC1451541205513705",
"记住乡愁第六季":"TOPC1577672009520911",
"中国影像方志":"TOPC1592552941644815",
"创新无限":"TOPC1451557109280614",
"科技人生":"TOPC1451557739596986",
"绿色空间":"TOPC1451557825546179",
"重访":"TOPC1451558118808439",
"走近科学":"TOPC1451558190239536",
"原来如此":"TOPC1451558088858410",
"科技之光":"TOPC1451557776198149",
"文明密码":"TOPC1451557930785264",
"真相":"TOPC1503545711557359",
"大家":"TOPC1451557371520714",
"讲述":"TOPC1451557691081955",
"人物":"TOPC1451557861628208",
"我爱发明（科普）":"TOPC1451557970755294"
		}
		classes = []
		for k in cateManual:
			classes.append({
				'type_name':k,
				'type_id':cateManual[k]
			})
		result['class'] = classes
		if(filter):
			result['filters'] = self.config['filter']
		return result
	def homeVideoContent(self):
		result = {
			'list':[]
		}
		return result
	def categoryContent(self,tid,pg,filter,extend):		
		result = {}
		extend['id'] = tid
		extend['p'] = pg
		filterParams = ["id", "p", "d"]
		params = ["", "", ""]
		for idx in range(len(filterParams)):
			fp = filterParams[idx]
			if fp in extend.keys():
				params[idx] = '{0}={1}'.format(filterParams[idx],extend[fp])
		suffix = '&'.join(params)
		url = 'https://api.cntv.cn/NewVideo/getVideoListByColumn?{0}&n=20&sort=desc&mode=0&serviceId=tvcctv&t=json'.format(suffix)
		if not tid.startswith('TOPC'):
			url = 'https://api.cntv.cn/NewVideo/getVideoListByAlbumIdNew?{0}&n=20&sort=desc&mode=0&serviceId=tvcctv&t=json'.format(suffix)
		rsp = self.fetch(url,headers=self.header)
		jo = json.loads(rsp.text)
		vodList = jo['data']['list']
		videos = []
		for vod in vodList:
			guid = vod['guid']
			title = vod['title']
			img = vod['image']
			brief = vod['brief']
			videos.append({
				"vod_id":guid+"###"+img,
				"vod_name":title,
				"vod_pic":img,
				"vod_remarks":''
			})
		result['list'] = videos
		result['page'] = pg
		result['pagecount'] = 9999
		result['limit'] = 90
		result['total'] = 999999
		return result
	def detailContent(self,array):
		aid = array[0].split('###')
		tid = aid[0]
		url = "https://vdn.apps.cntv.cn/api/getHttpVideoInfo.do?pid={0}".format(tid)

		rsp = self.fetch(url,headers=self.header)
		jo = json.loads(rsp.text)
		title = jo['title'].strip()
		link = jo['hls_url'].strip()
		vod = {
			"vod_id":tid,
			"vod_name":title,
			"vod_pic":aid[1],
			"type_name":'',
			"vod_year":"",
			"vod_area":"",
			"vod_remarks":"",
			"vod_actor":"",
			"vod_director":"",
			"vod_content":""
		}
		vod['vod_play_from'] = 'CCTV'
		vod['vod_play_url'] = title+"$"+link

		result = {
			'list':[
				vod
			]
		}
		return result
	def searchContent(self,key,quick):
		result = {
			'list':[]
		}
		return result
	def playerContent(self,flag,id,vipFlags):
		result = {}
		rsp = self.fetch(id,headers=self.header)
		content = rsp.text.strip()
		arr = content.split('\n')
		urlPrefix = self.regStr(id,'(http[s]?://[a-zA-z0-9.]+)/')
		url = urlPrefix + arr[-1]
		result["parse"] = 0
		result["playUrl"] = ''
		result["url"] = url
		result["header"] = ''
		return result

	config = {
		"player": {},
		"filter": {"TOPC1451557970755294": [{"key": "d", "name": "年份", "value": [{"n": "全部", "v": ""}, {"n": "2021", "v": "2021"}, {"n": "2020", "v": "2020"}, {"n": "2019", "v": "2019"}, {"n": "2018", "v": "2018"}, {"n": "2017", "v": "2017"}, {"n": "2016", "v": "2016"}, {"n": "2015", "v": "2015"}, {"n": "2014", "v": "2014"}, {"n": "2013", "v": "2013"}, {"n": "2012", "v": "2012"}, {"n": "2011", "v": "2011"}, {"n": "2010", "v": "2010"}, {"n": "2009", "v": "2009"}]}]}
	}
	header = {
		"User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.54 Safari/537.36"
	}

	def localProxy(self,param):
		return [200, "video/MP2T", action, ""]
