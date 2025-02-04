var rule = {
  title:'窝窝影视',
  host:'https://wwysw.vip/',
  url:'/show/fyclass--------fypage---.html',
  searchUrl:'',  // 没有写搜索功能，网站好像需要验证什么东西
  searchable:2,
  quickSearch:0,
  filterable:1,
  filter:'',
  filter_url:'',
  filter_def:{},
  headers:{
      'User-Agent':'PC_UA',
  },
  timeout:5000,
  class_parse:'.top_nav.clearfix li;a&&Text;a&&href;.*/(.*?)\.html',
  cate_exclude:'',
  play_parse:true,
  lazy:$js.toString(()=>{
    input = {parse:1,url:input,js:''};
  }),
  double:true,
  推荐:'*;li;*;*;*;*',
  一级:'.vodlist.vodlist_wi.clearfix li;a&&title;a&&style;a&&Text;a&&href',
  二级:{
    title:'#content_box a&&title',
    img:'#content_box a&&style',
    desc:'#content_box div:eq(5) ul li:eq(1)&&Text;#content_box div:eq(5) ul li:eq(0) a&&Text;#content_box div:eq(5) ul li:eq(0) a:eq(1)&&Text;#content_box div:eq(5) ul li:eq(2)&&Text;#content_box div:eq(5) ul li:eq(3)&&Text',
    content:'#content_box div:eq(5) ul li:eq(4)&&Text',
    tabs:'#NumTab',
    lists:'.play_list_box:eq(#id)&&a',
    tab_text:'body&&Text',
    list_text:'body&&Text',
    list_url:'a&&href',
    list_url_prefix: '',
  },
  搜索:'列表;标题;图片;描述;链接;详情',
}