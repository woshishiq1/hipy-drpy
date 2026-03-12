import random

def generate_android_id():
    """
    生成符合规则的Android ID

    Android ID是一个64位的十六进制字符串，通常表示为16个字符
    每个字符可以是0-9或a-f（小写）
    """
    # 定义十六进制字符集
    hex_chars = '0123456789abcdef'

    # 随机生成16个十六进制字符
    android_id = ''.join(random.choice(hex_chars) for _ in range(16))

    return android_id

if __name__ == "__main__":
    # 生成10个示例Android ID
    for i in range(10):
        aid = generate_android_id()
        print(f"Android ID #{i + 1}: {aid}")