var rule = {
  类型:'影视',//影视|听书|漫画|小说
  title:'花姐影院',
  host:'https://www.iyiwang.com/',
  url:'/search.php?page=fypage&searchtype=5&tid=fyclass',
  searchUrl:'/search.php?searchword=**',
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
  class_parse:'.fed-menu-info li;a&&Text;a&&href;.*/(.*?)\.html',
  cate_exclude:'',
  play_parse:true,
  lazy:$js.toString(()=>{
    input = {parse:1,url:input,js:''};
  }),
  double:true,
  推荐:'*;li;*;*;*;*',
  一级:'ul.fed-list-info.fed-part-rows li;a:eq(1)&&Text;a&&data-original;a&&Text;a:eq(1)&&href',
  二级:{
    title:'.fed-col-md10 a&&Text',
    img:'.fed-part-over a&&data-original',
    desc:'.fed-col-md10 ul li:eq(5)&&Text;.fed-col-md10 ul li:eq(4)&&Text;.fed-col-md10 ul li:eq(3)&&Text;.fed-col-md10 ul li:eq(0)&&Text;.fed-col-md10 ul li:eq(1)&&Text',
    content:'.fed-col-md10 ul li:eq(6)&&Text',
    tabs:'.nav-tabs.active li',
    lists:'.sort-list.clearfix:eq(#id)&&a',
    tab_text:'body&&Text',
    list_text:'body&&Text',
    list_url:'a&&href',
    list_url_prefix: '',
  },
  搜索:'.fed-list-info.fed-part-rows;a&&title;a&&data-original;a&&Text;a&&href',
}