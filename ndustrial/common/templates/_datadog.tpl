{{/* vim: set filetype=mustache: */}}
{{/*
Datadog env variables
*/}}
{{- define "nio-common.datadog.envs" -}}
{{- if .value.apm }}
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
{{- if .value.apm.agent_host }}
- name: DD_AGENT_HOST
  value: {{ .value.apm.agent_host }}
{{- else }}
- name: DD_AGENT_HOST
  valueFrom:
    fieldRef:
      fieldPath: status.hostIP
{{- end }}
{{- if .value.apm.env }}
- name: DD_ENV
  value: {{ .value.apm.env }}
{{- else }}
- name: DD_ENV
  valueFrom:
    fieldRef:
      fieldPath: metadata.labels['tags.datadoghq.com/env']
{{- end }}
{{- if .value.apm.service }}
- name: DD_SERVICE
  value: {{ .value.apm.service }}
{{- else }}
- name: DD_SERVICE
  valueFrom:
    fieldRef:
      fieldPath: metadata.labels['tags.datadoghq.com/service']
{{- end }}
{{- if .value.apm.version }}
- name: DD_VERSION
  value: {{ .value.apm.version }}
{{- else }}
- name: DD_VERSION
  valueFrom:
    fieldRef:
      fieldPath: metadata.labels['tags.datadoghq.com/version']
{{- end }}
- name: DD_PROFILING_ENABLED
  value: {{ (default "false" .value.apm.profiling_enabled) | toString | quote }}
- name: DD_LOGS_INJECTION
  value: {{ (default "true" .value.apm.logs_injection) | toString | quote }}
- name: DD_TRACE_SAMPLE_RATE
  value: {{ (default "1.0" .value.apm.trace_sample_rate) | toString | quote }}
{{- end }}
{{- end }}
{{- end -}}

{{/* vim: set filetype=mustache: */}}
{{/*
Datadog annotations
*/}}
{{- define "nio-common.datadog.annotations" -}}
{{- if .value.openmetrics }}
{{- if and (hasKey .value.openmetrics "enabled") (.value.openmetrics.enabled) -}}
{{- $prometheus_url := printf "%s://%s:%d%s" (default "http" .value.openmetrics.schema) (default "%%host%%" .value.openmetrics.host) ((default 8080 .value.openmetrics.port) | int) (default "/metrics" .value.openmetrics.endpoint) -}}
{{- $instance := dict "prometheus_url" $prometheus_url "namespace" .context.Release.Namespace "metrics" .value.openmetrics.metrics "type_overrides" .value.openmetrics.type_overrides -}}
ad.datadoghq.com/{{ include "nio-common.names.fullname" .context }}.check_names: '["openmetrics"]'
ad.datadoghq.com/{{ include "nio-common.names.fullname" .context }}.init_configs: "[{}]"
ad.datadoghq.com/{{ include "nio-common.names.fullname" .context }}.instances: {{ list $instance | toJson | quote}}
{{- end }}
{{- end }}
{{- end -}}
