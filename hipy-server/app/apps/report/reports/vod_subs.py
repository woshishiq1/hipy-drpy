#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# File  : vod_subs.py
# Author: DaShenHan&道长-----先苦后甜，任凭晚风拂柳颜------
# Author's Blog: https://blog.csdn.net/qq_32394351
# Date  : 2024/6/19

from sqlalchemy import desc, asc

from apps.report.gen_report import BaseQuery
from apps.vod.models.vod_subs import VodSubs
from apps.vod.curd.curd_subs import curd_vod_subs as curd
from utils.tools import list_to_tree


class Query(BaseQuery):
    def report_config(self):
        self.header = ["订阅名称", "订阅代码", "正则表达式", "状态", "匹配方式", "到期时间"]
        self.file_name = "订阅列表"

    def instance_data(self):
        q = self.query_params
        rows = curd.search(self.db, name=q.get('name'), code=q.get('code'), reg=q.get('reg'),
                           status=q.get('status'), mode=q.get('mode'), page=int(q.get('page') or 1),
                           page_size=int(q.get('page_size') or 1000))
        rows = rows['results']

        data = []
        for row in rows:
            data_row = [
                row['name'],
                row['code'],
                row['reg'],
                row['status'],
                row['mode'],
                row['due_time'],
            ]
            data.append(data_row)
        return data
