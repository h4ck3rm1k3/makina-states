# -*- coding: utf-8 -*-
'''
.. _module_mc_mongodb:

mc_mongodb / mongodb functions
============================================
'''

__docformat__ = 'restructuredtext en'
# Import python libs
import logging
import mc_states.utils

__name = 'mongodb'

log = logging.getLogger(__name__)


def settings():
    '''
    mongodb settings

    location
        installation directory

    '''
    @mc_states.utils.lazy_subregistry_get(__salt__, __name)
    def _settings():
        grains = __grains__
        pillar = __pillar__
        mongodb_reg = __salt__[
            'mc_macros.get_local_registry'](
                'mongodb', registry_format='pack')
        pw = mongodb_reg.setdefault(
            'password', __salt__['mc_utils.generate_password']())
        locs = __salt__['mc_locations.settings']()
        data = __salt__['mc_utils.defaults'](
            'makina-states.services.db.mongodb', {
                'admin': 'admin',
                'password': pw,
                'mongod': {
                    'dbpath': '/var/lib/mongodb',
                    'logpath': '/var/log/mongodb/mongod.log',
                    'logappend': 'true',
                    'bind_ip': '127.0.0.1',
                    'port': 27017,
                    'auth': 'true',
                    'nohttpinterface': 'true',
                    'rest': 'false'
                }
            })
        __salt__['mc_macros.update_local_registry'](
            'mongodb', mongodb_reg,
            registry_format='pack')
        return data
    return _settings()


def dump():
    return mc_states.utils.dump(__salt__,__name)

#
