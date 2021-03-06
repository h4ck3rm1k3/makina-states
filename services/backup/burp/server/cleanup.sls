{% set data = salt['mc_burp.settings']() %}
include:
  - makina-states.services.backup.burp.hooks
{% if salt['mc_controllers.mastersalt_mode']() %}
#
# cleanup the configuration directories from stale clients configuration
# data cleanup as it is backups is left to manually done by
# sysadmins. Cleaning automatically old backups can be cumbersome
# and dangerous
#
install-burp-configuration-cleanup:
  file.managed:
    - name: /etc/burp/cleanup.sh
    - mode: 0755
    - user: root
    - group: root
    - contents: |
                {{'#'}}!/usr/bin/env bash
                set -e
                to_delete=""
                managed="{% for c in data.clients%}{{c}} {%endfor%}"
                cd /etc/burp/clients
                for i in $(find -mindepth 1 -maxdepth 1 -type d|sed "s/.\///g");do
                  found=""
                  for client in ${managed};do
                    if [ "x${client}" = "x${i}" ];then
                      found="1"
                      break
                    fi
                  done
                  if [ "x${found}" = "x" ];then
                    to_delete="${i} ${to_delete}"
                  fi
                done
                for i in ${to_delete};do
                   rm -rf "$i"
                done
                cd /etc/burp/clientconfdir
                for i in $(find -mindepth 1 -maxdepth 1 -type d|sed "s/.\///g");do
                  found=""
                  for client in ${managed};do
                    if [ "x${client}" = "x${i}" ] || [ "x${i}" = "xincexc" ];then
                      found="1"
                      break
                    fi
                  done
                  if [ "x${found}" = "x" ];then
                    to_delete="${i} ${to_delete}"
                  fi
                done
                ret=0
                for i in ${to_delete};do
                  rm -rvf "$i"
                  if [ "x${?}" != "x0" ];then
                    ret=1
                  fi
                done
                exit ${ret}
  cmd.run:
    - name: /etc/burp/cleanup.sh
    - use_vt: true
    - watch:
      - mc_proxy: burp-post-restart-hook
{%endif %}
