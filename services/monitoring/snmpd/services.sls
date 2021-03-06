include:
  - makina-states.services.monitoring.snmpd.hooks
{% if salt['mc_controllers.mastersalt_mode']() %}
snmpd-start:
  service.running:
    - name: snmpd
    - enable: True
    - watch:
      - mc_proxy: snmpd-pre-restart-hook
    - watch_in:
      - mc_proxy: snmpd-post-restart-hook
{%endif %}
