include:
  - makina-states.cloud.generic.hooks

{# drop any configured ssl cert on the compute node #}
{% set data  = salt['mc_cloud_compute_node.cn_settings']().cnSettings %}
{% set certs = [] %}
{% for cert, content in data.cn.ssl_certs %}
{% do certs.append(cert+'.crt') %}
cpt-cert-{{cert}}:
  file.managed:
    - name: /etc/ssl/cloud/certs/{{cert}}.crt
    - source: salt://makina-states/files/etc/ssl/cloud/cert.crt
    - defaults:
      data: |
            {{salt['mc_utils.json_dump'](content)}}
    - user: root
    - group: root
    - mode: 640
    - makedirs: true
    - template: jinja
    - watch:
      - mc_proxy: cloud-sslcerts-pre
    - watch_in:
      - mc_proxy: cloud-sslcerts
{% endfor %}



{% set f='/tmp/cloudcerts.py' %}
cpt-certs-cleanup:
  file.managed:
    - name: {{f}}
    - user: root
    - group: root
    - mode: 700
    - makedirs: true
    - template: jinja
    - watch:
      - mc_proxy: cloud-sslcerts-pre
    - contents: |
                #!/usr/bin/env python
                import os
                if os.path.exists('/etc/ssl/cloud/certs'):
                  os.chdir('/etc/ssl/cloud/certs')
                  certs = os.listdir('.')
                  [os.unlink(a) for a in certs if a not in {{certs}}]
                  os.unlink('{{f}}')
  cmd.run:
    - name: "{{f}}"
    - user: root
    - watch:
      - file: cpt-certs-cleanup
      - mc_proxy: cloud-sslcerts-pre
    - watch_in:
      - mc_proxy: cloud-sslcerts
