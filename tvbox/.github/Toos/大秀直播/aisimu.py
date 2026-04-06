import requests
import json
import time
import os
from bs4 import BeautifulSoup
from urllib.parse import urljoin
from concurrent.futures import ThreadPoolExecutor, as_completed

class AisiMuScraper:

    def __init__(self, config_path="config.json"):
        self.config = self._load_config(config_path)

        self.session = requests.Session()
        self.session.headers.update({
            "User-Agent": self.config.get("user_agent")
        })

        self.category_urls = {}     # {url: 分类名}
        self.results = {}           # {直播url: 主播/房间名}
        self.old_urls = set()
        self.new_urls = set()

        self.output_dir = "output"
        os.makedirs(self.output_dir, exist_ok=True)

        self._load_history()

    # ================= 基础 =================

    def _load_config(self, path):
        with open(path, "r", encoding="utf-8") as f:
            return json.load(f)

    def tg(self, text):
        token = self.config.get("tg_token")
        chat_id = self.config.get("tg_chat_id")
        if not token or not chat_id:
            return
        try:
            requests.post(
                f"https://api.telegram.org/bot{token}/sendMessage",
                data={"chat_id": chat_id, "text": text},
                timeout=10
            )
        except Exception as e:
            print(f"[AISIMU] Telegram 消息发送失败: {e}")

    def tg_file(self, filepath, caption=""):
        token = self.config.get("tg_token")
        chat_id = self.config.get("tg_chat_id")
        if not token or not chat_id:
            return
        try:
            with open(filepath, "rb") as f:
                requests.post(
                    f"https://api.telegram.org/bot{token}/sendDocument",
                    data={
                        "chat_id": chat_id,
                        "caption": caption
                    },
                    files={"document": f},
                    timeout=30
                )
        except Exception as e:
            print(f"[AISIMU] Telegram 文件发送失败: {e}")

    # ================= 登录 =================

    def login(self):
        print("[AISIMU] 尝试登录:", self.config["login_url"])
        try:
            r = self.session.get(self.config["login_url"], timeout=10)
            soup = BeautifulSoup(r.text, "html.parser")

            payload = {
                self.config["username_field"]: self.config["username"],
                self.config["password_field"]: self.config["password"]
            }

            token_field = self.config.get("csrf_token_field")
            if token_field:
                token = soup.find("input", {"name": token_field})
                if token:
                    payload[token_field] = token.get("value")

            r = self.session.post(
                self.config["login_url"],
                data=payload,
                allow_redirects=True,
                timeout=10
            )

            if self.config["login_failed_check_text"] in r.text:
                print("[AISIMU] ❌ 登录失败")
                self.tg("❌ AISIMU 登录失败")
                return False

            print("[AISIMU] 登录成功")
            return True

        except Exception as e:
            print("[AISIMU] 登录异常:", e)
            self.tg("❌ AISIMU 登录异常")
            return False

    # ================= 分类页 =================

    def fetch_index(self):
        r = self.session.get(self.config["logged_in_expected_url"], timeout=10)
        soup = BeautifulSoup(r.text, "html.parser")

        for a in soup.select('a[href*="zblist.php"]'):
            name = a.text.strip()
            url = urljoin(self.config["logged_in_expected_url"], a["href"])
            self.category_urls[url] = name

        print(f"[AISIMU] 发现分类页: {len(self.category_urls)}")

    # ======== 抓取 + 过滤规则（按你要求修正）========
    def fetch_category(self, url, cname, idx, total):
        try:
            r = self.session.get(url, timeout=10)
            soup = BeautifulSoup(r.text, "html.parser")

            for tr in soup.select("table tr"):
                tds = tr.find_all("td")
                if len(tds) < 4:
                    continue

                room_name = tds[2].get_text(strip=True)
                live = tds[3].get_text(strip=True)

                if not live.startswith("http"):
                    continue

                # === 你的核心过滤规则 ===
                banned_words = ["广播", "查看主播", "支付宝风控解除,之声,实力带飞,财经"]
                if any(w in room_name for w in banned_words):
                    continue

                # 只保留真正的主播名
                self.results[live] = room_name

            print(f"[AISIMU] 分类页进度: {idx}/{total}")

        except Exception as e:
            print(f"[AISIMU] ✖ 分类失败: {cname} -> {e}")

    # ================= 增量 =================

    def _load_history(self):
        path = os.path.join(self.output_dir, "history.txt")
        if os.path.exists(path):
            with open(path, "r", encoding="utf-8") as f:
                self.old_urls = set(x.strip() for x in f if x.strip())

    def _save_history(self):
        path = os.path.join(self.output_dir, "history.txt")
        with open(path, "w", encoding="utf-8") as f:
            for u in sorted(self.results.keys()):
                f.write(u + "\n")

    # ================= 多线程检测 =================

    def check_stream(self, url):
        try:
            r = self.session.head(
                url,
                timeout=(2, 4),
                allow_redirects=True
            )
            ok = r.status_code in (200, 301, 302)
            r.close()
            return ok
        except Exception:
            return False

    def validate_streams(self):
        print("[AISIMU] 多线程检测直播源可用性...")

        valid = {}
        total = len(self.results)

        with ThreadPoolExecutor(max_workers=10) as pool:
            future_map = {
                pool.submit(self.check_stream, url): (url, name)
                for url, name in self.results.items()
            }

            for i, future in enumerate(as_completed(future_map), 1):
                url, name = future_map[future]
                try:
                    if future.result():
                        valid[url] = name
                except Exception:
                    pass

                if i % 20 == 0 or i == total:
                    print(f"[AISIMU] 检测进度: {i}/{total}")

        self.results = valid
        print(f"[AISIMU] ✅ 检测完成，可用源: {len(valid)}/{total}")

    # ================= M3U 导出（按你要求修正） =================

    def export_m3u(self):
        lines = ["#EXTM3U"]

        for url, room_name in self.results.items():
            # 👉 这里已经去掉 group-title="查看主播"
            lines.append(f'#EXTINF:-1,{room_name}')
            lines.append(url)

        path = os.path.join(self.output_dir, "aisimu.m3u")
        with open(path, "w", encoding="utf-8") as f:
            f.write("\n".join(lines))

        print("[AISIMU] M3U 导出完成:", path)
        return path

    # ================= TXT 导出 =================

    def export_txt(self):
        path = os.path.join(self.output_dir, "aisimu.txt")

        with open(path, "w", encoding="utf-8") as f:
            for url, room_name in self.results.items():
                f.write(f"{room_name}\t{url}\n")

        print("[AISIMU] TXT 导出完成:", path)
        return path

    # ================= JSON 导出 =================

    def export_json(self):
        path = os.path.join(self.output_dir, "aisimu.json")

        data = [
            {"name": name, "url": url}
            for url, name in self.results.items()
        ]

        with open(path, "w", encoding="utf-8") as f:
            json.dump(data, f, ensure_ascii=False, indent=2)

        print("[AISIMU] JSON 导出完成:", path)
        return path

    # ================= 主流程 =================

    def run(self):
        if not self.login():
            return

        self.fetch_index()

        total = len(self.category_urls)
        with ThreadPoolExecutor(max_workers=6) as pool:
            tasks = []
            for i, (url, name) in enumerate(self.category_urls.items(), 1):
                tasks.append(pool.submit(self.fetch_category, url, name, i, total))
            for _ in as_completed(tasks):
                pass

        self.validate_streams()

        self.new_urls = set(self.results) - self.old_urls
        if self.new_urls:
            self.tg(f"🆕 新增直播源 {len(self.new_urls)} 条")

        m3u_path = self.export_m3u()
        txt_path = self.export_txt()
        json_path = self.export_json()

        self._save_history()

        self.tg_file(
            m3u_path,
            caption=f"✅ AISIMU 采集完成\n有效源: {len(self.results)}"
        )

        print("[AISIMU] 全流程完成，脚本退出")


if __name__ == "__main__":
    AisiMuScraper().run()
