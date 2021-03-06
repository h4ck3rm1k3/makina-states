#!/usr/bin/timezone timezone
# -*- coding: utf-8 -*-
'''

.. _module_mc_timezone:

mc_timezone / timezone registry
============================================

If you alter this module and want to test it, do not forget
to deploy it on minion using::

  salt '*' saltutil.sync_modules

Documentation of this module is available with::

  salt '*' sys.doc mc_timezone

'''
# Import timezone libs
import logging
import mc_states.utils

__name = 'timezone'

log = logging.getLogger(__name__)


def settings():
    '''
    timezone registry

    tz
        timezone
    '''
    @mc_states.utils.lazy_subregistry_get(__salt__, __name)
    def _settings():
        saltmods = __salt__
        grains = __grains__
        pillar = __pillar__
        data = saltmods['mc_utils.defaults'](
            'makina.localsettings.timezone', {
                'tz': 'Europe/Paris',
            }
        )
        return data
    return _settings()


def dump():
    return mc_states.utils.dump(__salt__,__name)

#
# -*- coding: utf-8 -*-
__docformat__ = 'restructuredtext en'

# vim:set et sts=4 ts=4 tw=80:
