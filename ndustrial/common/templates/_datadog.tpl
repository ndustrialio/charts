{{/* vim: set filetype=mustache: */}}
{{/*
Datadog env variables
*/}}
{{- define "common.datadog.envs" -}}
{{- if .value.apm.enabled }}
{{- if .value.apm.trace_agent_host }}
- name: DATADOG_TRACE_AGENT_HOSTNAME
  value: {{ .value.apm.trace_agent_host }}
{{- else }}
- name: DATADOG_TRACE_AGENT_HOSTNAME
  valueFrom:
    fieldRef:
      fieldPath: status.hostIP
{{- end }}
- name: NODE_ENV
  value: {{ .value.apm.node_env }}
{{- if .value.apm.agent_host }}
- name: DD_AGENT_HOST
  value: {{ .value.apm.agent_host }}
{{- else }}
- name: DD_AGENT_HOST
  valueFrom:
    fieldRef:
      fieldPath: status.hostIP
{{- end }}
- name: DD_ENV
  value: {{ .value.apm.env }}
- name: DD_VERSION
  value: {{ .value.apm.version }}
- name: DD_PROFILING_ENABLED
  value: {{ .value.apm.profiling_enabled | toString | quote }}
- name: DD_LOGS_INJECTION
  value: {{ .value.apm.logs_injection | toString | quote }}
- name: DD_TRACE_SAMPLE_RATE
  value: {{ .value.apm.trace_sample_rate | toString | quote }}
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

