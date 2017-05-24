{{/* This file is auto generated by gen_hosts.sh */}}

{{- define "volume-s3_wait_for" -}}
  {{- $suffix := default "" .Values.suffix -}}
  {{- printf "%s-%s-%s" .Release.Name "volume-s3-init" $suffix | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "volume-s3_name" -}}
  {{- if .Values.volume_s3_service_url -}}
    {{- if eq .Values.volume_s3_service_url.type "auto-generate" -}}
      {{- if .Values.volume_s3_service_url.disableSuffix -}}
        {{- $suffix :=  "" | toString -}}
        {{- printf "%s-%s-%s" .Release.Name "volume-s3" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" .Release.Name "volume-s3" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- end -}}
    {{- else if eq .Values.volume_s3_service_url.type "k8s-service" -}}
      {{- if .Values.volume_s3_service_url.namespace -}}
        {{/* TODO */}}
      {{- else -}}
        {{ .Values.volume_s3_service_url.service_name }}
      {{- end -}}
    {{- else if eq .Values.volume_s3_service_url.type "http" -}}
      {{/* TODO */}}
    {{- end -}}
  {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" .Release.Name "volume-s3" $suffix | trunc 63 | trimSuffix "-" -}}
  {{- end -}}
{{- end -}}

{{- define "volume-s3_service_url" -}}
  {{- if .Values.volume_s3_service_url -}}
    {{- if eq .Values.volume_s3_service_url.type "auto-generate" -}}
        {{ template "volume-s3_name" . }}.{{template "service_namespace_domain" . }}
    {{- else if eq .Values.volume_s3_service_url.type "k8s-service" -}}
      {{- if .Values.volume_s3_service_url.namespace -}}
        {{ .Values.volume_s3_service_url.service_name }}.{{ .Values.volume_s3_service_url.namespace }}.{{template "service_domain" . }}
      {{- else -}}
        {{ .Values.volume_s3_service_url.service_name }}.{{template "service_namespace_domain" .}}
      {{- end -}}
    {{- else if eq .Values.volume_s3_service_url.type "http" -}}
      {{ .Values.volume_s3_service_url.address }}
    {{- else -}}
      {{ template "volume-s3_name" . }}.{{template "service_namespace_domain" . }}
    {{- end -}}
  {{- else -}}
      {{ template "volume-s3_name" . }}.{{template "service_namespace_domain" . }}
  {{- end -}}
{{- end -}}

{{- define "volume-nfs_wait_for" -}}
  {{- $suffix := default "" .Values.suffix -}}
  {{- printf "%s-%s-%s" .Release.Name "volume-nfs" $suffix | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "volume-nfs_name" -}}
  {{- if .Values.volume_nfs_service_url -}}
    {{- if eq .Values.volume_nfs_service_url.type "auto-generate" -}}
      {{- if .Values.volume_nfs_service_url.disableSuffix -}}
        {{- $suffix :=  "" | toString -}}
        {{- printf "%s-%s-%s" .Release.Name "volume-nfs" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" .Release.Name "volume-nfs" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- end -}}
    {{- else if eq .Values.volume_nfs_service_url.type "k8s-service" -}}
      {{- if .Values.volume_nfs_service_url.namespace -}}
        {{/* TODO */}}
      {{- else -}}
        {{ .Values.volume_nfs_service_url.service_name }}
      {{- end -}}
    {{- else if eq .Values.volume_nfs_service_url.type "http" -}}
      {{/* TODO */}}
    {{- end -}}
  {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" .Release.Name "volume-nfs" $suffix | trunc 63 | trimSuffix "-" -}}
  {{- end -}}
{{- end -}}

{{- define "volume-nfs_service_url" -}}
  {{- if .Values.volume_nfs_service_url -}}
    {{- if eq .Values.volume_nfs_service_url.type "auto-generate" -}}
        {{ template "volume-nfs_name" . }}.{{template "service_namespace_domain" . }}
    {{- else if eq .Values.volume_nfs_service_url.type "k8s-service" -}}
      {{- if .Values.volume_nfs_service_url.namespace -}}
        {{ .Values.volume_nfs_service_url.service_name }}.{{ .Values.volume_nfs_service_url.namespace }}.{{template "service_domain" . }}
      {{- else -}}
        {{ .Values.volume_nfs_service_url.service_name }}.{{template "service_namespace_domain" .}}
      {{- end -}}
    {{- else if eq .Values.volume_nfs_service_url.type "http" -}}
      {{ .Values.volume_nfs_service_url.address }}
    {{- else -}}
      {{ template "volume-nfs_name" . }}.{{template "service_namespace_domain" . }}
    {{- end -}}
  {{- else -}}
      {{ template "volume-nfs_name" . }}.{{template "service_namespace_domain" . }}
  {{- end -}}
{{- end -}}

{{- define "volume-ceph_wait_for" -}}
  {{- $suffix := default "" .Values.suffix -}}
  {{- printf "%s-%s-%s" .Release.Name "volume-ceph" $suffix | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "volume-ceph_name" -}}
  {{- if .Values.volume_ceph_service_url -}}
    {{- if eq .Values.volume_ceph_service_url.type "auto-generate" -}}
      {{- if .Values.volume_ceph_service_url.disableSuffix -}}
        {{- $suffix :=  "" | toString -}}
        {{- printf "%s-%s-%s" .Release.Name "volume-ceph" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" .Release.Name "volume-ceph" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- end -}}
    {{- else if eq .Values.volume_ceph_service_url.type "k8s-service" -}}
      {{- if .Values.volume_ceph_service_url.namespace -}}
        {{/* TODO */}}
      {{- else -}}
        {{ .Values.volume_ceph_service_url.service_name }}
      {{- end -}}
    {{- else if eq .Values.volume_ceph_service_url.type "http" -}}
      {{/* TODO */}}
    {{- end -}}
  {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" .Release.Name "volume-ceph" $suffix | trunc 63 | trimSuffix "-" -}}
  {{- end -}}
{{- end -}}

{{- define "volume-ceph_service_url" -}}
  {{- if .Values.volume_ceph_service_url -}}
    {{- if eq .Values.volume_ceph_service_url.type "auto-generate" -}}
        {{ template "volume-ceph_name" . }}.{{template "service_namespace_domain" . }}
    {{- else if eq .Values.volume_ceph_service_url.type "k8s-service" -}}
      {{- if .Values.volume_ceph_service_url.namespace -}}
        {{ .Values.volume_ceph_service_url.service_name }}.{{ .Values.volume_ceph_service_url.namespace }}.{{template "service_domain" . }}
      {{- else -}}
        {{ .Values.volume_ceph_service_url.service_name }}.{{template "service_namespace_domain" .}}
      {{- end -}}
    {{- else if eq .Values.volume_ceph_service_url.type "http" -}}
      {{ .Values.volume_ceph_service_url.address }}
    {{- else -}}
      {{ template "volume-ceph_name" . }}.{{template "service_namespace_domain" . }}
    {{- end -}}
  {{- else -}}
      {{ template "volume-ceph_name" . }}.{{template "service_namespace_domain" . }}
  {{- end -}}
{{- end -}}

{{- define "oneprovider_wait_for" -}}
  {{- $suffix := default "" .Values.suffix -}}
  {{- printf "%s-%s-%s" .Release.Name "oneprovider" $suffix | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "oneprovider_name" -}}
  {{- if .Values.oneprovider_service_url -}}
    {{- if eq .Values.oneprovider_service_url.type "auto-generate" -}}
      {{- if .Values.oneprovider_service_url.disableSuffix -}}
        {{- $suffix :=  "" | toString -}}
        {{- printf "%s-%s-%s" .Release.Name "oneprovider" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" .Release.Name "oneprovider" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- end -}}
    {{- else if eq .Values.oneprovider_service_url.type "k8s-service" -}}
      {{- if .Values.oneprovider_service_url.namespace -}}
        {{/* TODO */}}
      {{- else -}}
        {{ .Values.oneprovider_service_url.service_name }}
      {{- end -}}
    {{- else if eq .Values.oneprovider_service_url.type "http" -}}
      {{/* TODO */}}
    {{- end -}}
  {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" .Release.Name "oneprovider" $suffix | trunc 63 | trimSuffix "-" -}}
  {{- end -}}
{{- end -}}

{{- define "oneprovider_service_url" -}}
  {{- if .Values.oneprovider_service_url -}}
    {{- if eq .Values.oneprovider_service_url.type "auto-generate" -}}
        {{ template "oneprovider_name" . }}.{{template "service_namespace_domain" . }}
    {{- else if eq .Values.oneprovider_service_url.type "k8s-service" -}}
      {{- if .Values.oneprovider_service_url.namespace -}}
        {{ .Values.oneprovider_service_url.service_name }}.{{ .Values.oneprovider_service_url.namespace }}.{{template "service_domain" . }}
      {{- else -}}
        {{ .Values.oneprovider_service_url.service_name }}.{{template "service_namespace_domain" .}}
      {{- end -}}
    {{- else if eq .Values.oneprovider_service_url.type "http" -}}
      {{ .Values.oneprovider_service_url.address }}
    {{- else -}}
      {{ template "oneprovider_name" . }}.{{template "service_namespace_domain" . }}
    {{- end -}}
  {{- else -}}
      {{ template "oneprovider_name" . }}.{{template "service_namespace_domain" . }}
  {{- end -}}
{{- end -}}

{{- define "onezone_wait_for" -}}
  {{- $suffix := default "" .Values.suffix -}}
  {{- printf "%s-%s-%s" .Release.Name "onezone" $suffix | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "onezone_name" -}}
  {{- if .Values.onezone_service_url -}}
    {{- if eq .Values.onezone_service_url.type "auto-generate" -}}
      {{- if .Values.onezone_service_url.disableSuffix -}}
        {{- $suffix :=  "" | toString -}}
        {{- printf "%s-%s-%s" .Release.Name "onezone" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" .Release.Name "onezone" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- end -}}
    {{- else if eq .Values.onezone_service_url.type "k8s-service" -}}
      {{- if .Values.onezone_service_url.namespace -}}
        {{/* TODO */}}
      {{- else -}}
        {{ .Values.onezone_service_url.service_name }}
      {{- end -}}
    {{- else if eq .Values.onezone_service_url.type "http" -}}
      {{/* TODO */}}
    {{- end -}}
  {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" .Release.Name "onezone" $suffix | trunc 63 | trimSuffix "-" -}}
  {{- end -}}
{{- end -}}

{{- define "onezone_service_url" -}}
  {{- if .Values.onezone_service_url -}}
    {{- if eq .Values.onezone_service_url.type "auto-generate" -}}
        {{ template "onezone_name" . }}.{{template "service_namespace_domain" . }}
    {{- else if eq .Values.onezone_service_url.type "k8s-service" -}}
      {{- if .Values.onezone_service_url.namespace -}}
        {{ .Values.onezone_service_url.service_name }}.{{ .Values.onezone_service_url.namespace }}.{{template "service_domain" . }}
      {{- else -}}
        {{ .Values.onezone_service_url.service_name }}.{{template "service_namespace_domain" .}}
      {{- end -}}
    {{- else if eq .Values.onezone_service_url.type "http" -}}
      {{ .Values.onezone_service_url.address }}
    {{- else -}}
      {{ template "onezone_name" . }}.{{template "service_namespace_domain" . }}
    {{- end -}}
  {{- else -}}
      {{ template "onezone_name" . }}.{{template "service_namespace_domain" . }}
  {{- end -}}
{{- end -}}

{{- define "_wait_for" -}}
  {{- $suffix := default "" .Values.suffix -}}
  {{- printf "%s-%s-%s" .Release.Name "" $suffix | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "_name" -}}
  {{- if .Values._service_url -}}
    {{- if eq .Values._service_url.type "auto-generate" -}}
      {{- if .Values._service_url.disableSuffix -}}
        {{- $suffix :=  "" | toString -}}
        {{- printf "%s-%s-%s" .Release.Name "" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" .Release.Name "" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- end -}}
    {{- else if eq .Values._service_url.type "k8s-service" -}}
      {{- if .Values._service_url.namespace -}}
        {{/* TODO */}}
      {{- else -}}
        {{ .Values._service_url.service_name }}
      {{- end -}}
    {{- else if eq .Values._service_url.type "http" -}}
      {{/* TODO */}}
    {{- end -}}
  {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" .Release.Name "" $suffix | trunc 63 | trimSuffix "-" -}}
  {{- end -}}
{{- end -}}

{{- define "_service_url" -}}
  {{- if .Values._service_url -}}
    {{- if eq .Values._service_url.type "auto-generate" -}}
        {{ template "_name" . }}.{{template "service_namespace_domain" . }}
    {{- else if eq .Values._service_url.type "k8s-service" -}}
      {{- if .Values._service_url.namespace -}}
        {{ .Values._service_url.service_name }}.{{ .Values._service_url.namespace }}.{{template "service_domain" . }}
      {{- else -}}
        {{ .Values._service_url.service_name }}.{{template "service_namespace_domain" .}}
      {{- end -}}
    {{- else if eq .Values._service_url.type "http" -}}
      {{ .Values._service_url.address }}
    {{- else -}}
      {{ template "_name" . }}.{{template "service_namespace_domain" . }}
    {{- end -}}
  {{- else -}}
      {{ template "_name" . }}.{{template "service_namespace_domain" . }}
  {{- end -}}
{{- end -}}
