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
spec).
*/}}

{{define "global_region"}}cluster{{end}}
{{define "global_tld"}}local{{end}}

{{- define "service_domain" -}}{{.Release.Namespace}}.svc.{{template "global_region"}}.{{template "global_tld"}}{{end}}
{{- define "service_url" -}}{{template "fullname" . }}.{{ template "service_domain" .}}{{- end -}}

{{/*
spec).
*/}}

{{- define "imagePullSecrets" -}}
{{- if .Values.imagePullSecrets -}}
imagePullSecrets:
{{- range .Values.imagePullSecrets }}
- name: {{ . -}}
{{- end -}}
{{- else if .Values.global -}}
{{- if .Values.global.imagePullSecrets -}}
imagePullSecrets:
{{- range .Values.global.imagePullSecrets }}
- name: {{ . -}}
{{- end -}}
{{- else -}}
imagePullSecrets: []
{{- end -}}
{{- else -}}
imagePullSecrets: []
{{- end -}}
{{- end -}}

{{/*
spec).
*/}}

{{- define "imagePullSecrets_json" -}}
{{- if .Values.imagePullSecrets -}}
{{- with .Values.imagePullSecrets -}}
"imagePullSecrets": [
{{ range $index, $element := . }}
    {{ if $index -}},{{- end -}}{ "name": {{ $element | quote }} }
{{- end }}
],
{{- end -}}
{{- else if .Values.global -}}
{{- if .Values.global.imagePullSecrets -}}
{{- with .Values.global.imagePullSecrets -}}
"imagePullSecrets": [
{{ range $index, $element := . }}
    {{ if $index -}},{{- end -}}{ "name": {{ $element | quote }} }
{{- end }}
],
{{- end -}}
{{- else -}}
"imagePullSecrets": [],
{{- end -}}
{{- else -}}
"imagePullSecrets": [],
{{- end -}}
{{- end -}}

