#py
import requests
import base64
import os

# ==========================
# 1. 配置区域（请根据你的实际情况修改）
# ==========================

# 🌟 你的 GitHub Personal Access Token（必须有 repo 权限）
GITHUB_TOKEN = '${GITHUB_TOKEN}'  # ← 请替换为你的真实 Token

# 🌟 GitHub 仓库信息
GITHUB_OWNER = 'leexuben'         # GitHub 用户名
GITHUB_REPO = 'TVBOX-merge'          # 仓库名
GITHUB_BRANCH = 'main'            # 分支名

# 🌟 目标文件在 GitHub 上的路径（即你要覆盖的文件路径）
TARGET_FILE_PATH_ON_GITHUB = '青龙.json'  # 根目录下的文件

# 🌟 本地要上传的文件路径（青龙面板中的路径）
LOCAL_FILE_PATH = '/ql/data/scripts/tvbox/青龙.json'  # 你生成的文件路径

# ==========================
# 2. 从环境变量读取 Token（推荐，更安全，可选）
# ==========================
import os
GITHUB_TOKEN = os.getenv('GITHUB_TOKEN', GITHUB_TOKEN)  # 优先使用环境变量中的 Token

if GITHUB_TOKEN == '${GITHUB_TOKEN}' or not GITHUB_TOKEN:
    print("[错误] 请设置你的 GitHub Personal Access Token！")
    print("    - 可以在脚本中直接修改 GITHUB_TOKEN = '你的token'")
    print("    - 或者在青龙面板的「环境变量」中添加变量 GITHUB_TOKEN")
    exit(1)

# ==========================
# 3. 读取本地文件内容并编码为 Base64
# ==========================
if not os.path.exists(LOCAL_FILE_PATH):
    print(f"[错误] 本地文件不存在：{LOCAL_FILE_PATH}")
    exit(1)

with open(LOCAL_FILE_PATH, 'rb') as f:
    file_content = f.read()
    encoded_content = base64.b64encode(file_content).decode('utf-8')

# ==========================
# 4. 调用 GitHub API 上传/覆盖文件
# ==========================
def upload_file_to_github():
    url = f'https://api.github.com/repos/{GITHUB_OWNER}/{GITHUB_REPO}/contents/{TARGET_FILE_PATH_ON_GITHUB}'

    # 先尝试获取当前文件信息，以获取 sha（更新时需要）
    headers = {
        'Authorization': f'token {GITHUB_TOKEN}',
        'Accept': 'application/vnd.github.v3+json',
    }

    sha = None
    resp = requests.get(url, headers=headers)

    if resp.status_code == 200:
        # 文件已存在，获取 sha
        data = resp.json()
        sha = data.get('sha')
    elif resp.status_code == 404:
        # 文件不存在，sha 可以为 None（直接创建）
        pass
    else:
        print(f"[错误] 获取文件信息失败，状态码：{resp.status_code}，响应：{resp.text}")
        exit(1)

    # 构造提交数据
    commit_message = f'自动上传 TVBOX影视.json 文件 ({os.getenv("TZ", "UTC")})'
    data = {
        'message': commit_message,
        'content': encoded_content,
        'branch': GITHUB_BRANCH,
    }

    if sha:
        data['sha'] = sha  # 更新文件时必须提供原文件的 sha

    # 发送 PUT 请求，上传/更新文件
    resp = requests.put(url, headers=headers, json=data)

    if resp.status_code in [200, 201]:
        print(f"✅ 成功上传/更新文件到 GitHub：{TARGET_FILE_PATH_ON_GITHUB}")
    else:
        print(f"[失败] 上传失败，状态码：{resp.status_code}，响应：{resp.text}")

# ==========================
# 4. 执行上传
# ==========================
if __name__ == '__main__':
    upload_file_to_github()
