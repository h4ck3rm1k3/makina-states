{% set data = salt['mc_burp.settings']() %}
include:
  - makina-states.services.backup.burp.hooks
{% if salt['mc_controllers.mastersalt_mode']() %}
install-burp-configuration-sync:
  file.managed:
    - name: /etc/burp/clients/sync.py
    - mode: 0755
    - user: root
    - group: root
    - contents: |
                #!/usr/bin/env python
                import subprocess
                import sys
                import os
                import time
                ret = 0
                timeout = 60 * 2
                batch = 20
                done = {}
                clients = [{% for client in data['clients'] %}    "{{client}}",
                           {%endfor%}]
                def async_backup(cmd):
                  print "lauching in background: {0}".format(cmd)
                  process = subprocess.Popen(cmd,
                                             shell=True,
                                             stdout=subprocess.PIPE,
                                             stderr=subprocess.PIPE)
                  return process
                todo = []
                # init & launch
                for i in clients:
                  if os.path.isdir("{{data.server_conf.directory}}/"+i):
                    if not os.path.exists("{{data.server_conf.directory}}/"+i):
                      os.makedirs("{{data.server_conf.directory}}/"+i)
                    with open("{{data.server_conf.directory}}/{0}/backup".format(i), 'w') as fic:
                      fic.write('\n')
                    todo.append("/etc/burp/clients/{0}/sync.sh".format(i))
                # poll per 10
                now = time.time()
                will_timeout = now + timeout
                def check_timeout(t=None):
                  if not t:
                    t = time.time()
                  if t >= will_timeout:
                    raise ValueError('Timeout !')
                while todo:
                  check_timeout()
                  doing = []
                  for i in range(batch):
                    try:
                      doing.append(todo.pop())
                    except:
                      pass
                  if not doing:
                    todo = False
                  else:
                    syncs = {}
                    for cmd in doing:
                      syncs[cmd] = async_backup(cmd)
                    while syncs:
                      check_timeout()
                      for cmd in [a for a in syncs]:
                        if syncs[cmd].poll() is not None:
                          done[cmd] = syncs.pop(cmd)
                for a, p in done.items():
                  if p.returncode:
                    print "Missed {0} (1)".format(a, p.returncode)
                    print p.stdout.read()
                    print p.stderr.read()
                    ret = 1
                sys.exit(ret)
  cmd.run:
    - name: /etc/burp/clients/sync.py
    - use_vt: true
    - watch:
      - file: install-burp-configuration-sync
      - mc_proxy: burp-post-gen-sync
    - watch_in:
      - mc_proxy: burp-post-sync
{%endif %}
