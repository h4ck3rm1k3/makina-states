include:
  - makina-states.localsettings.network

shorewall-preinstall:
  mc_proxy.hook:
    - watch:
      - mc_proxy: network-last-hook
    - watch_in:
      - mc_proxy: shorewall-preconf
      - mc_proxy: shorewall-postconf
      - mc_proxy: shorewall-postinstall
      - mc_proxy: shorewall-prerestart
      - mc_proxy: shorewall-activation
shorewall-postinstall:
  mc_proxy.hook:
      - mc_proxy: shorewall-preconf
      - mc_proxy: shorewall-postconf
      - mc_proxy: shorewall-activation
      - mc_proxy: shorewall-prerestart
shorewall-preconf:
  mc_proxy.hook:
    - watch_in:
      - mc_proxy: shorewall-postconf
      - mc_proxy: shorewall-prerestart
      - mc_proxy: shorewall-activation
shorewall-postconf:
  mc_proxy.hook:
    - watch_in:
      - mc_proxy: shorewall-activation
      - mc_proxy: shorewall-prerestart
shorewall-activation:
  mc_proxy.hook:
    - watch_in:
      - mc_proxy: shorewall-prerestart
      - mc_proxy: shorewall-postrestart
shorewall-prerestart:
  mc_proxy.hook:
    - watch_in:
      - mc_proxy: shorewall-postrestart
shorewall-postrestart:
  mc_proxy.hook: []
