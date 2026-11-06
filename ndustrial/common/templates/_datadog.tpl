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
  value: {{ .value.apm.version | toString | quote }}
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
Datadog OpenMetrics scrape annotations (the agent's legacy openmetrics check).

Datadog only keeps the metrics listed in `metrics` and `extra_metrics`, and every
series it keeps is a billed custom metric. Anything not listed is still served on
the pod's metrics endpoint for debugging. Histogram buckets are off by default,
because each bucket is its own series (about 15x per histogram).

Usage:
  {{ include "nio-common.datadog.annotations" (dict "value" .Values.datadog "context" $) }}
*/}}
{{- define "nio-common.datadog.annotations" -}}
{{- $om := .value.openmetrics -}}
{{- if and $om (hasKey $om "enabled") $om.enabled -}}
{{- $metrics := concat (default (list) $om.metrics) (default (list) $om.extra_metrics) | uniq -}}
{{- if empty $metrics -}}
{{- fail "datadog.openmetrics.enabled is true but datadog.openmetrics.metrics is empty. List the metrics to collect; the openmetrics check collects nothing without them." -}}
{{- end -}}
{{- /* The annotation key must match the container name, or the agent ignores it */ -}}
{{- $container := default (include "nio-common.names.name" .context) $om.container -}}
{{- $prometheusUrl := printf "%s://%s:%d%s" (default "http" $om.schema) (default "%%host%%" $om.host) ((default 8080 $om.port) | int) (default "/metrics" $om.endpoint) -}}
{{- $buckets := false -}}
{{- if hasKey $om "send_histograms_buckets" -}}
{{- $buckets = $om.send_histograms_buckets -}}
{{- end -}}
{{- $ignore := list "*_created" -}}
{{- if hasKey $om "ignore_metrics" -}}
{{- $ignore = default (list) $om.ignore_metrics -}}
{{- end -}}
{{- $instance := dict "prometheus_url" $prometheusUrl "namespace" (default .context.Release.Namespace $om.namespace) "metrics" $metrics "send_histograms_buckets" $buckets "send_monotonic_counter" true "send_distribution_buckets" false "send_distribution_counts_as_monotonic" true "send_distribution_sums_as_monotonic" true -}}
{{- if $ignore -}}
{{- $_ := set $instance "ignore_metrics" $ignore -}}
{{- end -}}
{{- if $om.exclude_labels -}}
{{- $_ := set $instance "exclude_labels" $om.exclude_labels -}}
{{- end -}}
{{- if $om.type_overrides -}}
{{- $_ := set $instance "type_overrides" $om.type_overrides -}}
{{- end -}}
{{- if $om.tags -}}
{{- $tags := list -}}
{{- range $om.tags -}}
{{- $tags = append $tags (tpl (toString .) $.context) -}}
{{- end -}}
{{- $_ := set $instance "tags" $tags -}}
{{- end -}}
{{- if $om.options -}}
{{- $instance = mergeOverwrite $instance $om.options -}}
{{- end -}}
ad.datadoghq.com/{{ $container }}.check_names: '["openmetrics"]'
ad.datadoghq.com/{{ $container }}.init_configs: "[{}]"
ad.datadoghq.com/{{ $container }}.instances: {{ list $instance | toJson | quote }}
{{- end -}}
{{- end -}}
