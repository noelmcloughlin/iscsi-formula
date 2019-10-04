# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_clean = tplroot ~ '.isns.package.clean' %}
{%- from tplroot ~ "/map.jinja" import iscsi with context %}

include:
  - {{ sls_package_clean }}

iscsi-isns-config-clean-file-absent:
  file.absent:
    - name: {{ iscsi.config.name[iscsi.isns.provider] }}
    - watch_in:
        - sls: {{ sls_package_clean }}

    {%- if 'isnsadm' in iscsi.config.name and iscsi.config.name['isnsadm'] %}
iscsi-isns-config-clean-file-absent-isnsadm:
  file.absent:
    - name: {{ iscsi.config.name['isnsadm'] }}
    {%- endif %}

    {%- if 'isnsdd' in iscsi.config.name and iscsi.config.name['isnsdd'] %}
iscsi-isns-config-clean-file-absent-isnsdd:
  file.absent:
    - name: {{ iscsi.config.name['isnsdd'] }}
    {%- endif %}
