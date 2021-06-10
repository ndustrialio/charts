{{/* vim: set filetype=mustache: */}}
{{/*
Kubernetes standard labels
*/}}
{{- define "common.labels.standard" -}}
app.kubernetes.io/name: {{ include "common.names.name" . }}
helm.sh/chart: {{ include "common.names.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
ndustrial.io/app: {{ .Values.ndustrial.name }}
ndustrial.io/image.tag: {{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
ndustrial.io/organization.slug: {{ .Values.ndustrial.organization }}
ndustrial.io/owner: {{ .Values.ndustrial.owner }}
{{- if .Values.contxt.stackId -}}
contxt/stack.id: {{ .Values.contxt.stackId }}
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
