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
{{- if and (hasKey .Values "ndustrial") (not (empty .Values.ndustrial)) -}}
{{- with .Values.ndustrial -}}
{{- if hasKey . "name" }}
ndustrial.io/app: {{ .name }}
backstage.io/kubernetes-id: {{ .name }}
{{- end }}
{{- if hasKey . "organization" }}
ndustrial.io/organization.slug: {{ .organization }}
{{- end }}
{{- if hasKey . "owner" }}
ndustrial.io/owner: {{ .owner }}
{{- end }}
{{- if hasKey . "alerts" }}
ndustrial.io/alerts: {{ .alerts }}
{{- end }}
{{- if hasKey . "project" }}
ndustrial.io/project.slug: {{ .project }}
{{- end }}
{{- if hasKey . "type" }}
ndustrial.io/project.type: {{ .type }}
{{- end }}
ndustrial.io/version: {{ default .version $.Values.image.tag }}
{{- if hasKey . "managed_by" }}
ndustrial.io/managed-by: {{ .managed_by }}
{{- end }}
{{- if hasKey . "env" }}
ndustrial.io/env: {{ .env }}
{{- end }}
ndustrial.io/repo: {{ default .repo .name }}
{{/*
# Datadog labels
*/}}
{{- if hasKey . "env" }}
tags.datadoghq.com/env: {{ .env }}
{{- end }}
{{- if hasKey . "version" }}
tags.datadoghq.com/version: {{ .version }}
{{- end }}
{{- if hasKey . "name" }}
tags.datadoghq.com/service: {{ .name }}
{{- end }}
{{- end -}}
{{- end -}}

{{- if and (hasKey .Values "contxt") (not (empty .Values.contxt)) -}}
{{- with .Values.contxt -}}
{{- if and (hasKey . "projectId") (hasKey . "serviceId") }}
contxt/project.id: {{ .projectId | quote }}
contxt/service.id: {{ .serviceId | quote }}
{{- if hasKey . "serviceId" }}
contxt/service.type: {{ .serviceType }}
{{- end }}
{{- end }}
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
