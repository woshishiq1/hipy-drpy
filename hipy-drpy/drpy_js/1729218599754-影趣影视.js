var rule={
  title: "影趣影视",
  模板: "自动",
  host: "https://yingqu.net",
  url: "/vodshow/fyclass--------fypage---.html",
  searchUrl: "/vodsearch/**----------fypage---.html",
  filterable: 1,
  filter_url: '',
	filter: '',
  class_parse: ".navbar-items&&li;a&&Text;a&&href;(\\d+)",
  搜索: ".module-items&&.module-item;strong&&Text;img&&data-original;.module-item-note&&Text;a&&href;.module-card-item-info--strong&&Text",
}