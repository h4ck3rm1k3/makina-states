{# dummmies states for lxc #}
{%- import "makina-states/_macros/services.jinja" as services with context %}
{{ services.funcs.dummy('docker-post-inst') }}
