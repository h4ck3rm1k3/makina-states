#!/usr/bin/logrotate python
# -*- coding: utf-8 -*-
'''

.. _module_mc_logrotate:

mc_logrotate / logrotate registry
============================================

If you alter this module and want to test it, do not forget
to deploy it on minion using::

  salt '*' saltutil.sync_modules

Documentation of this module is available with::

  salt '*' sys.doc mc_logrotate

'''
# Import python libs
import logging
import mc_states.utils

__name = 'logrotate'

log = logging.getLogger(__name__)


def settings():
    '''
    logrotate registry

    days
        days rotatation
    '''
    @mc_states.utils.lazy_subregistry_get(__salt__, __name)
    def _settings():
        saltmods = __salt__
        grains = __grains__
        pillar = __pillar__
        logrotateInterfaces = {}
        ddata = {}
        grainsPref = 'makina-states.localsettings.'

        # logrotation settings
        # This will generate a rotate_variables in the form
        # rotate_variables = {
        #     'days': 31,
        # }
        #
        # include the macro in your states and use:
        #   {{ rotate.days }}
        data = saltmods['mc_utils.defaults'](
            'makina-states.localsettings.rotate', {
                'days':  '365',
            })
        return data
    return _settings()


def dump():
    return mc_states.utils.dump(__salt__,__name)

#
# -*- coding: utf-8 -*-
__docformat__ = 'restructuredtext en'

# vim:set et sts=4 ts=4 tw=80:
