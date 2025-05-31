# hipy-drpy
如果你 Fork 了本项目，并希望和主项目一样实现 每两天自动同步 Gitee 内容到 GitHub，请按照以下步骤进行设置：

🚀 第一步：启用 GitHub Actions
进入你 Fork 后的仓库主页

点击上方的 Actions 标签页

GitHub 会提示你 “I understand my workflows, enable them”，点击确认启用

💡 如果你不手动启用，GitHub 默认不会运行定时任务或任何自动流程！

🔐 第二步：修改 Token 权限为可写
打开你的仓库 → 点击顶部导航栏的 Settings

在侧边栏选择：Actions → General

滚动到底部找到 Workflow permissions

选择：✅ Read and write permissions

勾选下面的 “Allow GitHub Actions to create and approve pull requests” 也可（可选）

🔧 不设置成写权限，工作流中的 git push 等命令会失败（403 权限错误）

📅 第三步：手动运行一次工作流
再次回到 Actions 标签页

点击 Sync Gitee to subfolder and unzip to master 工作流

右侧点击绿色按钮 Run workflow → 直接点击运行一次

✅ 运行成功后，系统将自动每 2 天北京时间 00:00 执行一次同步

远程链接： https://ghproxy.net/https://raw.githubusercontent.com/woshishiq1/hipy-drpy/master/gitee-source/TVBoxOSC/tvbox/api.json
