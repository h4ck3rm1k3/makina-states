# mod_php: PHP as an apache module
#
# Makina Corpus mod_php Deployment main state
#
# For usage examples please check the file php_example.sls on this same directory
#
# TODO: review comment
# Preferred way of altering default settings is to set them in the apache Virtualhost
# We do not alter the main php.ini configuration file. This file is including
# php_defaults.jinja, you can reuse phpSettings dictionnary on your managed virtualhost template
# for php default values.
#
# If you want to add some more module include this file and reuse phpSettings.packages
# to find the right one (check php_defaults.jinja mapping)
#
# consult pillar values with "salt '*' pillar.items"
# consult grains values with "salt '*' grains.items"
#
{% import "makina-states/_macros/services.jinja" as services with context %}
{{ salt['mc_macros.register']('services', 'php.modphp') }}
{% set localsettings = services.localsettings %}
{% set nodetypes = services.nodetypes %}
{% set locs = localsettings.locations %}
{% set phpSettings = services.phpSettings %}
include:
  - makina-states.services.http.apache
  - makina-states.services.php.common
{% if grains.get('lsb_distrib_id','') == "Debian" %}
   # Include dotdeb repository for Debian
  - makina-states.localsettings.repository_dotdeb
{% endif %}

{# Manage mod_php packages #}
makina-php-pkgs:
  pkg.installed:
    - pkgs:
      - {{ phpSettings.packages.main }}
      - {{ phpSettings.packages.mod_php }}
{% if phpSettings.modules.xdebug.install -%}
      - {{ phpSettings.packages.xdebug }}
{%- endif %}
{% if phpSettings.modules.apc.install -%}
      - {{ phpSettings.packages.apc }}
{%- endif %}
    - require:
        - pkg: makina-apache-pkgs
    # mod_php packages alteration needs an apache restart
    - watch_in:
       - service: makina-apache-restart

# Manage php-fpm packages
makina-mod_php-exclude-fpm-pkg:
  pkg.removed:
    - pkgs:
      - {{ phpSettings.packages.php_fpm }}
    - require_in:
      - pkg: makina-php-pkgs

#--- MAIN SERVICE RESTART/RELOAD watchers --------------
# Note that mod_php does not have his own service
# (as opposed to php-fpm), and should in fact
# make an apache reload. So we'll fake a change
# here and tell apache to reload
makina-php-restart:
  cmd.run:
    - name: echo "" && echo 'changed=yes comment="fake php restart for apache restart"'
    - require:
      - pkg: makina-php-pkgs
    - watch_in:
      - service: makina-apache-restart


# In most cases graceful reloads should be enough
makina-php-reload:
  cmd.run:
    - name: echo "" && echo 'changed=yes comment="fake php reload for apache restart"'
    - require:
      - pkg: makina-php-pkgs
    - watch_in:
      - service: makina-apache-restart
