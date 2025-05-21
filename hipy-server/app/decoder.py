#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# File  : decoder.py
# Author: DaShenHan&道长-----先苦后甜，任凭晚风拂柳颜------
# Date  : 2024/6/28


import os
from pathlib import Path
import shutil
import re
from utils.tools import base64Encode, base64Decode, compress_and_encode, decode_and_decompress, rsa_public_encode, \
    rsa_private_decode, rsa_public_key, rsa_private_key, aes_cbc_encode, aes_cbc_decode, aes_key, aes_iv


def main():
    decode_func1 = decode_and_decompress
    decode_func2 = base64Decode
    decode_func3 = lambda text: rsa_private_decode(text, rsa_private_key)
    decode_func4 = lambda text: aes_cbc_decode(text, aes_key, aes_iv)
    # encode_funcs = [encode_func1, encode_func2, encode_func3, encode_func4]
    # 随机加密移除rsa
    decode_funcs = [decode_func1, decode_func2, decode_func4, decode_func3]
    base_dir = str(input(f'请输入要解密的文件所在目录[q退出]:\n')).strip()
    # base_dir = './dist/drpy_js'
    if not os.path.exists(base_dir):
        exit(f'不存在的路径:{base_dir}')
    files = [Path(os.path.join(base_dir, file)).as_posix() for file in os.listdir(base_dir) if file.endswith('.js')]
    print('=================获取待解密文件=========================')
    print(f'数量: {len(files)}')
    print(files)
    print('=================解密前准备目录=========================')
    out_dir = base_dir + '_out'
    if os.path.exists(out_dir):
        print(f'=================删除已存在的目录: {out_dir}=========================')
        shutil.rmtree(out_dir)
    print(f'=================创建目录: {out_dir}=========================')
    os.makedirs(out_dir, exist_ok=True)
    print(f'=================开始执行解密=========================')

    for file in files:
        file_out_path = os.path.join(out_dir, os.path.basename(file))
        file_out_path = Path(file_out_path).as_posix()
        with open(file, encoding='utf-8') as f:
            file_content = f.read()
        write_content = file_content
        # 只对已加密过的进行解密
        match_str = 'var rule|[\u4E00-\u9FA5]+|function|let |var |const |\(|\)|"|\''
        if not re.search(match_str, file_content):
            print('检测到已加密的文件:', file)
            i = 0
            decode_success = False
            while i < len(decode_funcs):
                decode_func = decode_funcs[i]
                try:
                    decode_content = decode_func(file_content)
                    if re.search(match_str, decode_content):
                        decode_success = True
                        write_content = decode_content
                        break
                except:
                    pass
                i += 1
            if not decode_success:
                print('解密文件失败:', file)
            else:
                print('输出解密后的文件:', file_out_path)

        with open(file_out_path, mode='w+', encoding='utf-8') as f:
            f.write(write_content)


if __name__ == '__main__':
    main()
