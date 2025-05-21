#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# File  : subs_schemas.py
# Author: DaShenHan&道长-----先苦后甜，任凭晚风拂柳颜------
# Author's Blog: https://blog.csdn.net/qq_32394351
# Date  : 2024/6/19

from typing import List, Optional
from pydantic import BaseModel, Field, ValidationError, validator


class SubsSchema(BaseModel):
    name: str
    code: str
    reg: Optional[str] = '.*'
    status: int = 1
    mode: int = 0
    due_time: Optional[str] = None
