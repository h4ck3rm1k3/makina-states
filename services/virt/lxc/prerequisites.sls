{%- set localsettings = salt['mc_localsettings.settings']() %}
include:
  - makina-states.services.virt.lxc.hooks

{% if grains['os'] in ['Ubuntu'] %}
{% set dist = localsettings.pkgSettings.apt.ubuntu.dist %}
{% else %}
{% set dist = localsettings.pkgSettings.apt.ubuntu.lts %}
{% endif %}
{% set locs = salt['mc_locations.settings']() %}
lxc-repo:
  pkgrepo.managed:
    - name: lxc
    - humanname: LXC PPA
    - name: deb http://ppa.launchpad.net/ubuntu-lxc/stable/ubuntu {{dist}} main
    - dist: {{dist}}
    - file: {{locs.conf_dir}}/apt/sources.list.d/lxc.list
    - keyid: 7635B973
    - keyserver: keyserver.ubuntu.com
    - watch:
      - mc_proxy: lxc-pre-pkg

lxc-pkgs:
  {#pkg.{{salt['mc_localsettings.settings']()['installmode']}}: #}
  pkg.latest:
{# no need anymore -> ppa #}
{% if False and grains['os'] in ['Ubuntu'] -%}
{% if localsettings.udist in ['precise'] %}
    - fromrepo: {{localsettings.udist}}-backports
{% endif %}
{% endif %}
    - pkgs:
      - lxc
      - lxctl
      - dnsmasq
    - watch_in:
      - mc_proxy: lxc-post-pkg
    - watch:
      - mc_proxy: lxc-pre-pkg
      - pkgrepo: lxc-repo
