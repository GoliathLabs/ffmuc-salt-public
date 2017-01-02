#
# Linux Kernel
#

{% set node_config = salt['pillar.get']('nodes:' ~ grains['id'], {}) %}
{% set version_fallback = "4.8.0-0.bpo.2-amd64" %}
{% set version_global = salt['pillar.get']('ffho:kernel_version', version_fallback) %}
{% set version = node_config.get('kernel_version', version_global) %}

linux-kernel:
  pkg.installed:
    - name: linux-image-{{ version }}
    - fromrepo: jessie-backports

{#
 # Install kernel headers if we might need to compile a batman_adv module on this node.
 #}
{% if 'batman' in node_config.get('roles', []) %}
linux-headers:
  pkg.installed:
    - name: linux-headers-{{ version }}
    - fromrepo: jessie-backports
{% endif %}
