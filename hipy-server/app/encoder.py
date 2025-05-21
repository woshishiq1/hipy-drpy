#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# File  : encoder.py
# Author: DaShenHan&道长-----先苦后甜，任凭晚风拂柳颜------
# Date  : 2024/5/29

import os
from pathlib import Path
import shutil
import re
from utils.tools import base64Encode, base64Decode, compress_and_encode, decode_and_decompress, rsa_public_encode, \
    rsa_private_decode, rsa_public_key, aes_cbc_encode, aes_cbc_decode, aes_key, aes_iv
import random


def main():
    encode_dict = {
        '0': 'gzip',
        '1': 'base64',
        '2': 'rsa',
        '3': 'aes',
    }
    encode_mode = str(input(f'请选择要加密的模式[q退出,其他rsa之外随机加密]:\n{encode_dict}\n')).strip()
    if encode_mode == 'q':
        exit()
    encode_file = str(input(f'请输入要加密的文件。不输入则全部\n')).strip()
    encode_type = encode_dict.get(encode_mode) or 'gzip'
    encode_func1 = compress_and_encode
    encode_func2 = base64Encode
    encode_func3 = lambda text: rsa_public_encode(text, rsa_public_key)
    encode_func4 = lambda text: aes_cbc_encode(text, aes_key, aes_iv)
    # encode_funcs = [encode_func1, encode_func2, encode_func3, encode_func4]
    # 随机加密移除rsa
    encode_funcs = [encode_func1, encode_func2, encode_func4]
    encode_func_keys = encode_dict.keys()

    if encode_type == 'gzip':
        encode_func = encode_func1
    elif encode_type == 'base64':
        encode_func = encode_func2
    elif encode_type == 'rsa':
        encode_func = encode_func3
    elif encode_type == 'aes':
        encode_func = encode_func4
    else:
        encode_func = encode_func1

    base_dir = './t4/files/drpy_js'
    files = [Path(os.path.join(base_dir, file)).as_posix() for file in os.listdir(base_dir) if file.endswith('.js')]
    print('=================获取待加密文件=========================')
    print(f'数量: {len(files)}')
    print(files)
    print('=================加密前准备目录=========================')
    out_dir = './dist/drpy_js'
    if os.path.exists(out_dir):
        print(f'=================删除已存在的目录: {out_dir}=========================')
        shutil.rmtree(out_dir)
    print(f'=================创建目录: {out_dir}=========================')
    os.makedirs(out_dir, exist_ok=True)
    print(f'=================开始执行{encode_type}加密=========================')
    if encode_file:
        files = [file for file in files if encode_file in file]

    for file in files:
        # 判断随机加密
        if encode_mode not in encode_func_keys:
            encode_func = random.choice(encode_funcs)

        file_out_path = os.path.join(out_dir, os.path.basename(file))
        file_out_path = Path(file_out_path).as_posix()
        print('输出加密后的文件:', file_out_path)
        with open(file, encoding='utf-8') as f:
            file_content = f.read()
        write_content = file_content
        # 只对未加密过的进行加密
        if re.search('var rule|[\u4E00-\u9FA5]+|function|let |var |const |\(|\)|"|\'', file_content):
            write_content = encode_func(file_content)
        with open(file_out_path, mode='w+', encoding='utf-8') as f:
            f.write(write_content)


if __name__ == '__main__':
    # 使用例子
    # original_data = "这是需要被加密的文本"
    # encoded_data = compress_and_encode(original_data)
    # print("加密后的数据:", encoded_data)
    #
    # decoded_data = decode_and_decompress(encoded_data)
    # print("解密后的数据:", decoded_data)
    #
    # encoded_data = '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'
    # decoded_data = decode_and_decompress(encoded_data)
    # print("解密后的筛选:", decoded_data)

    main()
