{{/* vim: set filetype=mustache: */}}
{{/*
Kubernetes standard labels
*/}}
{{- define "common.labels.standard" -}}
app.kubernetes.io/name: {{ include "common.names.name" . }}
helm.sh/chart: {{ include "common.names.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
# Ndustrial labels
ndustrial.io/app: {{ .Values.ndustrial.name }}
ndustrial.io/organization.slug: {{ .Values.ndustrial.organization }}
ndustrial.io/owner: {{ .Values.ndustrial.owner }}
ndustrial.io/env: {{ .Values.ndustrial.env }}
ndustrial.io/version: {{ .Values.ndustrial.version }}
ndustrial.io/repo: {{ .Values.ndustrial.repo }}
ndustrial.io/project.slug: {{ .Values.ndustrial.project.slug }}
ndustrial.io/project.type: {{ .Values.ndustrial.project.type }}
# Datadog labels
tags.datadoghq.com/env: {{ .Values.ndustrial.env }}
tags.datadoghq.com/version: {{ .Values.ndustrial.version }}
tags.datadoghq.com/service: {{ .Values.ndustrial.name }}
{{- if .Values.contxt.projectId -}}
contxt/project.id: {{ .Values.contxt.projectId }}
contxt/service.id: {{ .Values.contxt.serviceId }}
contxt/service.type: {{ .Values.contxt.serviceType }}
{{- end -}}
{{- end -}}

{{/*
Labels to use on deploy.spec.selector.matchLabels and svc.spec.selector
*/}}
{{- define "common.labels.matchLabels" -}}
app.kubernetes.io/name: {{ include "common.names.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
