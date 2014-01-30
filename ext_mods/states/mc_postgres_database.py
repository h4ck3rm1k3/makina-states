# -*- coding: utf-8 -*-
'''
Wrapper to automaticly set the rigth pgsql to attack
'''
from salt.states import postgres_database as postgres


def absent(name, *args, **kw):
    return __salt__['mc_pgsql.wrapper'](postgres.absent)(name, *args, **kw)


def present(name, *args, **kw):
    return __salt__['mc_pgsql.wrapper'](postgres.present)(name, *args, **kw)

# vim:set et sts=4 ts=4 tw=80: