#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# File  : view_subs.py
# Author: DaShenHan&道长-----先苦后甜，任凭晚风拂柳颜------
# Author's Blog: https://blog.csdn.net/qq_32394351
# Date  : 2024/6/19


from fastapi import APIRouter, Depends, Query, File, UploadFile
from sqlalchemy.orm import Session
from ...permission.models import Users
from ..schemas import subs_schemas
from ..curd.curd_subs import curd_vod_subs as curd

from common import deps, error_code

from common.resp import respSuccessJson, respErrorJson

router = APIRouter()

access_name = 'vod:subs'
api_url = '/subs'


@router.get(api_url, summary="搜索订阅")
async def searchRecords(*,
                        db: Session = Depends(deps.get_db),
                        status: int = Query(None),
                        mode: int = Query(None),
                        name: str = Query(None),
                        code: str = Query(None),
                        reg: str = Query(None),
                        page: int = Query(1, gt=0),
                        page_size: int = Query(20, gt=0),
                        ):
    res = curd.search(db, name=name, code=code, status=status, mode=mode, reg=reg, page=page, page_size=page_size)
    return respSuccessJson(res)


@router.get(api_url + "/{_id}", summary="通过ID获取订阅信息")
async def getRecord(*,
                    db: Session = Depends(deps.get_db),
                    _id: int,
                    ):
    return respSuccessJson(curd.get(db, _id=_id))


@router.post(api_url, summary="添加订阅")
async def addRecord(*,
                    db: Session = Depends(deps.get_db),
                    u: Users = Depends(deps.user_perm([f"{access_name}:post"])),
                    obj: subs_schemas.SubsSchema,
                    ):
    res = curd.create(db, obj_in=obj, creator_id=u['id'])
    if res:
        return respSuccessJson()
    return respErrorJson(error=error_code.ERROR_HIKER_DEVELOPER_ADD_ERROR)


@router.put(api_url + "/enable/{_ids}", summary="启用订阅")
async def enableRecords(*,
                        db: Session = Depends(deps.get_db),
                        u: Users = Depends(deps.user_perm([f"{access_name}:delete"])),
                        _ids: str,
                        ):
    _ids = list(map(lambda x: int(x), _ids.split(',')))
    for _id in _ids:
        curd.setStatus(db=db, _id=_id, status=1, modifier_id=u['id'])
    return respSuccessJson()


@router.put(api_url + "/disable/{_ids}", summary="禁用订阅")
async def disableRecords(*,
                         db: Session = Depends(deps.get_db),
                         u: Users = Depends(deps.user_perm([f"{access_name}:delete"])),
                         _ids: str,
                         ):
    _ids = list(map(lambda x: int(x), _ids.split(',')))
    for _id in _ids:
        curd.setStatus(db=db, _id=_id, status=0, modifier_id=u['id'])
    return respSuccessJson()


@router.put(api_url + "/{_id}", summary="修改订阅")
async def setRecord(*,
                    db: Session = Depends(deps.get_db),
                    u: Users = Depends(deps.user_perm([f"{access_name}:put"])),
                    obj: subs_schemas.SubsSchema,
                    _id: int,
                    ):
    curd.update(db, _id=_id, obj_in=obj, modifier_id=u['id'])
    return respSuccessJson()


@router.delete(api_url + "/{_ids}", summary="删除订阅")
async def delRecord(*,
                    db: Session = Depends(deps.get_db),
                    u: Users = Depends(deps.user_perm([f"{access_name}:delete"])),
                    _ids: str,
                    ):
    _ids = list(map(lambda x: int(x), _ids.split(',')))
    curd.deletes(db, _ids=_ids, deleter_id=u['id'])
    return respSuccessJson()
