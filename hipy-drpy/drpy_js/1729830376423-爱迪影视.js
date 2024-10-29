// vip的不会写登录和会员验证，其他的能不能看就看缘分
var rule = {
  title:'爱迪影视',
  host:'https://www.edu-hb.com',
  url:'/show/fyclass--------fypage---.html',
  searchUrl:'/vsearch/-------------.html?wd=**&submit=',
  searchable:2,
  quickSearch:0,
  filterable:1,
  filter:'',
  filter_url:'',
  filter_def:{},
  headers:{
      'User-Agent':'MOBILE_UA',
  },
  timeout:5000,
  class_parse:'.nav_list.clearfix li;a&&title;a&&href;.*/(.*?)\.html',
  cate_exclude:'排行榜|影视专题',
  play_parse:true,
  lazy:$js.toString(()=>{
    input = {parse:1,url:input,js:''};
  }),
  double:true,
  推荐:'.cbox2.hide ul;li;*;*;*;*',
  一级:'.vodlist.vodlist_wi li;a&&title;a&&data-background-image;a span:eq(4)&&Text;a&&href',
  二级:{
    title:'.content_box.clearfix a&&title',
    img:'.content_box.clearfix a&&img&&data-src',
    desc:'.content_box.clearfix ul li span:eq(12)&&Text;.content_box.clearfix ul li a:eq(5)&&Text;.content_box.clearfix ul li a:eq(0)&&Text;.content_box.clearfix ul li:eq(3)&&Text;.content_box.clearfix ul li a:eq(9)&&Text',
    content:'.content span&&Text',
    tabs:'#NumTab a',
    lists:'.content_playlist.clearfix:eq(#id)&&a',
    tab_text:'body&&Text',
    list_text:'body&&Text',
    list_url:'a&&href',
    list_url_prefix: '',
  },
  搜索:'.vodlist.clearfix li;*;*;*;*',
}