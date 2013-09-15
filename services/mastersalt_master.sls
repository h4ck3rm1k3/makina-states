# As described in wiki each server has a local master
# but can also be controlled via the mastersalt via the syndic interface.
# We have the local master in /etc/salt
# We have the running syndic/master/minion in /etc/salt
# and on mastersalt, we have another master daemon configured in /etc/mastersalt

include:
  - makina-states.services.salt

mastersalt-master:
  file.managed:
    - name: /etc/init/mastersalt-master.conf
    - source: salt://makina-states/files/etc/init/mastersalt.conf
  service.running:
    - require:
      - file: salt-profile
    - enable: True
    - watch:
       - file: mastersalt-master
       - file: mastersalt-conf
  grains.present:
    - value: True
    - require:
      - service: mastersalt-master

mastersalt-conf:
  file.managed:
    - name: /etc/mastersalt/master
    - template: jinja
    - source: salt://makina-states/files/etc/mastersalt/master

mastersalt-key-bin:
  file.managed:
    - name: /usr/bin/mastersalt-key
    - source: salt://makina-states/files/usr/bin/mastersalt-key
    - mode: 755
    - makedirs: True

mastersalt-cache:
  file.directory:
    - name: /var/cache/mastersalt/master
    - mode: 700
    - makedirs: True

mastersalt-sock:
  file.directory:
    - name: /var/run/salt/mastersalt
    - mode: 700
    - makedirs: True

mastersalt-pki:
  file.directory:
    - name: /etc/mastersalt/pki/master
    - mode: 700
    - makedirs: True

mastersalt-master-logs:
  file.managed:
    - names:
      - /var/log/salt/key-mastersalt
      - /var/log/salt/mastersalt
    - mode: 700
  require:
    - service: mastersalt-master

