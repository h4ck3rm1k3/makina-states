#
# Boostrap an host an also install a mastersalt wired minion
#
#
# Basic bootstrap is responsible for the setup of saltstack
# Be sure to double check any dependant state there to work if there is
# nothing yet on the VM as it is a "bootstrap stage".
#

include:
  - makina-states.services.bootstrap_server
  - makina-states.services.mastersalt

bootstrap:makina-states-mastersalt:
  grains.present:
    - value: True
    - require:
      - service: mastersalt-minion
