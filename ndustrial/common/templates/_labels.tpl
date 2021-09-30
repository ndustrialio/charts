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
ndustrial.io/app: {{ .Values.ndustrial.name }}
backstage.io/kubernetes-id: {{ .Values.ndustrial.name }}
ndustrial.io/organization.slug: {{ .Values.ndustrial.organization }}
ndustrial.io/owner: {{ .Values.ndustrial.owner }}
ndustrial.io/project.slug: {{ .Values.ndustrial.project }}
ndustrial.io/project.type: {{ .Values.ndustrial.type }}
ndustrial.io/version: {{ .Values.ndustrial.version }}
{{- if .Values.ndustrial.managed_by }}
ndustrial.io/managed-by: {{ .Values.ndustrial.managed_by }}
{{- end }}
{{- if .Values.ndustrial.env }}
ndustrial.io/env: {{ .Values.ndustrial.env }}
{{- end }}
{{- if .Values.ndustrial.repo }}
ndustrial.io/repo: {{ .Values.ndustrial.repo }}
{{- end }}
{{/*
# Datadog labels
*/}}
tags.datadoghq.com/env: {{ .Values.ndustrial.env }}
tags.datadoghq.com/version: {{ .Values.ndustrial.version }}
tags.datadoghq.com/service: {{ .Values.ndustrial.name }}
{{- if .Values.contxt.projectId }}
contxt/project.id: {{ .Values.contxt.projectId | quote }}
contxt/service.id: {{ .Values.contxt.serviceId | quote }}
contxt/service.type: {{ .Values.contxt.serviceType }}
{{- end }}
{{- end -}}

{{/*
Labels to use on deploy.spec.selector.matchLabels and svc.spec.selector
*/}}
{{- define "nio-common.labels.matchLabels" -}}
app.kubernetes.io/name: {{ include "nio-common.names.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
