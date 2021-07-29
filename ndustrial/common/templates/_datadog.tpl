{{/* vim: set filetype=mustache: */}}
{{/*
Datadog env variables
*/}}
{{- define "common.datadog.envs" -}}
{{- if .value.apm.enabled }}
{{- if .Values.datadog.apm.trace_agent_hostname }}
- name: DATADOG_TRACE_AGENT_HOSTNAME
  value: {{ .Values.datadog.apm.trace_agent_hostname }}
{{- else }}
- name: DATADOG_TRACE_AGENT_HOSTNAME
  valueFrom:
    fieldRef:
      fieldPath: status.hostIP
{{- end }}
- name: DATADOG_TRACE_AGENT_HOSTNAME
  valueFrom:
    fieldRef:
      fieldPath: status.hostIP
- name: NODE_ENV
  value: {{ .Values.datadog.apm.node_env }}
- name: DD_AGENT_HOST
  value: {{ .Values.datadog.apm.agent_host }}
- name: DD_ENV
  value: {{ .Values.datadog.apm.env }}
- name: DD_VERSION
  value: {{ .Values.datadog.apm.version }}
- name: DD_PROFILING_ENABLED
  value: {{ .Values.datadog.apm.profiling_enabled }}
- name: DD_LOGS_INJECTION
  value: {{ .Values.datadog.apm.logs_injection }}
- name: DD_TRACE_SAMPLE_RATE
  value: {{ .Values.datadog.apm.trace_sample_rate }}
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
