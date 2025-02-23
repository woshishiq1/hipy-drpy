var rule = {
  title: '布蕾4k',
  host: 'https://waptv.sogou.com',
  url: '/napi/video/re?class=1&fr=filter&req=list&entity=fyfilter',
  homeUrl: 'http://124.222.116.5/homedata/home.json',
  searchUrl: 'http://114.132.55.23/bl/mb/api.php/provide/vod/?ac=videolist&wd=**&',
  headers: {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36'
  },
  searchable: 2,
  quickSearch: 1,
  filterable: 1,
  filter_url: 'fyclass&len=20&style={{fl.类型}}&zone={{fl.地区}}&year={{fl.年份}}&emcee={{fl.明星}}&order={{fl.排序}}&start=fypage&',
  class_name: '电影&电视剧&综艺&动漫',
  class_url: 'film&teleplay&tvshow&cartoon',
  filter: 'H4sIAAAAAAAAA+2cW1MaSRTH3/MpUjzvg5jNZferbOXBSrG1qTVxK3GzlUqliks0gIpAGYRwdV0goujgFQbBLzPdM3yLHaY7IAjnlJypKU0NT+j8nL/nzOnT3X8bPzx4aL48v79cfOX59eFv1lf914fBO+v6n7735mWP3mizwprnp9GLrxde+aZffbew+Ldv5N6TNYa369+LpXIsUh271/Ce15AbxMebPwQp6eEGD62AShKhKrHoN62Tg2MSCFWJB+LcnwKVJELOXjXBWm04ewIhxxSK8uBXOCaBkGOKHumdGhyTQMgVUf6MZU8i5OyF05oagbMnELJS8EBPJWAlgdgwnvQtJHsCIceU+mxEVDgmgVCVtMuScaiAShIhx1RfN8IFOCaBkJ/T5n/GLtxhJUJVMuoVtg6PXImQY1o519pwh5XITaWR7zwffHXtN5g8+7KcwtbHq3Aw+06+OuPsu7pi3g6OTiDUPPYqGd48ApUkQq9Chbe6SBVaCDmm4h7LduCYBEIewycKpiQRstJ2mecOYCWBkGffbgyLSSLkbrHWwJQkQp8/FBYtsfwOMoV8p+5ld2qdau3xbA6708Srs3Wn+bn5n8HYLICaQ/MmjzCVR3aozGMq83aoeDEVrx0qc5jKnA0q3l8QFROwQeUZpvLMDpWnmMpTO1SeYCpP7FB5jKk8tkMFG/teO8a+Fxv7XjvGvhcb+1762OfZU769B088ArFvLuCxJFM3p80Fk6/ONhfwnN+4SuihOk/WwRjpebSU+qlKwSvj5ZdmmOS1ydEnrX1havb206Da2xdLbybJTXt01rvn4o6eZd+i76/Fhfd3yvpz0JBzzGTshTqsGYS3BAIhl6lz9otj23oWOGeh8YYxpiQQ8ubDOesvtso2j+GYBEKuCOesv3pF65YQS8lCyO3RMaPHOYPbOTPYUDbMJw5nTyDkmFZzPA93I4mQlVxDzjXkpsXkGnIEJdeQcw0515C7ruIacqMqriHnGnKQimvIXVdxDTnXkJtqyL17+8fSP3fLjssVNVXVq354BTigyMvNrSI/RTbcAiEXULygHyBWmUDIxXN4ZShheGErEPq24JwpyCk5gVCVesUTrRVHNlUWQlbyR7Dykwi59rqx3m4R2+r0EfJzajZ5GLY0JUKOSa2xQ/icl0Totbdi/s5I7VkIWSm0wj/Bz0kiZKXAudkDkJO0FkJVYvE4r8KbX4mQlWJFFs4i1rOFkLPn2BlDc7XBo2VYSSD05dsxehZUIOSRW03wLxnMeu4j5IpwzVNbzFPnLE2+Xe4VkU2EQMhKB1VzzoOVBHIfq5CnYzw9PpMMN0YTr85WhVrnix6E/1wqEXLfiK3p9Ya+G4Vbx4Ci996kcZpnhwGk/X6nyHVyWdLbGywML3OHFFnPXzPiG7CYQMhPbr+kqfC2WSLkHcnZGbvIwzsSgZCVwkm2Cv+hQiLkOmzU+PkZXIQCISvlY7r6L6wkELLSToJnvsFKArFhXcNPa3qlhS1tJEXV6x0HWABesUnEhn6oNVO8sI31Q0mR+8WqX49F2AY8aQ4psp5yyUuXWkvhm/B+fAQkZzXTYcd7PA8vd4aUDWMOHQkCIedTvTC68IEZiZCVwmlzNPFgBRYbUDaue1xDmKjmjCH8YuHN8tLS6zvlCDvnm5pVY+wgxrNA6D072cvA+ymJkGPqxpiSYOUT9ESFoMh6zn1Cu7TDsvAYlwhZKbCmhxuIK2ch5OyVC736Fpw9gdC7l4odypMIOaZslGdgB0siVCVNPWZ1eE0iEfL4jTbYFbzAkwg5e/tl4wjeOUmEvELOJ3kaWSELhJw9xxxh5/4HhuHvYL6VRMjPqb6FdViJkLP3Q/u0zh1pdNDTzHY0FfmIiUDuZW24RwxnU3GPGN5SxT1ieGsV94jhbVXcI4auozRB6QdxlB58/B/LmRTJ7U8AAA==',
  // limit: 6,
  //double: false,
  play_parse: true,
  lazy: $js.toString(() => {
    let d = [];
    function checkVariable(variable) {
      if (/\.m3u8$/.test(variable) || /\.mp4$/.test(variable)) {
        return variable;
      } else if (/^mytv/.test(variable)) {
        let url = 'http://114.132.55.23/bl/bapi/mytv.php?url=';
        let key = CryptoJS.MD5(variable + "qazwsx1234.").toString()
        let sign = CryptoJS.MD5("qazwsx1234." + variable).toString()
        let uu = url + variable + "&mykey=" + key;
        return JSON.parse(request(uu, { headers: { "xiafan-sign": sign } })).url
      } else if (/html$/.test(variable)) {
        function player(input) {
          pdfh = jsp.pdfh;
          var html = request(input);
          var url = pdfh(html, ".videoplay&&iframe&&src");
          //console.log("&&&&&&&&&&&&&_______"+url)   
          if (url.includes('fun:321/v')) {
            let heade = {
              "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36",
              "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
              "sec-ch-ua-mobile": "?0",
              "dnt": "1",
              "upgrade-insecure-requests": "1",
              "sec-fetch-site": "none",
              "sec-fetch-mode": "navigate",
              "sec-fetch-user": "?1",
              "sec-fetch-dest": "document",
              "accept-language": "zh-CN,zh;q=0.9,en;q=0.8",
              "priority": "u=0, i",
              "Referer": ""
            }
            fetch(url, { headers: heade, method: 'HEAD' })
            let aa = pdfh(request(url, { headers: heade }), 'body&&script&&Html')
            //console.log("&&&&&&&&&&&&&_______"+player+'iiiivvv===='+fetch(url,{headers:heade}))
            var player = aa.match(/player\s*=\s*"([^"]+)";/)[1];
            var iv = aa.match(/rand\s*=\s*"([^"]+)";/)[1];
            //console.log("&&&&&&&&&&&&&_______"+player+'iiiivvv===='+iv)  
            iv = CryptoJS.enc.Utf8.parse(iv);
            var key = CryptoJS.enc.Utf8.parse("VFBTzdujpR9FWBhe");
            function AES_Decrypt(word) {
              var srcs = word;
              var decrypt = CryptoJS.AES.decrypt(srcs, key, {
                iv: iv,
                mode: CryptoJS.mode.CBC,
                padding: CryptoJS.pad.Pkcs7
              });
              return decrypt.toString(CryptoJS.enc.Utf8);
            }
            return JSON.parse(AES_Decrypt(player)).url
          } else if (url.includes('https://v.qq')) {
            url = url.split('url=')[1];
            let aa = "http://www.wmmys.wmmys.cn/api/index?parsesId=3878&appid=10001&videoUrl=";
            let cc = "http://svip.yuzhoukeji.top:88/api/index?parsesId=13&appid=10004&videoUrl=";
            let url1 = JSON.parse(request(aa + url)).url;   
            var withoutDomain = url1.replace(/^https:\/\/baidu\.con\//, '');
            var first16Chars = withoutDomain.substring(0, 16);
            var remainingString = withoutDomain.substring(16);
            var key = CryptoJS.enc.Utf8.parse(first16Chars);
            var iv = key;
            function AES_Decrypt(word) {
              var srcs = word;
              var decrypt = CryptoJS.AES.decrypt(srcs, key, {
                iv: iv,
                mode: CryptoJS.mode.CBC,
                padding: CryptoJS.pad.Pkcs7
              });
              return decrypt.toString(CryptoJS.enc.Utf8);
            };
            return AES_Decrypt(remainingString)
          } else {
            url = url.replace('https://jx.xmflv.com/?url=', 'https://vip.hls.one:4433/api?sign=9ije09ikj63hf&key=94b07e0b2c0e8244&url=');
            let url2 = JSON.parse(request(url)).url
            return url2
          }
        }
        return player(variable)
      } else if (/^nmys2/.test(variable)) {
        let url = 'http://114.132.55.23/bl/bapi/nmys2.php?url=';
        let key = CryptoJS.MD5(variable + "qazwsx1234.").toString()
        let sign = CryptoJS.MD5("qazwsx1234." + variable).toString()
        let uu = url + variable + "&mykey=" + key;
        return JSON.parse(request(uu, { headers: { "xiafan-sign": sign } })).url
      } else if (/^yhdm2/.test(variable)) {
        let url = 'http://114.132.55.23/bl/bapi/yhdm.php?url=';
        let key = CryptoJS.MD5(variable + "qazwsx1234.").toString()
        let sign = CryptoJS.MD5("qazwsx1234." + variable).toString()
        let uu = url + variable + "&mykey=" + key;
        return JSON.parse(request(uu, { headers: { "xiafan-sign": sign } })).url
      } else if (/^dmbs/.test(variable)) {
        let url = 'http://114.132.55.23/bl/bapi/dmbs.php?url=';
        let key = CryptoJS.MD5(variable + "qazwsx1234.").toString()
        let sign = CryptoJS.MD5("qazwsx1234." + variable).toString()
        let uu = url + variable + "&mykey=" + key;
        return JSON.parse(request(uu, { headers: { "xiafan-sign": sign } })).url
      } else {
        let url = 'http://114.132.55.23/bl/bapi/bba.php?url=';
        let key = CryptoJS.MD5("ETH-" + variable + "qazwsx1234.").toString()
        let sign = CryptoJS.MD5("qazwsx1234." + "ETH-" + variable).toString()
        let uu = url + "ETH-" + variable + "&mykey=" + key;
        return JSON.parse(request(uu, { headers: { "xiafan-sign": sign } })).url
      }
    }
    let url = checkVariable(input);
    input = {
      url: url,
      parse: 0,
      header: rule.headers
    }
    setResult(d)
  }),
  推荐: $js.toString(() => {
    let d = [];
    let data = JSON.parse(request(input))
    data.forEach(item => {
      item.datas.forEach(it => {
        let id = `http://114.132.55.23/bl/mb/api.php/provide/vod/?ac=videolist&wd=${it.title}&`;
        d.push({
          url: id,
          title: it.title,
          img: it.pic,
          desc: it.acr,
        })
      });
    });
    setResult(d)
  }),
  一级: $js.toString(() => {
    let d = [];
    let url = input.replace(/start=\d+/, `start=${(MY_PAGE - 1) * 20}`);
    let data = JSON.parse(request(url)).data.results
    data.forEach(it => {
      let id = `http://114.132.55.23/bl/mb/api.php/provide/vod/?ac=videolist&wd=${it.name}&`;
      d.push({
        url: id,
        title: it.name,
        img: it.v_picurl,
        desc: it.zone,
      })
    });
    setResult(d)
  }),
  二级: $js.toString(() => {
    VOD = JSON.parse(request(input)).list[0];
  }),
  搜索: $js.toString(() => {
    let d = [];
    let a = JSON.parse(request(input)).list;
    a.forEach(it => {
      let id = `http://114.132.55.23/bl/mb/api.php/provide/vod/?ac=videolist&wd=${it.vod_name}&`;
      d.push({
        url: id,
        title: it.vod_name,
        img: it.vod_pic,
        desc: it.vod_remarks,
        year: it.vod_year,
      })
    });
    setResult(d)
  }),
}