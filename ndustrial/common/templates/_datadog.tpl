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
ad.datadoghq.com/pulsar-nonprod-broker.check_names: '["openmetrics"]'
ad.datadoghq.com/pulsar-nonprod-broker.init_configs: "[{}]"
ad.datadoghq.com/pulsar-nonprod-broker.instances: |
  [{
    "prometheus_url": "{{- .value.openmetrics.schema -}}://{{- .value.openmetrics.host -}}:{{- .value.openmetrics.port -}}{{- .value.openmetrics.endpoint -}}",
    "namespace": "{{- .context.Release.Namespace -}}",
    "metrics": {{ .value.openmetrics.metrics | toJson }},
    "type_overrides": {{ .value.openmetrics.type_overrides | toJson }}
  }]
{{- end }}
{{- end -}}

