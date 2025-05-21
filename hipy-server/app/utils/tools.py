# -*- coding: utf-8 -*-
"""
Created on 2023-09-13 16:00
---------
@summary: 爬虫入口
---------
@author: pepsi
"""
import hashlib

from Crypto.Cipher import PKCS1_v1_5 as Cipher_pkcs1_v1_5
from threading import Thread

import gzip
import base64
from Crypto.Cipher import AES, PKCS1_v1_5 as PKCS1_cipher
from Crypto.Util.Padding import pad, unpad
from Crypto.PublicKey import RSA

# https://www.bchrt.com/tools/rsa/
rsa_public_key = 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqop/41KajOvn4GD/6DKo/c3HRzDNJhGVy3k8osSCVj+d5cyVdjdhNzj+gQaVJqtjtWvWi50yGwAwWk7pUzYjp1RqDRufLpgZ7qZ25phfIgEWw6dpk83TDHhIC3a310umN1b2symACz/BIREMpEFWq3sUe/L0au5bWN6rl8e3ICNETn2c+UsN1Di0CflaFpsCMbvQDBGS1cxQ0Dfd4c7s7N7TchyusbKQRge8xm8AoPkyotCXqjw618WFKQM9XEPzDvg2tFoL5F57668vDUETh3o3S1TgLJYK+r2LYR/Wym7BsjWNx/j9dpHMaPUQHFb3jjZ2W3DMsY7ReXVm5Wnq5wIDAQAB'
rsa_private_key = 'MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCqin/jUpqM6+fgYP/oMqj9zcdHMM0mEZXLeTyixIJWP53lzJV2N2E3OP6BBpUmq2O1a9aLnTIbADBaTulTNiOnVGoNG58umBnupnbmmF8iARbDp2mTzdMMeEgLdrfXS6Y3VvazKYALP8EhEQykQVarexR78vRq7ltY3quXx7cgI0ROfZz5Sw3UOLQJ+VoWmwIxu9AMEZLVzFDQN93hzuzs3tNyHK6xspBGB7zGbwCg+TKi0JeqPDrXxYUpAz1cQ/MO+Da0WgvkXnvrry8NQROHejdLVOAslgr6vYthH9bKbsGyNY3H+P12kcxo9RAcVveONnZbcMyxjtF5dWblaernAgMBAAECggEAGdEHlSEPFmAr5PKqKrtoi6tYDHXdyHKHC5tZy4YV+Pp+a6gxxAiUJejx1hRqBcWSPYeKne35BM9dgn5JofgjI5SKzVsuGL6bxl3ayAOu+xXRHWM9f0t8NHoM5fdd0zC3g88dX3fb01geY2QSVtcxSJpEOpNH3twgZe6naT2pgiq1S4okpkpldJPo5GYWGKMCHSLnKGyhwS76gF8bTPLoay9Jxk70uv6BDUMlA4ICENjmsYtd3oirWwLwYMEJbSFMlyJvB7hjOjR/4RpT4FPnlSsIpuRtkCYXD4jdhxGlvpXREw97UF2wwnEUnfgiZJ2FT/MWmvGGoaV/CfboLsLZuQKBgQDTNZdJrs8dbijynHZuuRwvXvwC03GDpEJO6c1tbZ1s9wjRyOZjBbQFRjDgFeWs9/T1aNBLUrgsQL9c9nzgUziXjr1Nmu52I0Mwxi13Km/q3mT+aQfdgNdu6ojsI5apQQHnN/9yMhF6sNHg63YOpH+b+1bGRCtr1XubuLlumKKscwKBgQDOtQ2lQjMtwsqJmyiyRLiUOChtvQ5XI7B2mhKCGi8kZ+WEAbNQcmThPesVzW+puER6D4Ar4hgsh9gCeuTaOzbRfZ+RLn3Aksu2WJEzfs6UrGvm6DU1INn0z/tPYRAwPX7sxoZZGxqML/z+/yQdf2DREoPdClcDa2Lmf1KpHdB+vQKBgBXFCVHz7a8n4pqXG/HvrIMJdEpKRwH9lUQS/zSPPtGzaLpOzchZFyQQBwuh1imM6Te+VPHeldMh3VeUpGxux39/m+160adlnRBS7O7CdgSsZZZ/dusS06HAFNraFDZf1/VgJTk9BeYygX+AZYu+0tReBKSs9BjKSVJUqPBIVUQXAoGBAJcZ7J6oVMcXxHxwqoAeEhtvLcaCU9BJK36XQ/5M67ceJ72mjJC6/plUbNukMAMNyyi62gO6I9exearecRpB/OGIhjNXm99Ar59dAM9228X8gGfryLFMkWcO/fNZzb6lxXmJ6b2LPY3KqpMwqRLTAU/zy+ax30eFoWdDHYa4X6e1AoGAfa8asVGOJ8GL9dlWufEeFkDEDKO9ww5GdnpN+wqLwePWqeJhWCHad7bge6SnlylJp5aZXl1+YaBTtOskC4Whq9TP2J+dNIgxsaF5EFZQJr8Xv+lY9lu0CruYOh9nTNF9x3nubxJgaSid/7yRPfAGnsJRiknB5bsrCvgsFQFjJVs='
aes_key = 'hjdhnx'
aes_iv = 'dzyyds'
# js 如何使用:
"""
let ret = RSA.decode(data,key,{});
"""


