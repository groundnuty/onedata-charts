{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "name" -}}
  {{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "fullname" -}}
  {{- $name := default .Chart.Name .Values.nameOverride -}}
  {{- $suffix := default "" .Values.suffix -}}
  {{- printf "%s-%s-%s" .Release.Name $name $suffix | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Because of experimental alias requirements plugin there are issues when generating a dns name of aliased oneproviders
*/}}
{{- define "fullname-alias-bug" -}}
  {{- $name := default .Chart.Name .Values.nameOverride -}}
  {{- $suffix := default "" "" -}}
  {{- printf "%s-%s-%s" .Release.Name $name $suffix | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- define "service_url-alias-bug" -}}{{template "fullname-alias-bug" . }}.{{ template "service_namespace_domain" .}}{{- end -}}

{{/*
Logic for generating service urls
*/}}
{{define "global_region"}}{{required "A non empty region name is required!" .Values.global.region}}{{end}}
{{define "global_tld"}}{{required "A non empty top level domain name is required!" .Values.global.tld}}{{end}}
{{- define "cluster_domain" -}}{{.Release.Namespace}}.svc.{{template "global_region" .}}.{{template "global_tld" .}}{{end}}
{{- define "service_domain" -}}svc.{{template "cluster_domain" .}} {{end}}
{{- define "service_namespace_domain" -}}{{.Release.Namespace}}.svc.{{template "cluster_domain" .}} {{end}}
{{- define "service_url" -}}{{template "fullname" . }}.{{ template "service_namespace_domain" .}}{{- end -}}

{{/*
ImagePullSecrets template for yaml format
*/}}
{{- define "imagePullSecrets" -}}
  {{- if .Values.imagePullSecrets -}}
      {{- "imagePullSecrets:"  | indent 4 -}}
      {{- range .Values.imagePullSecrets }}
        {{- cat "- name:" . | indent 6 -}}
      {{- end -}}
  {{- else if .Values.global -}}
    {{- if .Values.global.imagePullSecrets -}}
        {{- "imagePullSecrets:" | indent 4 -}}
        {{- range .Values.global.imagePullSecrets }}
            {{- cat "- name:" . | indent 6 -}}
        {{- end -}}
    {{- else -}}
        {{- "imagePullSecrets: []" | indent 4 -}}
    {{- end -}}
  {{- else -}}
    {{- "imagePullSecrets: []" | indent 4 -}}
  {{- end -}}
{{- end -}}

{{/*
ImagePullSecrets template for json format
*/}}
{{- define "imagePullSecrets_json" -}}
  {{- if .Values.imagePullSecrets -}}
    {{- with .Values.imagePullSecrets -}}
      {{- "\"imagePullSecrets\": [" -}}
      {{ range $index, $element := . }}
        {{ if $index -}},{{- end -}}{ "name": {{ $element | quote }} }
      {{- end }}
      {{- "]," -}}
    {{- end -}}
  {{- else if .Values.global -}}
    {{- if .Values.global.imagePullSecrets -}}
     {{- with .Values.global.imagePullSecrets -}}
      {{- "\"imagePullSecrets\": [" -}}
      {{ range $index, $element := . }}
        {{ if $index -}},{{- end -}}{ "name": {{ $element | quote }} }
      {{- end }}
      {{- "]," -}}
     {{- end -}}
  {{- else -}}
    {{- "\"imagePullSecrets\": [" -}}
  {{- end -}}
  {{- else -}}
    {{- "\"imagePullSecrets\": [" -}}
  {{- end -}}
{{- end -}}