#coding=utf-8
#!/usr/bin/python
import sys
import random
from re import findall
sys.path.append('..')
from base.spider import Spider

class Spider(Spider):  # 元类 默认的元类 type
	def getName(self):
		return "体育直播"

	def init(self, extend):
		pass

	def isVideoFormat(self, url):
		pass

	def manualVideoCheck(self):
		pass

	def homeContent(self, filter):
		result = {}
		cateManual = {
			"体育直播": "全部"
		}
		classes = []
		for k in cateManual:
			classes.append({
				'type_name': k,
				'type_id': cateManual[k]
			})
		result['class'] = classes
		if filter:
			result['filters'] = self.config['filter']
		return result

	def homeVideoContent(self):
		result = {}
		return result 

	def categoryContent(self, cid, page, filter, ext):
		result = {}
		if int(page) > 1:
			return result
		r = self.fetch('http://itiyu5.tv/spweb/schedule', headers=self.header)
		root = self.html(self.cleanText(r.text))
		dataList = root.xpath("//div[@class='fixtures']/div[@class='box']")
		dateList = root.xpath("//div[contains(@class,'subhead')]")
		videos = []
		utcOffset = self.fetch('http://worldtimeapi.org/api/timezone/Australia/Sydney', headers=self.header).json()['utc_offset']
		hourOffset = int(utcOffset.split(':')[0][1:]) - 8
		for data in dataList:
			pos = dataList.index(data)
			for video in data.xpath(".//div[@class='list']/ul/li"):
				infosList = video.xpath(".//div[@class='team']/div")
				stime = video.xpath(".//p[@class='name']/span/text()")[0].strip()
				sdate = dateList[pos].xpath('.//text()')[0].split()[0].strip()
				hour = stime.split(':')[0]
				if int(hour) < hourOffset:
					sdate = sdate.replace(sdate[3:-1], str(int(sdate[3:-1]) - 1))
					stime = str(24 - hourOffset + int(hour)) + ':' + stime.split(':')[1]
				else:
					hour = str(int(hour) - hourOffset)
					if len(hour) == 1:
						hour = '0' + hour
					stime = hour + ':' + stime.split(':')[1]
				rid = video.xpath(".//p[contains(@class,'btn')]/a/@href")[0]
				state = video.xpath(".//p[contains(@class,'btn')]/a/text()")[0].strip()
				if len(infosList) != 2:
					home = infosList[0].xpath('.//span/text()')[0].strip()
					away = infosList[2].xpath('.//span/text()')[0].strip()
					cover = infosList[0].xpath('.//img/@src')[0]
					name = home + 'VS' + away
				else:
					cover = 'https://s1.ax1x.com/2022/10/07/x3NPUO.png'
					name = infosList[1].xpath('.//text()')[0].strip()
				if state != '已结束':
					videos.append({
						"vod_id": rid,
						"vod_name": name,
						"vod_pic": cover,
						"vod_remarks": '[{}]|{}'.format(sdate, stime)
					})
		result['list'] = videos
		result['page'] = page
		result['pagecount'] = page
		result['limit'] = len(videos)
		result['total'] = len(videos)
		return result

	def detailContent(self, did):
		did = did[0]
		r = self.fetch(f'http://itiyu5.tv{did}', headers=self.header)
		urlList = findall(r'{}/vid/\d+'.format(did), r.text)
		if len(urlList) == 0:
			return {'list': [], 'msg': '比赛尚未开始'}
		title = ''
		purlList = []
		for url in urlList:
			if not url.startswith('http'):
				r = self.fetch('http://itiyu5.tv{}'.format(url), headers=self.header)
			else:
				r = self.fetch(url, headers=self.header)
			if url not in r.text or not '\'url\': ' in r.text:
				return {'list': [], 'msg': '比赛尚未开始'}
			else:
				try:
					purl = self.regStr(reg="\'url\': \"(.*?)\"", src=r.text)
					title = self.regStr(reg="\"title\": \"(.*?)\"", src=r.text)
					purlList.append(purl)
				except:
					return {'list': [], 'msg': '比赛尚未开始'}
				if purl == '':
					self.header['Referer'] = 'https://v.stnye.cc/'
					rid = self.regStr(reg='config\.iurl = \"(.*?)\"', src=r.text)
					if '.m3u' in rid:
						if rid.count('http') != 1:
							replstr = self.regStr(reg='(http.*?)http', src=rid)
							purl = rid.replace(replstr, '')
							if purl not in purlList:
								purlList.append(purl)
					else:
						rid = self.regStr(reg='id=(.*)', src=rid)
						data = self.fetch('https://info.zb.video.qq.com/?cmd=4', headers=self.header).json()
						country = data['country']
						province = data['province']
						city = data['city']
						ip = data['ip']
						data = self.fetch('https://geo.yolll.com/geo', headers=self.header).json()
						cfUA = data['ua']
						cfCC = data['ip']
						cfIP = data['cc']
						rnd = round(random.random() * 100000)
						params = {
							'type': 'stream',
							'id': rid,
							'rnd': rnd,
							'ip': ip,
							'country': country,
							'province': province,
							'city': city,
							'tx_ip': ip,
							'tx_country': country,
							'tx_province': province,
							'tx_city': city,
							'cf_ip': cfIP,
							'cf_cc': cfCC,
							'cf_ua': cfUA,
							'ref': 'direct',
							'ua': 'web',
						}
						data = self.post('https://cdn.dianshunxinxi.com/data/live.php', data=params, headers=self.header, timeout=10).json()
		vod = {
			"vod_id": did,
			"vod_name": title,
			"vod_pic": 'https://s1.ax1x.com/2022/10/07/x3NPUO.png'
		}
		vodplayUrl = ''
		vodplayFrom = ''
		for purl in purlList:
			vodplayUrl = vodplayUrl + '$$$' + '{}${}'.format(title.replace(' ', ''), purl)
			vodplayFrom = vodplayFrom + '$$$' + '体育直播{}'.format(purlList.index(purl))
		vod['vod_play_url'] = vodplayUrl.strip('$$$')
		vod['vod_play_from'] = vodplayFrom.strip('$$$')
		result = {
			'list': [
				vod
			]
		}
		return result

	def searchContent(self, key, quick):
		return self.searchContentPage(key, quick, '1')

	def searchContentPage(self, key, quick, page):
		result = {
			'list': []
		}
		return result

	def playerContent(self, flag, pid, vipFlags):
		result = {}
		result["parse"] = 0
		result["playUrl"] = ''
		result["url"] = pid
		result["header"] = ''
		return result

	config = {
		"player": {},
		"filter": {}
	}
	header = {
		"User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.54 Safari/537.36"
	}

	def localProxy(self, param):
		return [200, "video/MP2T", {}, ""]