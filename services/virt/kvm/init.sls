{%- set nt_reg = salt['mc_nodetypes.registry']() %}
{{ salt['mc_macros.register']('services', 'virt.kvm') }}
include:
  - makina-states.services.virt.kvm.hooks
{% if salt['mc_controllers.mastersalt_mode']() %}
  - makina-states.services.virt.kvm.prerequisites
  - makina-states.services.virt.kvm.configuration
  - makina-states.services.virt.kvm.services
{% endif %}