def crack_pwd(pwd, key):
    pwd = get_md5(pwd)
    rsakey = RSA.importKey(key)
    cipher = Cipher_pkcs1_v1_5.new(rsakey)  # 生成对象
    cipher_text = base64.b64encode(cipher.encrypt(pwd.encode(encoding="utf-8")))  # 对传递进来的用户名或密码字符串加密
    value = cipher_text.decode('utf-8')  # 将加密获取到的bytes类型密文解码成str类型
    return value


# 加密
def get_md5(*args):
    """
    @summary: 获取唯一的32位md5
    """

    m = hashlib.md5()
    for arg in args:
        m.update(str(arg).encode())

    return m.hexdigest()


def get_sha1(*args):
    """
    @summary: 获取唯一的40位值， 用于获取唯一的id
    """

    sha1 = hashlib.sha1()
    for arg in args:
        sha1.update(str(arg).encode())
    return sha1.hexdigest()  # 40位


def get_base64(data):
    if data is None:
        return data
    return base64.b64encode(str(data).encode()).decode("utf8")


def key2hump(key):
    """
    下划线试变成首字母大写
    """
    return key.title().replace("_", "")


def list_to_tree(node_list, root_id=None, *, order="", exclude=None):
    """
        将list转成树结构 list = [{id:xx,parent_id:xx,},id:xx,parent_id:xx,},id:xx,parent_id:xx,}]
        :param root_id  返回选择的id结点  order    排序字段   exclude  剔除某个节点
    """
    if not node_list: return []
    # 排序
    if order: node_list.sort(key=lambda k: k.get(order))
    # node
    node_dict = {node["id"]: node if node.get("parent_id") else node.update({"parent_id": -1}) or node for node in
                 node_list}
    # children
    for node in node_list:
        if node["id"] == exclude: continue
        node_dict.setdefault(node["parent_id"], {}).setdefault("children", []).append(node)
    if root_id:
        return node_dict[root_id]
    return node_dict.get(-1, {}).get("children", [])


def dfs_tree_to_list(nodes):
    """
    将树结构转成list
    :param nodes:
    :return:
    """
    ids = []
    for node in nodes:
        ids.append(node["id"])
        children = node.get("children", [])
        if children != []: ids = ids + dfs_tree_to_list(children)
    return ids


def round_float(float_num, num=2):
    """
    四舍五入
    :param float_num:
    :param num:
    :return:
    """
    import decimal
    context = decimal.getcontext()
    context.rounding = decimal.ROUND_HALF_UP
    return float(round(decimal.Decimal(str(float_num)), num))


