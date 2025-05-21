#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# File  : curd_subs.py
# Author: DaShenHan&道长-----先苦后甜，任凭晚风拂柳颜------
# Author's Blog: https://blog.csdn.net/qq_32394351
# Date  : 2024/6/19


from sqlalchemy.orm import Session
from common.curd_base import CRUDBase
from ..models.vod_subs import VodSubs
from typing import Optional, List
from sqlalchemy import asc, desc, func, exists


class CURDVodSubs(CRUDBase):

    def dataCount(self, db: Session) -> dict:
        data = super().dataCount(db)
        data_active_count = db.query(self.model).filter(self.model.is_deleted == 0, self.model.status == 1).count()
        data.update({'data_active_count': data_active_count})
        return data

    def create(self, db: Session, *, obj_in, creator_id: int = 0):
        return super().create(db, obj_in=obj_in, creator_id=creator_id)

    def getByName(self, db: Session, name: str):
        record = db.query(self.model).filter(self.model.name == name, self.model.is_deleted == 0).first()
        return record

    def getByCode(self, db: Session, code: str):
        record = db.query(self.model).filter(self.model.code == code, self.model.is_deleted == 0).first()
        return record

    def isExists(self, db: Session):
        exists_query = db.query(exists().where(self.model.status == 1, self.model.is_deleted == 0))
        record = exists_query.scalar()
        return record

    def search(self, db: Session, *,
               status: int = None,
               mode: int = None,
               name: str = None,
               code: str = None,
               reg: str = None,
               order_bys: Optional[list] = None,
               page: int = 1, page_size: int = 20) -> dict:
        filters = []
        if status is not None:
            filters.append(self.model.status == status)
        if mode is not None:
            filters.append(self.model.mode == mode)
        if name:
            filters.append(self.model.name.ilike(f"%{name}%"))
        if code:
            filters.append(self.model.code.ilike(f"%{code}%"))
        if reg:
            filters.append(self.model.reg.ilike(f"%{reg}%"))
        records, total, _, _ = self.get_multi(db, page=page, page_size=page_size, filters=filters, order_bys=order_bys)

        return {'results': records, 'total': total}


curd_vod_subs = CURDVodSubs(VodSubs)
