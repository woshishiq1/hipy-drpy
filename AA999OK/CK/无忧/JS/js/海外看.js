var rule = {
  title: '海外看',
  host: "https://haiwaikan.tv",
//  url: "/vodshow/fyfilter/",
//  host: 'https://haiwaikan.tv',
  url: '/vodshow/fyclass--------fypage---/',
  searchUrl: '/vodsearch/**----------fypage---/',
  searchable: 2,
  quickSearch: 0,
  filterable: 1,
  filter: "H4sIAAAAAAAAA+2YW08aQRTHv8s+++Biay9fpemDaUza9JbUtkljTFQEgVpAolgK3qqItaKLWotLgS+zMwvfosPOucwmuiGt7RNv/M6fM3vOGeacYWct23r4aNZ6Pv3BemiJdE3GE9aY9Wrq5bTJ76devJsOvvhqYE4c9uOHLCqTNTcGWrGiBLACoOanGuwBgJpcyMv5ImgAtGbm0GtXcE0NtGZtVVy1cE0N5GdGCEDPS3323DQ+TwNqvfqBWDkCDYCelzn126gBGHH6ay2OcwCkVZc5TgCKpX7gdXYwFg3klyz0S9/QTwP5bR2pyNFPwzD1lIvHfnEVNQ2kxTNy8QtqGij3Vk4kmpi7BtT6mwX5uQoaAK1ZXO6lXVxTA+XXOfHXfoh2A1Mkpm/k9nt7tIsaSMsmRe4MNQ20i9282gPcRQ1c1YrcXKWqBkDaUtf/jpkAUAXaq36rEgo4ZJp7PPgmHKaKI1Zc4zAhX3uYSAwdpv1av5TEUDRQwQ9KsnmKBdfAJXPkVYdKFgCl0MmKchuD10Abdb7OGgCV82ODNQDy26jKyjH6aaA4t7+xHwBv/k/WADgWx4zFCfl9coR7gH4ayG8ppyolUnhmmCmTatfP1f10CZMh5oO8Iz92lRudZWT6RuLSa+HxAjA3X25c9jcuePOJr9t8Fs3Nj43H7oAt+GjYJ9g+YdpjbI+ZdpvttmkfZ/u4YbcfkF19NOz32X7ftN9j+z3TPsn2SdN+l+13TTvna5v52pyvbeZrc762ma/N+dpmvjbnqz6GtitbEG7O2C7k8HbpjWJRmd4+Uw74CM91pbMW0p8+ezvDv7zTJZFKhvSZJ6/fTA9ieTxmxW55FEc0zqjxp7u3WLgUcYwyZBpm1IuTS+HWUdMw5Ai9cdRHjdCoUR81JKJGmne1y0MCgMdkQpaw+wLQ89aTPJYBjAHCNQMYtqfcxkBJJpRAcy+AYRr1nw6bqMEQPYhubv6Rg6joqF4tNnfpsoE8atyjxv3PGvfE7Tbu/nzar83jadNgNp6lbaPxKKAoT7o9J4UnQwP5Feoyg7daAD6lCdnEJgjAXeHcu8pTVwjAOMH9PYwFgDT3SJxsoaaBnlc+M/4PaCC/tW15Qf/nNJBfsylTOc8t8L0+ZKI6XHxVrRzroIHWaCz2FlbQW8N/bLKqcaoWScEHYDRL1Xa5WQ6AtOOaKjBqGkZta9S2/qpt3bndthXVmqJe0/jxem8X2x0ArZk99PP4DxiAtPyWf0yvMTTwGbz5tUkvv9nL4t0XgNbc2RVlvLcCDHM3lRXXeBWjgZ4X8SIi6h4uHFUmPKYAplY9NzQFVM/9jvcLX+EA8F14W6TKdBcOgH9NZ6KOrR6A1ixnZAk7HQDXpSG6G1SXAP7nnbbc9lz6G6JhmPvntS11dEsctdt/027nfgNGTreaaxcAAA==",
  filter_url: "-{{fl.地区}}-{{fl.排序}}-{{fl.剧情}}-----fypage---{{fl.时间}}",
  filter_def: {
    1: {
      剧情: "1"
    },
    2: {
      剧情: "2"
    },
    3: {
      剧情: "3"
    },
    4: {
      剧情: "4"
    }
  },
  headers: {
    "User-Agent": "MOBILE_UA"
  },
  timeout: 5000,
  class_parse: ".nav-menu-items&&a;a&&Text;a&&href;(\\d+)",
  play_parse: true,
  cate_exclude: '全部影片',
  limit: 6,
  推荐: '.cbox_list;*;*;*;*;*',
  double: true,
lazy:`js:
		var html = JSON.parse(request(input).match(/r player_.*?=(.*?)</)[1]);
		var url = html.url;
		if (html.encrypt == '1') {
			url = unescape(url)
		} else if (html.encrypt == '2') {
			url = unescape(base64Decode(url))
		}
		if (/\\.m3u8|\\.mp4/.test(url)) {
			input = {
				jx: 0,
				url: url,
				parse: 0
			}
		} else {
			input
		}
	`,
 一级: '.module-items .module-item;a&&title;.lazy&&data-src;.module-item-text&&Text;a&&href',
  二级: {
    title: 'h1&&Text;.tag-link&&Text',
    img: '.module-item-pic&&img&&data-src',
    desc: '.video-info-items:eq(0)&&Text;.video-info-items:eq(1)&&Text;.video-info-items:eq(2)&&Text;.video-info-items:eq(3)&&Text',
    content: '.vod_content&&Text',
    tabs: '.module-tab-item',
    lists: '.module-player-list:eq(#id)&&.scroll-content&&a',
  },
  搜索: '.module-search-item;*;*;*;*;',    
}