{{- define "postgres.labels.standard" -}}
app.kubernetes.io/name: {{ include "nio-common.names.fullname" . }}
helm.sh/chart: postgres
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/version: {{ .version }}
{{- end -}}
