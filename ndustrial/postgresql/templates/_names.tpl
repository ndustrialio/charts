{{- define "postgres.names.release" -}}
{{- printf "%s-postgres" .Release.Name -}}
{{- end -}}
