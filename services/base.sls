{% set data=pillar.get('makina_ldap', {}) %}
{% set ldap_en=data.get('enabled', False) %}
include:
  - makina-states.localsettings.base
  - makina-states.services.nscd
  - makina-states.services.ssh
  {%- if ldap_en %}
  - makina-states.services.ldap
  {% endif %}

# DONE MINION BY MINION, CANT BE GENERIC
#  - makina-states.services.shorewall
# TODO:
#  - makina-states.services.bacula-fd
#  - makina-states.services.snmp
