TVBOX源接口格式


drpy_js源（*.js）--host: https://www.baidu.com/ search class parse lazy


py源（*.py）--https://www.baidu.com/ vod_id vod_name parse class type_name type_id


json源（.json）--https://www.baidu.com/ SiteUrl Domains SiteWord SiteName Classes type_name type_id


XBPQ源（.json）--分类url https://www.baidu.com/


XYQHiker源（.json）--首页 https://www.baidu.com/ 分类链接 （分类链接有时会写成英文class_url）


xml官源--打开网页只有影视分类（电影/电视剧等等）


/api/xml.php


/inc/api.php


/api.php/provide/vod/


/api.php/provide/vod/at/xml/


/api.php/seaxml/vod/at/xml


json官源--打开网页只有json影视代码


/api/json.php


/inc/apijson_vod.php


/api.php/provide/vod/


/api.php/provide/vod/at/json/


json分类搜索详情


/api.php/provide/vod/?ac=detail&pg=fypage&t=fyclass


/api.php/provide/vod/?ac=detail&pg=fypage&wd=**


/api.php/provide/vod/?ac=detail&ids=fyid
