#!/usr/bin/env python
# -*- coding: utf-8 -*-
'''

.. _module_mc_env:

mc_env / env registry
============================================

If you alter this module and want to test it, do not forget
to deploy it on minion using::

  salt '*' saltutil.sync_modules

Documentation of this module is available with::

  salt '*' sys.doc mc_env

'''
# Import python libs
import logging
import mc_states.utils

__name = 'env'

log = logging.getLogger(__name__)
RVM_URL = (
    'https://raw.github.com/wayneeseguin/env/master/binscripts/env-installer')



def is_reverse_proxied():
    return __salt__['mc_cloud.is_vm']()


def settings():
    '''
    env registry

    default_env
        Environment defaults (one of: dev/prod/preprod)
    '''
    @mc_states.utils.lazy_subregistry_get(__salt__, __name)
    def _settings():
        saltmods = __salt__
        grains = __grains__
        env =  saltmods['mc_utils.get']('default_env',
                                        'dev')
        data = saltmods['mc_utils.defaults'](
            'makina-states.localsettings.env', {
                'env': env,
            })
        # retro compat
        data['default_env'] = data['env']
        return data
    return _settings()


def dump():
    return mc_states.utils.dump(__salt__,__name)

#
# -*- coding: utf-8 -*-
__docformat__ = 'restructuredtext en'

# vim:set et sts=4 ts=4 tw=80:
