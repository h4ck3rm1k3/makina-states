{{ salt['mc_macros.register']('services', 'base.ntp') }}
include:
  - makina-states.services.base.ntp.hooks
{% if salt['mc_controllers.mastersalt_mode']() %}  
  - makina-states.services.base.ntp.prerequisites
  - makina-states.services.base.ntp.configuration
  - makina-states.services.base.ntp.services
{% endif %}
