{{/* vim: set filetype=mustache: */}}
{{/*
Datadog env variables
*/}}
{{- define "common.datadog.envs" -}}
{{- if .datadog.apm.enabled }}
# Put pod envs here
{{- end }}
{{- end -}}