var rule = {
      title: '爱上电影',
      host: 'https://23dyw.cn',
      url: '/vod/list.html?fyfilter',
      searchUrl: '/public/auto/search1.html?keyword=**',
      searchable: 2,
      quickSearch: 0,
      filter_url: 'cate_id={{fl.class}}&page=fypage&type_id={{fl.cateId}}',
filter_def: {
'1': {cateId: '1'},'2': {cateId: '2'},'3': {cateId: '3'},'39': {cateId: '39'},'4': {cateId: '4'}},
      class_name:'电影&电视剧&短剧&动漫&综艺',
      class_url:'1&2&39&4&3',
      filterable: 1,
      headers: {'User-Agent':'MOBILE_UA'},
      timeout: 5000,
      play_parse: true,
      lazy:'',
      double: true,
      推荐: 'body&&.public-list-box;.public-list-div;a&&title;img&&src;.public-list-prb&&Text;a&&href',
      一级: '.public-list-box;.time-title&&Text;.cmslazyload&&data-original;.public-list-prb&&Text;a&&href;详情',
      二级: {
        title: '.this-desc-title&&Text;.focus-item-label-original&&Text',
        img: '.this-pic-bj&&style',
        desc: '.public-list-prb&&Text;.this-desc-info span:eq(1)&&Text;.this-desc-info span:eq(2)&&Text;.this-info:eq(1)--strong&&Text;.this-info:eq(0)--strong&&Text',
        content: '.this-desc:eq(0)--strong&&Text',
        tabs: '.title-tab a',
        lists: '.anthology-list-play:eq(#id)&&li',
      },
      搜索: '.box-width .public-list-box;.time-title&&Text;.cmslazyload&&data-original;.public-list-prb&&Text;a&&href;详情',
      filter:'H4sIAAAAAAAAA7XSy07CQBQG4L1PYWbdhW2R26sYFsSwEtkQTQwhURou7ULEaBUlcQNOURJLjFHK5WnojH0LpySFv8MWlzNf50zPf6ZCVJI9qpCTwgXJ7pPjYr5cJgop5U8L4dpvNfh4KjbO88WzcEd8WlpB3QkMJ4RwRapKtG85y3mPm82IMmB2zzcpmHqwQd4aM6OOqG6QXd2wSxtRg7ImlU7qUJZ2/MkUMQFlDYvVnhAPoeygKZ1MxtrkdzFMQdnaiNsdxDScbNwG3SEiJMS9N39+D6hBQqz1uPRMRJFQrppT9oi22xk+z5ceFbGuL4K0g9cu+/lAhLT9tssmC0RMe0T54hoR0mYPA9YbIULawctQ/BMipv3pSghps69vv28jZqLM9N1m1qdBt8Gns1/Ti1TH4YnM2q7kaqx/0aXkmhye5LrcqOSJqNfEf7wPy2Gz9/Vd27OMe3LrIcQ9tTW0uKdXvVT/ABW5VWGwBAAA'
}