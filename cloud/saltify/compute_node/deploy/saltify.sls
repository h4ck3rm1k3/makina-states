{% set cloudSettings = salt['mc_cloud.settings']() %}
{% set cloudcsettings = salt['mc_cloud_controller.settings']() %}
{% set cloudsaltSettings = salt['mc_cloud_saltify.settings']() %}
include:
  - makina-states.cloud.saltify.hooks

{% for target, data in cloudsaltSettings.targets.items() %}
{%  set mtdata = cloudcsettings.compute_nodes[target] %}
{%  if mtdata.activated.get('saltify') %}
{%    set name = data['name'] %}
{{target}}-{{name}}-saltify-deploy:
  cloud.profile:
    - require:
      - mc_proxy: cloud-saltify-pre-deploy
    - require_in:
      - mc_proxy: cloud-saltify-post-deploy
    - unless: test -e {{cloudSettings.prefix}}/pki/master/minions/{{name}}
    - name: {{name}}
    - minion: {master: "{{data.master}}",
               master_port: {{data.master_port}}}
    - profile: {{data.profile}}
{%    for var in ["ssh_username",
                  "keep_tmp",
                  "gateway",
                  "password",
                  "script_args",
                  "ssh_host",
                  "sudo_password",
                  "sudo"] %}
{%      if data.get(var) %}
    - {{var}}: {{data[var]}}
{%      endif%}
{%    endfor%}
{%  endif%}
{% endfor %}