# -*- coding: utf-8 -*-
import json,re,sys,threading,time,random
from base64 import b64decode,b64encode
from urllib.parse import quote,unquote
import requests
from pyquery import PyQuery as pq
sys.path.append('..')
from base.spider import Spider
class Spider(Spider):
    def init(self,extend=""):
        try:self.proxies=json.loads(extend)
        except:self.proxies={}
        self.headers={'User-Agent':'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36','Accept':'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7','Accept-Language':'zh-CN,zh;q=0.9','Connection':'keep-alive','Cache-Control':'no-cache'}
        self.host=self.get_working_host()
        self.headers.update({'Origin':self.host,'Referer':f"{self.host}/"})
    def getName(self):return "🌈 今日看料"
    def isVideoFormat(self,url):return any(ext in(url or'')for ext in['.m3u8','.mp4','.ts'])
    def manualVideoCheck(self):return False
    def destroy(self):pass
    def homeContent(self,filter):
        classes=[{'type_name':'热点关注','type_id':'/category/rdgz/'},{'type_name':'抖音','type_id':'/category/dy/'},{'type_name':'快手','type_id':'/category/ks/'},{'type_name':'斗鱼','type_id':'/category/douyu/'},{'type_name':'虎牙','type_id':'/category/hy/'},{'type_name':'花椒','type_id':'/category/hj/'},{'type_name':'推特','type_id':'/category/tt/'},{'type_name':'网红','type_id':'/category/wh/'},{'type_name':'ASMR','type_id':'/category/asmr/'},{'type_name':'X播','type_id':'/category/xb/'}]
        try:
            r=requests.get(self.host,headers=self.headers,proxies=self.proxies,timeout=10)
            if r.status_code==200:
                data=self.getpq(r.text)
                lst=self.getlist(data('#index article a,#archive article a'))
                return {'class':classes,'list':lst}
        except Exception:pass
        return {'class':classes,'list':[]}
    def homeVideoContent(self):
        try:
            response=requests.get(self.host,headers=self.headers,proxies=self.proxies,timeout=15)
            if response.status_code!=200:return {'list':[]}
            data=self.getpq(response.text)
            return {'list':self.getlist(data('#index article a,#archive article a'))}
        except Exception:return {'list':[]}
    def categoryContent(self,tid,pg,filter,extend):
        try:
            base=tid.strip('/');url=f"{self.host}{base}/"if not pg or pg=='1'else f"{self.host}{base}/{pg}/"
            r=requests.get(url,headers=self.headers,proxies=self.proxies,timeout=15)
            if r.status_code!=200:return {'list':[],'page':pg,'pagecount':1,'limit':90,'total':0}
            data=self.getpq(r.text)
            videos=self.getlist(data('#archive article a,#index article a,article a'),tid)
            if not videos:videos=self.getlist(data('.post a,.entry-title a'),tid)
            pagecount=self.detect_page_count(data,pg)
            return {'list':videos,'page':pg,'pagecount':pagecount,'limit':90,'total':999999}
        except Exception:return {'list':[],'page':pg,'pagecount':1,'limit':90,'total':0}
    def tagContent(self,tid,pg,filter,extend):return self.categoryContent(tid,pg,filter,extend)
    def detect_page_count(self,data,current_page):
        if data('a[rel="next"],.page-navigator .next,.pagination .next,a:contains("下一页")'):return 99999
        try:return int(current_page)
        except Exception:return 1
    def detailContent(self,ids):
        try:
            url=f"{self.host}{ids[0]}"if not ids[0].startswith('http')else ids[0]
            r=requests.get(url,headers=self.headers,proxies=self.proxies,timeout=15)
            if r.status_code!=200:return {'list':[{'vod_play_from':'今日看料','vod_play_url':f'正片${url}'}]}
            data=self.getpq(r.text)
            vod={'vod_play_from':'今日看料'}
            title=(data('h1.entry-title').text()or data('.post-title').text()or data('h1').eq(0).text()or'').strip()
            vod['vod_name']=title or'今日看料视频'
            article_id=self._extract_article_id(url)
            tags,plist,used=[],[],set()
            for i,t in enumerate(data('a[href*="/tag/"]').items(),start=1):
                name,href=(t.text()or'').strip(),(t.attr('href')or'').strip()
                if not name or not href:continue
                if href.startswith(self.host):href=href.replace(self.host,'')
                if not href.startswith('/'):href='/'+href
                tags.append('[a=cr:'+json.dumps({'id':href,'name':name},ensure_ascii=False)+'/]'+name+'[/a]')
                if i>=10:break
            vod['vod_content']=' '.join(tags)if tags else(data('.post-content').text()or vod['vod_name'])
            for idx,dp in enumerate(data('.dplayer').items(),start=1):
                cfg=dp.attr('data-config')
                if not cfg:continue
                try:
                    obj=json.loads(cfg)
                    vurl=obj.get('video',{}).get('url')or''
                    if vurl:
                        name=f"视频{idx}"
                        while name in used:idx+=1;name=f"视频{idx}"
                        used.add(name)
                        play_url=f"{article_id}_dm_{vurl}"if article_id else vurl
                        plist.append(f"{name}${play_url}")
                except Exception:continue
            if not plist:
                hits=re.findall(r'https?://[^\s\'\"]+\.(?:m3u8|mp4)',r.text)
                seen=set()
                for i,u in enumerate(hits,start=1):
                    if u in seen:continue
                    seen.add(u)
                    play_url=f"{article_id}_dm_{u}"if article_id else u
                    plist.append(f"视频{i}${play_url}")
            vod['vod_play_url']='#'.join(plist)if plist else f"正片${url}"
            return {'list':[vod]}
        except Exception:return {'list':[{'vod_play_from':'今日看料','vod_play_url':f'详情页加载失败${ids[0]if ids else""}'}]}
    def searchContent(self,key,quick,pg="1"):
        try:
            encoded_key=quote(key)
            url=f"{self.host}/tag/{encoded_key}/{pg}"if pg!="1"else f"{self.host}/tag/{encoded_key}/"
            response=requests.get(url,headers=self.headers,proxies=self.proxies,timeout=15)
            if response.status_code!=200:
                url=f"{self.host}/search/{encoded_key}/{pg}"if pg!="1"else f"{self.host}/search/{encoded_key}/"
                response=requests.get(url,headers=self.headers,proxies=self.proxies,timeout=15)
            if response.status_code!=200:return {'list':[],'page':pg}
            data=self.getpq(response.text)
            videos=self.getlist(data('#archive article a,#index article a,.post-card'))
            pagecount=self.detect_page_count(data,pg)
            return {'list':videos,'page':pg,'pagecount':pagecount}
        except Exception:return {'list':[],'page':pg}
    def getTagsContent(self,pg="1"):
        try:
            url=f"{self.host}/tags.html"
            response=requests.get(url,headers=self.headers,proxies=self.proxies,timeout=15)
            if response.status_code!=200:return {'list':[],'page':pg}
            data=self.getpq(response.text)
            tags=[]
            for tag_elem in data('a[href*="/tag/"]').items():
                tag_name,tag_href=tag_elem.text().strip(),tag_elem.attr('href')or''
                if tag_name and tag_href and'/tag/'in tag_href and tag_name!='全部标签':
                    tag_id=tag_href.replace(self.host,'');
                    if not tag_id.startswith('/'):tag_id='/'+tag_id
                    tags.append({'vod_id':tag_id,'vod_name':f"🏷️ {tag_name}",'vod_pic':'','vod_remarks':'标签','vod_tag':'tag','style':{"type":"rect","ratio":1.33}})
            return {'list':tags,'page':pg,'pagecount':1,'limit':999,'total':len(tags)}
        except Exception:return {'list':[],'page':pg}
    def playerContent(self,flag,id,vipFlags):
        if '_dm_'in id:
            aid,pid=id.split('_dm_',1)
            if self.isVideoFormat(pid):
                threading.Thread(target=self._preload_danmaku,args=(aid,pid)).start()
                return {'parse':0,'url':pid}
            return {'parse':1,'url':pid}
        url=id
        if self.isVideoFormat(url):return {'parse':0,'url':url}
        return {'parse':1,'url':url}
    def localProxy(self,param):
        try:
            xtype=param.get('type','')
            if xtype=='img':
                img_url=self.d64(param['url'])
                if not img_url.startswith(('http://','https://')):
                    img_url=f"{self.host}{img_url}"if img_url.startswith('/')else f"{self.host}/{img_url}"
                res=requests.get(img_url,headers=self.headers,proxies=self.proxies,timeout=10)
                return [200,res.headers.get('Content-Type','image/jpeg'),res.content]
            elif xtype=='m3u8':
                aid,url=unquote(param.get('pdid','')).split('_dm_',1)
                data=requests.get(url,headers=self.headers,proxies=self.proxies,timeout=10).text
                times=0.0
                for line in data.strip().split('\n'):
                    if line.startswith('#EXTINF:'):
                        try:times+=float(line.split(':')[-1].replace(',',''))
                        except Exception:pass
                threading.Thread(target=self.some_background_task,args=(aid,int(times)if times>0 else 0)).start()
                return [200,'text/plain',data]
            elif xtype=='hlxdm':
                article_id,times=param.get('path',''),int(param.get('times',0))
                comments=self._fetch_kanliao_comments(article_id)
                return self._generate_danmaku_xml(comments,times)
            return [404,'text/plain','']
        except Exception:return [500,'text/plain','']
    def e64(self,text):
        try:return b64encode(text.encode('utf-8')).decode('utf-8')
        except Exception:return ""
    def d64(self,encoded_text):
        try:return b64decode(encoded_text.encode('utf-8')).decode('utf-8')
        except Exception:return ""
    def get_working_host(self):
        urls=['https://kanliao2.one/','https://kanliao7.org/','https://kanliao7.net/','https://kanliao14.com/']
        for url in urls:
            try:
                r=requests.get(url,headers=self.headers,proxies=self.proxies,timeout=10)
                if r.status_code==200:
                    doc=self.getpq(r.text)
                    if len(doc('#index article a,#archive article a'))>0:return url
            except Exception:pass
        return urls[0]
    def getpq(self,data):
        try:return pq(data)
        except Exception:return pq(data.encode('utf-8'))
    def _extract_article_id(self,url):
        try:
            m=re.search(r'/archives/(\d+)/?',url)
            return m.group(1)if m else None
        except Exception:return None
    def _fetch_kanliao_comments(self,article_id,max_pages=3):
        comments=[];base=self.host.rstrip('/')
        if not article_id:return comments
        try:
            for page in range(1,max_pages+1):
                api=f"{base}/wp-json/wp/v2/comments?post={article_id}&per_page=100&page={page}&_fields=content.rendered"
                resp=requests.get(api,headers=self.headers,proxies=self.proxies,timeout=10)
                if resp.status_code!=200:break
                arr=resp.json()
                if not isinstance(arr,list)or not arr:break
                for item in arr:
                    html_txt=((item.get('content')or{}).get('rendered')or'').strip()
                    if html_txt:
                        text=re.sub(r'<[^>]+>','',html_txt).strip()
                        if text and len(text)<=100:comments.append(text)
                if len(arr)<100:break
        except Exception:pass
        if comments:return comments[:50]
        try:
            rsp=requests.get(f"{base}/archives/{article_id}/",headers=self.headers,proxies=self.proxies,timeout=10)
            if rsp.status_code==200:
                doc=self.getpq(rsp.text)
                for node in doc('ol.comment-list li .comment-content,.comment-content,.comment-body p').items():
                    t=node.text().strip()
                    if t and len(t)<=100:comments.append(t)
        except Exception:pass
        if not comments:
            try:
                rsp=requests.get(f"{base}/archives/{article_id}/",headers=self.headers,proxies=self.proxies,timeout=10)
                if rsp.status_code==200:
                    for a in self.getpq(rsp.text)('a[href*="/tag/"]').items():
                        nm=a.text().strip()
                        if nm and len(nm)<=20:comments.append(f"#{nm}")
            except Exception:pass
        return comments[:50]
    def _generate_danmaku_xml(self,comments,video_duration):
        try:
            total,header=len(comments),f'共有{len(comments)}条弹幕来袭！！！'
            xml=['<?xml version="1.0" encoding="UTF-8"?>','<i>','\t<chatserver>chat.kanliao.one</chatserver>','\t<chatid>88888888</chatid>','\t<mission>0</mission>','\t<maxlimit>99999</maxlimit>','\t<state>0</state>','\t<real_name>0</real_name>','\t<source>kanliao</source>']
            xml.append(f'\t<d p="0,5,25,16711680,0">{header}</d>')
            for i,cm in enumerate(comments):
                base_time=(i/total)*video_duration if total>0 and video_duration>0 else 0
                dm_time=round(max(0,max(0,video_duration-1)if(base_time+random.uniform(-3,3))>video_duration else(base_time+random.uniform(-3,3))),1)
                dm_color=self._get_danmaku_color()
                dm_text=re.sub(r'[<>&\u0000\b]','',cm)
                xml.append(f'\t<d p="{dm_time},1,25,{dm_color},0">{dm_text}</d>')
            xml.append('</i>')
            return [200,'text/xml','\n'.join(xml)]
        except Exception:return [500,'text/plain','']
    def _get_danmaku_color(self):return str(random.randint(0,0xFFFFFF))if random.random()<0.1 else '16777215'
    def some_background_task(self,article_id,video_duration):
        try:
            time.sleep(1)
            danmaku_url=f"{self.getProxyUrl()}&path={quote(article_id)}&times={video_duration}&type=hlxdm"
            self.fetch(f"http://127.0.0.1:9978/action?do=refresh&type=danmaku&path={quote(danmaku_url)}")
        except Exception:pass
    def _preload_danmaku(self,article_id,m3u8_url):
        try:
            data,t=requests.get(m3u8_url,headers=self.headers,proxies=self.proxies,timeout=10).text,0.0
            for line in data.strip().split('\n'):
                if line.startswith('#EXTINF:'):
                    try:t+=float(line.split(':')[-1].replace(',',''))
                    except:pass
            self.some_background_task(article_id,int(t)if t>0 else 0)
        except Exception:pass
    def get_article_img(self,elem):
        try:
            for script in elem('script').items():
                content=script.html()or script.text()
                if 'loadBannerDirect'in content:
                    match=re.search(r"loadBannerDirect\s*\(\s*['\"`]([^'\"`]+)['\"`]",content)
                    if match and match.group(1):
                        img_url=match.group(1).strip()
                        if not img_url.startswith(('http://','https://')):img_url=f"{self.host.rstrip('/')}{img_url}"if img_url.startswith('/')else f"{self.host.rstrip('/')}/{img_url}"
                        return f"{self.getProxyUrl()}&type=img&url={self.e64(img_url)}"
            for selector in ['img','.post-thumbnail img','.entry-thumbnail img','.post-card-image img','.featured-image img','img.wp-post-image']:
                img=elem(selector).eq(0)
                if img:
                    src=img.attr('src')or img.attr('data-src')or img.attr('data-lazy-src')or img.attr('srcset')
                    if src:
                        if ' 'in src and','in src:src=src.split(',')[0].split()[0]
                        if not src.startswith(('http://','https://')):src=f"{self.host.rstrip('/')}{src}"if src.startswith('/')else f"{self.host.rstrip('/')}/{src}"
                        return f"{self.getProxyUrl()}&type=img&url={self.e64(src)}"
            style=elem.attr('style')or''
            if 'background'in style and'url'in style:
                match=re.search(r'background[^;]*url\s*\(\s*[\'"`]?([^\'"`\)]+)[\'"`]?\s*\)',style)
                if match and match.group(1):
                    bg_url=match.group(1).strip()
                    if not bg_url.startswith(('http://','https://')):bg_url=f"{self.host.rstrip('/')}{bg_url}"if bg_url.startswith('/')else f"{self.host.rstrip('/')}/{bg_url}"
                    return f"{self.getProxyUrl()}&type=img&url={self.e64(bg_url)}"
            return''
        except Exception:return''
    def getlist(self,data,tid=''):
        videos=[]
        def is_advertisement(article_elem):
            title=(article_elem('h2').text()or article_elem('.post-card-title').text()or'').strip()
            if '热搜'in title or'HOT'in title:return True
            for script in article_elem('script').items():
                content=script.html()or script.text()
                if 'loadBannerDirect'in content:
                    match=re.search(r"loadBannerDirect\s*\(\s*['\"`]([^'\"`]+)['\"`]",content)
                    if match and match.group(1):
                        img_url=match.group(1)
                        if any(domain in img_url for domain in ['nibuaideren.icu','guv.com']):return True
                        if img_url.startswith('http')and'.gif'in img_url and not any(site in img_url for site in ['kanliao','/usr/uploads/']):return True
            return False
        for k in data.items():
            a=k.attr('href')
            b=k('h2').text()or k('.post-card-title').text()or k('.entry-title').text()or k.text()
            c=k('span[itemprop="datePublished"]').text()or k('.post-meta,.entry-meta,time,.post-card-info').text()
            if is_advertisement(k):continue
            if a and b and b.strip():
                vod_id=a if a.startswith('http')else(a if a.startswith('/')else f'/{a}')
                vod_pic=self.get_article_img(k)
                if not vod_pic:continue
                videos.append({'vod_id':vod_id,'vod_name':b.replace('\n',' ').strip(),'vod_pic':vod_pic,'vod_remarks':c.strip()if c else'','vod_tag':'','style':{"type":"rect","ratio":1.33}})
        return videos