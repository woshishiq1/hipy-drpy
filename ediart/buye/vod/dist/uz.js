const appConfig = {
  _webSite: "",
  /**
   * 网站主页，uz 调用每个函数前都会进行赋值操作
   * 如果不想被改变 请自定义一个变量
   */
  get webSite() {
    return this._webSite;
  },
  set webSite(value) {
    this._webSite = value;
  },

  _uzTag: "",
  /**
   * 扩展标识，初次加载时，uz 会自动赋值，请勿修改
   * 用于读取环境变量
   */
  get uzTag() {
    return this._uzTag;
  },
  set uzTag(value) {
    this._uzTag = value;
  },
};

const fetch = async (params) => {
  let p = "";
  if (params) {
    const tmp = [];
    for (let key in params) {
      tmp.push(`${key}=${encodeURIComponent(params[key])}`);
    }
    p = `&${tmp.join("&")}`;
  }
  const res = await req(`${appConfig.webSite}${p}`);
  return res.data;
};

/**
 * 异步获取分类列表的方法。
 * @param {UZArgs} args
 * @returns {@Promise<JSON.stringify(new RepVideoClassList())>}
 */
async function getClassList(args) {
  var backData = new RepVideoClassList();
  try {
    const ret = await fetch();
    backData.data = ret.class;
  } catch (error) {
    backData.error = error.toString();
  }
  return JSON.stringify(backData);
}

/**
 * 获取二级分类列表筛选列表的方法。
 * @param {UZArgs} args
 * @returns {@Promise<JSON.stringify(new RepVideoSubclassList())>}
 */
async function getSubclassList(args) {
  var backData = new RepVideoSubclassList();
  try {
  } catch (error) {
    backData.error = error.toString();
  }
  return JSON.stringify(backData);
}

/**
 * 获取分类视频列表
 * @param {UZArgs} args
 * @returns {@Promise<JSON.stringify(new RepVideoList())>}
 */
async function getVideoList(args) {
  var backData = new RepVideoList();
  try {
    const ret = await fetch({
      ac: "detail",
      t: args.url,
      pg: args.page,
    });
    backData.data = ret.list;
  } catch (error) {
    backData.error = error.toString();
  }
  return JSON.stringify(backData);
}

/**
 * 获取二级分类视频列表 或 筛选视频列表
 * @param {UZSubclassVideoListArgs} args
 * @returns {@Promise<JSON.stringify(new RepVideoList())>}
 */
async function getSubclassVideoList(args) {
  var backData = new RepVideoList();
  try {
  } catch (error) {
    backData.error = error.toString();
  }
  return JSON.stringify(backData);
}

/**
 * 获取视频详情
 * @param {UZArgs} args
 * @returns {@Promise<JSON.stringify(new RepVideoDetail())>}
 */
async function getVideoDetail(args) {
  var backData = new RepVideoDetail();
  try {
    const ret = await fetch({
      ac: "detail",
      ids: args.url,
    });
    if (ret.list && ret.list.length > 0) {
      backData.data = ret.list[0];
    }
  } catch (error) {
    backData.error = error.toString();
  }
  return JSON.stringify(backData);
}

/**
 * 获取视频的播放地址
 * @param {UZArgs} args
 * @returns {@Promise<JSON.stringify(new RepVideoPlayUrl())>}
 */
async function getVideoPlayUrl(args) {
  var backData = new RepVideoPlayUrl();
  try {
    const ret = await fetch({
      flag: args.flag,
      play: args.url,
    });

    if (ret.jx === 1 || ret.parse === 1) {
      backData.error = ret.msg || ret.message || JSON.stringify(ret);
    } else {
      if (Array.isArray(ret.url)) {
        const urls = [];
        for (let i = 0; i < ret.url.length; i += 2) {
          if (/^代理/i.test(ret.url[i])) continue;

          urls.push({
            name: ret.url[i],
            url: ret.url[i + 1],

            // header: ret.header,
            // priority: 0,
          });
        }
        backData.urls = urls;
        backData.data = urls[0];
      } else {
        backData.data = ret.url;
      }
      if (ret.header) backData.headers = ret.header;
    }
  } catch (error) {
    backData.error = error.toString();
  }
  return JSON.stringify(backData);
}

/**
 * 搜索视频
 * @param {UZArgs} args
 * @returns {@Promise<JSON.stringify(new RepVideoList())>}
 */
async function searchVideo(args) {
  var backData = new RepVideoList();
  try {
    const ret = await fetch({
      wd: args.searchWord,
      pg: args.page,
    });
    backData.data = ret.list;
  } catch (error) {
    backData.error = error.toString();
  }
  return JSON.stringify(backData);
}
