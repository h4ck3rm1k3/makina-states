{{ salt['mc_macros.register']('services', 'proxy.haproxy') }}
include:
  - makina-states.services.proxy.haproxy.prerequisites
  - makina-states.services.proxy.haproxy.configuration
  - makina-states.services.proxy.haproxy.service
