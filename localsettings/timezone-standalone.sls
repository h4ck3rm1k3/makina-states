{#-
# RVM integration
# see:
#   - makina-states/doc/ref/formulaes/localsettings/timezone.rst
#}

{% set localsettings = salt['mc_localsettings.settings']() %}
{{ salt['mc_macros.register']('localsettings', 'timezone') }}
{% macro do(full=True) %}
{%- set locs = salt['mc_localsettings.settings']()['locations'] %}
{%- set defaults = localsettings.timezoneSettings %}
{% if full %}
tz-pkgs:
  pkg.{{salt['mc_localsettings.settings']()['installmode']}}:
    - pkgs:
      - tzdata
{% endif %}
tz-conf:
  file.managed:
    - name: {{locs.conf_dir}}/timezone
    - source: salt://makina-states/files/etc/timezone
    - mode: 644
    - user: root
    - group: root
    - template: jinja
    - defaults:
      data: |
            {{ salt['mc_utils.json_dump'](defaults)}}

{% endmacro %}
{{ do(full=False)}}
