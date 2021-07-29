{{/* vim: set filetype=mustache: */}}
{{/*
Datadog env variables
*/}}
{{- define "common.datadog.envs" -}}
{{- if .value.apm.enabled }}
# Put pod envs here
{{- end }}
{{- end -}}

{{/* vim: set filetype=mustache: */}}
{{/*
Datadog annotations
*/}}
{{- define "common.datadog.annotations" -}}
{{- if .value.openmetrics.enabled }}
{{- $prometheus_url := printf "%s://%s:%d%s" .value.openmetrics.schema .value.openmetrics.host (.value.openmetrics.port | int) .value.openmetrics.endpoint -}}
{{- $instance := dict "prometheus_url" $prometheus_url "namespace" .context.Release.Namespace "metrics" .value.openmetrics.metrics "type_overrides" .value.openmetrics.type_overrides -}}
ad.datadoghq.com/{{ include "common.names.fullname" .context }}.check_names: '["openmetrics"]'
ad.datadoghq.com/{{ include "common.names.fullname" .context }}.init_configs: "[{}]"
ad.datadoghq.com/{{ include "common.names.fullname" .context }}.instances: {{ list $instance | toJson | quote}}
{{- end }}
{{- end -}}
