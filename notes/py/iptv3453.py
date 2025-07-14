import requests
from bs4 import BeautifulSoup
base_url = "https://iptv345.com/"
fenlei = ["央视,ys","卫视,ws","综合,itv","体育,ty","电影,movie","其他,other"]
channel_list = []
for i in fenlei:
    group_name,group_id = i.split(",")
    api_url = f"https://iptv345.com?tid={group_id}"
 
    response = requests.get(api_url)

    if response.status_code == 200:
        print("请求成功！")
        #print(response.text)  # 打印返回的内容
        
        html_content = response.text

        soup = BeautifulSoup(html_content, 'html.parser')
        # 根据HTML结构定位目标<ul>标签
        ul_tag = soup.find('ul', {
            'data-role': 'listview',
            'data-inset': 'true',
            'data-divider-theme': 'a'
        })
        

        for li in ul_tag.find_all('li'):
            a_tag = li.find('a')
            if a_tag:
                # 处理相对路径链接
                channel_url = base_url.rstrip('/') + '/' + a_tag['href'].lstrip('/')
                channel_list.append(f"{a_tag.text.strip()},{channel_url}")            

    else:
        print("请求失败，状态码：", response.status_code)

# 打印结果
for channel in channel_list:
    print(channel)
