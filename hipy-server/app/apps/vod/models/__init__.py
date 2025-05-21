from db.base_class import Base
from db.session import engine
from .vod_rules import VodRules
from .vod_configs import VodConfigs
from .vod_subs import VodSubs

__all__ = ['VodRules', 'VodConfigs', 'VodSubs']

Base.metadata.create_all(engine)