def thread_it(func, *args, **kwargs):
    t = Thread(target=func, args=args, kwargs=kwargs)
    t.setDaemon(True)
    t.start()


def base64Encode(text: str):
    """
    base64编码文本
    @param text:
    @return:
    """
    return base64.b64encode(text.encode("utf8")).decode("utf-8")  # base64编码


def base64Decode(text: str):
    """
    base64文本解码
    @param text:
    @return:
    """
    return base64.b64decode(text).decode("utf-8")  # base64解码


def compress_and_encode(data: str):
    # 压缩数据
    compressed_data = gzip.compress(data.encode('utf-8'))
    # 对压缩数据进行Base64编码
    encoded_data = base64.b64encode(compressed_data).decode('utf-8')
    return encoded_data


def decode_and_decompress(encoded_data: str):
    # 解码Base64数据
    decoded_data = base64.b64decode(encoded_data.encode('utf-8'))
    # 解压缩数据
    decompressed_data = gzip.decompress(decoded_data).decode('utf-8')
    return decompressed_data


def rsa_public_encode(text, public_key, default_length=117):
    """
    rsa公钥加密
    @param text: 明文
    @param public_key: 公钥
    @param default_length: 分段加密长度默认 256
    @return: 密文
    """
    public_key = "-----BEGIN RSA PRIVATE KEY-----\n" + public_key + "\n-----END RSA PRIVATE KEY-----"
    pub_key = RSA.importKey(public_key)
    cipher = PKCS1_cipher.new(pub_key)
    text = text.encode("utf-8)")
    length = len(text)
    if length < default_length:
        rsa_text = base64.b64encode(cipher.encrypt(text))  # 加密并转为b64编码
    else:
        # 需要分段
        offset = 0
        res = []
        while length - offset > 0:
            if length - offset > default_length:
                res.append(cipher.encrypt(text[offset:offset + default_length]))
            else:
                res.append(cipher.encrypt(text[offset:]))
            offset += default_length
        byte_data = b''.join(res)

        rsa_text = base64.b64encode(byte_data)

    ciphertext = rsa_text.decode("utf8")
    return ciphertext


def rsa_private_decode(ciphertext, private_key, default_length=117):
    """
    rsa私钥解密
    @param ciphertext: 加密的字符串
    @param private_key: 私钥
    @param default_length: 分段加密长度,默认256位
    @return: 解密后的文本明文
    """
    # 计算需要添加的等号数
    b64_ciphertext = ciphertext
    num_padding = 4 - (len(b64_ciphertext) % 4)
    if num_padding < 4:
        b64_ciphertext += "=" * num_padding
    # 将密文转换成byte数组
    ciphertext = base64.b64decode(b64_ciphertext)
    # 构建RSA解密器
    private_key = f'-----BEGIN RSA PRIVATE KEY-----\n{private_key}\n-----END RSA PRIVATE KEY-----'
    pri_Key = RSA.importKey(private_key)
    decrypter = PKCS1_cipher.new(pri_Key)
    # 解密
    length = len(ciphertext)
    # 长度不用分段
    if length < default_length:
        plaintext = b''.join(decrypter.decrypt(ciphertext, b' '))
    else:
        # 需要分段
        offset = 0
        res = []
        while length - offset > 0:
            if length - offset > default_length:
                res.append(decrypter.decrypt(ciphertext[offset:offset + default_length], b' '))
            else:
                res.append(decrypter.decrypt(ciphertext[offset:], b' '))
            offset += default_length

        plaintext = b''.join(res)
    return plaintext.decode('utf-8')


def bytesToHexString(_bytes, no_space=True):
    """
    将byte字节转成hex字符串
    @param _bytes: byte字节
    @param no_space: 是否不带空格返回，默认是
    @return: hex字符串
    """
    _str = ''.join(['%02X ' % b for b in _bytes])
    if no_space:
        _str = _str.replace(" ", "")
    return _str


