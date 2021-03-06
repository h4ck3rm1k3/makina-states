include:
  - makina-states.localsettings.updatedb.hooks

{% if salt['mc_controllers.mastersalt_mode']() %}
{% set data = salt['mc_updatedb.settings']() %}
{% set sdata = salt['mc_utils.json_dump'](data) %}
{% for f in ['/etc/updatedb.conf'] %}
etc-update-{{f}}:
  file.managed:
    - watch:
      - mc_proxy: updatedb-post-install
    - name: {{f}}
    - source: salt://makina-states/files/{{f}}
    - mode: 700
    - user: root
    - template: jinja
    - makedirs: true
    - group: root
    - defaults:
      data: |
            {{sdata}}
{% endfor %}
{% endif %}
