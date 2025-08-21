# 检查是否以管理员权限运行
function Check-Admin {
    $isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
    if (-not $isAdmin) {
        Write-Host "当前没有管理员权限，正在尝试以管理员权限重新启动脚本..."
        Start-Process PowerShell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `$PSCommandPath" -Verb RunAs
        Wait-Process
        Exit
    }
}

# 检查管理员权限
Check-Admin

# 清理旧文件
Remove-Item -Path "ips_ports.txt" -ErrorAction SilentlyContinue
Clear-Host

# 欢迎界面
function Show-Welcome {
    Write-Host "###############################################"
    Write-Host "#                                             #"
    Write-Host "#       欢迎使用 Cloudflare IP 反代查询工具   #"
    Write-Host "#               Blog: jhb.ovh                 #"
    Write-Host "#    Telegram: https://t.me/+ft-zI76oovgwNmRh #"
    Write-Host "#               反馈bug请加群                 #"
    Write-Host "###############################################"
    Write-Host ""
}

# 显示欢迎界面
Show-Welcome

# 检查或下载 CloudflareSpeedTest
function Install-CloudflareST {
    if (-not (Test-Path "./CloudflareSpeedTest.exe")) {
        Write-Host "未检测到 CloudflareSpeedTest，正在下载..."
        
        $ARCH = (Get-CimInstance Win32_Processor).Architecture
        $URL = ""

        switch ($ARCH) {
            9 { $URL = "https://github.com/ShadowObj/CloudflareSpeedTest/releases/download/v2.2.6/CloudflareSpeedtest_win_amd64.exe" }
            12 { $URL = "https://github.com/ShadowObj/CloudflareSpeedTest/releases/download/v2.2.6/CloudflareSpeedtest_win_arm64.exe" }
            default {
                Write-Host "不支持的架构: $ARCH"
                Exit
            }
        }

        Invoke-WebRequest -Uri $URL -OutFile "CloudflareSpeedTest.exe"
    } else {
        Write-Host "CloudflareSpeedTest 已存在，跳过下载。"
    }
}

# 安装 CloudflareSpeedTest
Install-CloudflareST

# 获取运行目录下的 *.csv 文件
$csvFiles = Get-ChildItem -Path . -Filter "*.csv"
if ($csvFiles.Count -eq 0) {
    Write-Host "未检测到 CSV 文件，请确保运行目录中包含有效的 CSV 文件。"
    Exit
}

# 处理 CSV 文件内容
Write-Host "检测到以下 CSV 文件:"
$csvFiles | ForEach-Object { Write-Host $_.Name }

foreach ($file in $csvFiles) {
    Write-Host "正在处理文件: $($file.Name)"
    try {
        # 读取 CSV 文件内容
        $data = Import-Csv -Path $file.FullName -Delimiter ","  # 假设使用逗号分隔

        foreach ($entry in $data) {
            if ($entry.ip -and $entry.port) {
                $output = "{0}:{1}" -f $entry.ip, $entry.port
                $output | Out-File -FilePath "ips_ports.txt" -Append -Encoding Ascii
            } else {
                Write-Host "文件 $($file.Name) 中存在无效条目，跳过此行。"
            }
        }

    } catch {
        Write-Host "处理文件 $($file.Name) 时发生错误: $_"
    }
}

Write-Host "所有文件处理完成，结果已保存到 ips_ports.txt。"

# 获取 CloudflareSpeedTest 参数
$DN_COUNT = Read-Host "请输入 -dn 参数（要下载速度的 IP 数量）[默认值: 100]"
if (-not $DN_COUNT) { $DN_COUNT = 100 }

# 运行 CloudflareSpeedTest 测试
Write-Host "正在运行 CloudflareSpeedTest..."
./CloudflareSpeedTest.exe -f "ips_ports.txt" -dn $DN_COUNT -p 99999 -url "https://speed.cloudflare.com/__down?bytes=200000000" -sl 1 -tl 1000
