#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# File  : vod_subs.py
# Author: DaShenHan&道长-----先苦后甜，任凭晚风拂柳颜------
# Author's Blog: https://blog.csdn.net/qq_32394351
# Date  : 2024/6/19

from db.base_class import Base
from db import fields


class VodSubs(Base):
    """ 源/规则 订阅列表 """
    name = fields.Char(string='订阅名称', required=True)
    code = fields.Char(string='订阅代码')
    reg = fields.Text(string='正则表达式')
    status = fields.Integer(string='状态')
    mode = fields.Integer(string='匹配模式:0正向匹配 1逆向排除')
    due_time = fields.Datetime(string='到期时间')
