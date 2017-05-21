#!/usr/bin/env bash

# Ideally this method should not be needed.
# In order to deprecate it we need to know how to:
# 1) pass multiple arguments to a template.
#    this can be done using a dict structure
#    example: http://stackoverflow.com/a/18276968
# 2) evaluate a string eg. ".Value.onezone_service_url" to its value.
#    Answer yet to be found.
# With that we can create a single meta template that would be invoked:
# eg. {{ define "_service_url" dict "context"" . "service_name" "onezone" }}

FILENAME='templates/_hosts.tpl'

echo "{{/* This file is auto generated by gen_hosts.sh */}}" > $FILENAME

services=('volume-s3' 'volume-nfs' 'volume-ceph' 'oneprovider' 'onezone')
wait_fors=('volume-s3-init' 'volume-nfs' 'volume-ceph' 'oneprovider' 'onezone')

for (( i=0; i<=${#services[*]}; i++ )) ; do
service=${services[$i]}
wait_for=${wait_fors[$i]}
cat <<EOF>> $FILENAME

{{- define "${service}_wait_for" -}}
  {{- \$suffix := default "" .Values.suffix -}}
  {{- printf "%s-%s-%s" .Release.Name "${wait_for}" \$suffix | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- define "${service}_name" -}}
  {{- if .Values.${service/-/_}_service_url -}}
    {{- if eq .Values.${service/-/_}_service_url.type "auto-generate" -}}
      {{- \$suffix := default "" .Values.suffix -}}
      {{- printf "%s-%s-%s" .Release.Name "${service}" \$suffix | trunc 63 | trimSuffix "-" -}}
    {{- else if eq .Values.${service/-/_}_service_url.type "k8s-service" -}}
      {{- if .Values.${service/-/_}_service_url.namespace -}}
        {{/* TODO */}}
      {{- else -}}
        {{ .Values.${service/-/_}_service_url.service_name }}
      {{- end -}}
    {{- else if eq .Values.${service/-/_}_service_url.type "http" -}}
      {{/* TODO */}}
    {{- end -}}
  {{- else -}}
    {{- \$suffix := default "" .Values.suffix -}}
    {{- printf "%s-%s-%s" .Release.Name "${service}" \$suffix | trunc 63 | trimSuffix "-" -}}
  {{- end -}}
{{- end -}}

{{- define "${service}_service_url" -}}
  {{- if .Values.${service/-/_}_service_url -}}
    {{- if eq .Values.${service/-/_}_service_url.type "auto-generate" -}}
        {{ template "${service}_name" . }}.{{template "service_namespace_domain" . }}
    {{- else if eq .Values.${service/-/_}_service_url.type "k8s-service" -}}
      {{- if .Values.${service/-/_}_service_url.namespace -}}
        {{ .Values.${service/-/_}_service_url.service_name }}.{{ .Values.${service/-/_}_service_url.namespace }}.{{template "service_domain" . }}
      {{- else -}}
        {{ .Values.${service/-/_}_service_url.service_name }}.{{template "service_namespace_domain" .}}
      {{- end -}}
    {{- else if eq .Values.${service/-/_}_service_url.type "http" -}}
      {{ .Values.${service/-/_}_service_url.address }}
    {{- else -}}
      {{ template "${service}_name" . }}.{{template "service_namespace_domain" . }}
    {{- end -}}
  {{- else -}}
      {{ template "${service}_name" . }}.{{template "service_namespace_domain" . }}
  {{- end -}}
{{- end -}}
EOF

done
