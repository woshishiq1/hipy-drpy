import json
import os
import sys
from pathlib import Path
from Crypto.Cipher import AES
from Crypto.Util.Padding import pad, unpad

class 文件加解密器:
    def __init__(self, key="1234567890123", iv="1234567890123"):
        self.key = key
        self.iv = iv
    
    def 字符串转hex(self, 文本): 
        return 文本.encode().hex()
    
    def hex转字符串(self, hex文本): 
        return bytes.fromhex(hex文本).decode()
    
    def 加密文件(self, 输入文件, 输出文件):
        """加密单个文件"""
        try:
            print(f"加密: {输入文件} -> {输出文件}")
            
            with open(输入文件, 'r', encoding='utf-8') as f:
                data = json.load(f)
            
            # AES加密
            填充key = self.key.ljust(16, '0').encode()
            填充iv = self.iv.ljust(16, '0').encode()
            cipher = AES.new(填充key, AES.MODE_CBC, 填充iv)
            encrypted = cipher.encrypt(pad(json.dumps(data, ensure_ascii=False).encode(), 16))
            
            # 数据包装并转Hex
            header_hex = self.字符串转hex(f"$#{self.key}#$")
            cipher_hex = encrypted.hex()
            iv_hex = self.字符串转hex(self.iv)
            final_hex = header_hex + cipher_hex + iv_hex
            
            with open(输出文件, 'w') as f:
                f.write(final_hex)
            
            print(f"✓ 加密成功: {输入文件}")
            return True
            
        except Exception as e:
            print(f"✗ 加密失败 {输入文件}: {e}")
            return False
    
    def 解密文件(self, 输入文件, 输出文件):
        """解密单个文件"""
        try:
            print(f"解密: {输入文件} -> {输出文件}")
            
            with open(输入文件, 'r', encoding='utf-8') as f:
                hex数据 = f.read().strip()
            
            # 解析Hex数据
            header_end = hex数据.find(self.字符串转hex("#$")) + 4
            if header_end == -1:
                raise ValueError("文件格式错误，未找到有效的头部标记")
                
            header_hex, iv_hex = hex数据[:header_end], hex数据[-26:]
            cipher_hex = hex数据[header_end:-26]
            
            # 提取key和iv
            real_key = self.hex转字符串(header_hex)[2:-2]
            real_iv = self.hex转字符串(iv_hex)
            
            # AES解密
            填充key = real_key.ljust(16, '0').encode()
            填充iv = real_iv.ljust(16, '0').encode()
            cipher = AES.new(填充key, AES.MODE_CBC, 填充iv)
            decrypted = unpad(cipher.decrypt(bytes.fromhex(cipher_hex)), 16)
            
            with open(输出文件, 'w', encoding='utf-8') as f:
                json.dump(json.loads(decrypted.decode()), f, ensure_ascii=False, indent=2)
            
            print(f"✓ 解密成功: {输入文件}")
            return True
            
        except Exception as e:
            print(f"✗ 解密失败 {输入文件}: {e}")
            return False
    
    def 批量处理(self, 输入目录, 输出目录, 模式="enc"):
        """批量处理目录中的文件，保持原文件名"""
        输入路径 = Path(输入目录)
        输出路径 = Path(输出目录)
        输出路径.mkdir(parents=True, exist_ok=True)
        
        if 输入路径.is_file():
            # 如果输入是单个文件
            文件列表 = [输入路径]
        else:
            # 获取目录中的所有文件
            文件列表 = [f for f in 输入路径.iterdir() if f.is_file()]
        
        if not 文件列表:
            print(f"在 {输入路径} 中未找到文件")
            return
        
        print(f"找到 {len(文件列表)} 个文件进行处理...")
        
        成功计数 = 0
        for 输入文件 in 文件列表:
            # 保持原文件名，不添加后缀
            输出文件 = 输出路径 / 输入文件.name
            
            if 模式 == "enc":
                if self.加密文件(输入文件, 输出文件):
                    成功计数 += 1
            else:
                if self.解密文件(输入文件, 输出文件):
                    成功计数 += 1
        
        print(f"\n处理完成: 成功 {成功计数}/{len(文件列表)} 个文件")

def main():
    if len(sys.argv) < 3:
        print("用法:")
        print("  单个文件: python tvbox.py 输入文件 输出文件 [模式]")
        print("  批量处理: python tvbox.py 输入目录 输出目录 [模式] [--batch]")
        print("模式: enc-加密(默认) / dec-解密")
        print("说明: 加密和解密后的文件将保持原文件名")
        print("示例:")
        print("  单个加密: python tvbox.py api.json api.json")
        print("  单个解密: python tvbox.py api.json api.json dec")
        print("  批量加密: python tvbox.py input_dir output_dir enc --batch")
        print("  批量解密: python tvbox.py input_dir output_dir dec --batch")
        sys.exit(1)

    输入路径, 输出路径 = sys.argv[1], sys.argv[2]
    
    # 判断模式
    模式 = sys.argv[3] if len(sys.argv) > 3 else "enc"
    
    # 判断是否批量模式
    批量模式 = len(sys.argv) > 4 and sys.argv[4] == "--batch"
    
    加解密器 = 文件加解密器()
    
    # 自动判断是否为目录
    输入路径是目录 = os.path.isdir(输入路径)
    
    if 批量模式 or 输入路径是目录:
        加解密器.批量处理(输入路径, 输出路径, 模式)
    else:
        if 模式 == "enc":
            加解密器.加密文件(输入路径, 输出路径)
        else:
            加解密器.解密文件(输入路径, 输出路径)

if __name__ == "__main__":
    main()