def pad_bytes(data):
    # while len(data) % 16 != 0:
    #     data += b'\0'
    # return data
    data = pad(data, AES.block_size)
    print(data, '======= hex:', bytesToHexString(data))
    return data


def aes_cbc_encode(plaintext, key, iv):
    """
    aes cbc格式加密
    @param plaintext:待加密的明文字符串
    @param key: 加密密钥
    @param iv: 加密偏移量
    @return:加密后的文本明文
    """
    crypter = AES.new(pad_bytes(key.encode()), AES.MODE_CBC, pad_bytes(iv.encode()))
    # 填充
    plaintext = pad_bytes(plaintext.encode())
    # print(plaintext)
    # 加密
    ciphertext = crypter.encrypt(plaintext)
    # 输出密文
    return base64.b64encode(ciphertext).decode('utf-8')


def aes_cbc_decode(ciphertext, key, iv):
    """
    aes cbc格式解密
    @param ciphertext:加密的字符串
    @param key: 加密密钥
    @param iv: 加密偏移量
    @return:解密后的文本明文
    """
    # 将密文转换成byte数组
    ciphertext = base64.b64decode(ciphertext)
    # 构建AES解密器
    decrypter = AES.new(pad_bytes(key.encode()), AES.MODE_CBC, pad_bytes(iv.encode()))
    # 解密
    plaintext = decrypter.decrypt(ciphertext)
    # 去除填充
    plaintext = unpad(plaintext, AES.block_size)
    # 输出明文
    return plaintext.decode('utf-8')


if __name__ == '__main__':
    # 32位md5
    # 123456 => e10adc3949ba59abbe56e057f20f883e|e10adc3949ba59abbe56e057f20f883e
    # key = "MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAKoR8mX0rGKLqzcWmOzbfj64K8ZIgOdH\n" + "nzkXSOVOZbFu/TJhZ7rFAN+eaGkl3C4buccQd/EjEsj9ir7ijT7h96MCAwEAAQ=="
    # public_key = '-----BEGIN PUBLIC KEY-----\n' + key + '\n-----END PUBLIC KEY-----'
    # print(crack_pwd("123456", public_key))
    data = '你好drpy'
    aes_key = 'hjdhnx'  # hex:686A64686E780A0A0A0A0A0A0A0A0A0A
    aes_iv = 'dzyyds'  # hex:647A797964730A0A0A0A0A0A0A0A0A0A
    encode_str = aes_cbc_encode(data, aes_key, aes_iv)
    print(encode_str)
    decode_str = aes_cbc_decode(encode_str, aes_key, aes_iv)
    print(decode_str)
    encode_str = 'h36A5I5KdeB29zb3iwNWVx0m7uwstVbsPzuQmO9TORKWsPcBbNgA54BAedzNiFtNjffUVMDkFoHIjJtHZriiQwB1vzJiLqE/9nip4F5hdJr4AIWcVHBk5nQVnheGoGy4YPvbZ1Ux04WzXu7vSre7/a68/81mjyAjHu6+MbjybWVQdAS9I9PK4k38VSb6oKQJ8YKtSnoG1WMFnLhTSqbNsBBfRAtZ7yJoL2PDtJdhKS6pRVIL0PRQq/woy3aSL+0xo8Vi/8y66kHBHl5YEmYb+MTlYXdTQlID1DZZWXR9AMprvR1GK/PromLTdAR2QhInwkrnBNfXiBF3lF3q6pnUBFU1ZfSWnYVdTT6XveEzuKsN61Von9UcSE61JRisRv0kVYTx6j5JJPC5CltyMMhj/Hoz2MBuwMiT67G66CyVnpzjitdTa1RvM3y0OscVm1KWZ8eQKHRODDytTcTZhBD3ityqlV/BI6Q1pTEGzKmIhWjkGQM0cDQ7nWilKkp6eCKJIuYdMs8g9DM5yafqXOSj4r9kzb6Ol+9YHMk7ttXIABs='
    decode_str = aes_cbc_decode(encode_str, aes_key, aes_iv)
    print(decode_str)
