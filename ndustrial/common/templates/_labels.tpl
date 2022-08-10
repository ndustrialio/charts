{{/* vim: set filetype=mustache: */}}
{{/*
Kubernetes standard labels
*/}}
{{- define "nio-common.labels.standard" -}}
app.kubernetes.io/name: {{ include "nio-common.names.name" . }}
helm.sh/chart: {{ include "nio-common.names.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{/*
# Ndustrial labels
*/}}
{{- if .Values.ndustrial -}}
{{- with .Values.ndustrial -}}
ndustrial.io/app: {{ .name }}
backstage.io/kubernetes-id: {{ .name }}
ndustrial.io/organization.slug: {{ .organization }}
ndustrial.io/owner: {{ .owner }}
ndustrial.io/project.slug: {{ .project }}
ndustrial.io/project.type: {{ .type }}
ndustrial.io/version: {{ .version }}
{{- if .managed_by }}
ndustrial.io/managed-by: {{ .managed_by }}
{{- end -}}
{{- if .env }}
ndustrial.io/env: {{ .env }}
{{- end -}}
{{- if .repo }}
ndustrial.io/repo: {{ .repo }}
{{- end -}}
{{/*
# Datadog labels
*/}}
tags.datadoghq.com/env: {{ .env }}
tags.datadoghq.com/version: {{ .version }}
tags.datadoghq.com/service: {{ .name }}
{{- end -}}
{{- end -}}
{{/*
# Contxt labels
*/}}
{{- if .Values.contxt -}}
{{- with .Values.contxt -}}
{{- if .projectId }}
contxt/project.id: {{ .projectId | quote }}
contxt/service.id: {{ .serviceId | quote }}
{{- if .serviceType -}}
contxt/service.type: {{ .serviceType }}
{{- end -}}
{{- end -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Labels to use on deploy.spec.selector.matchLabels and svc.spec.selector
*/}}
{{- define "nio-common.labels.matchLabels" -}}
app.kubernetes.io/name: {{ include "nio-common.names.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
