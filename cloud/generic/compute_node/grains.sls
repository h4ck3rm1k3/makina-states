run-grains:
  mc_registry.update:
    - name: cloud
    - params:
        compute_node.has.firewall: true
        is.compute_node: true
run-grains-b:
  mc_registry.update:
    - name: services
    - params:
        proxy.haproxy: true
        firewall.shorewall: true
