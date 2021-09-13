{{/* vim: set filetype=mustache: */}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "statefulset.imagePullSecrets" -}}
{{ include "nio-common.images.pullSecrets" (dict "images" (list .Values.image) "global" .Values.global) }}
{{- end -}}

{{/*
Returns the proper service account name depending if an explicit service account name is set
in the values file. If the name is not set it will default to either common.names.fullname if serviceAccount.create
is true or default otherwise.
*/}}
{{- define "statefulset.serviceAccountName" -}}
    {{- if .Values.serviceAccount.create -}}
        {{- if (empty .Values.serviceAccount.name) -}}
          {{- printf "%s-statefulset" (include "nio-common.names.fullname" .) | trunc 63 | trimSuffix "-" -}}
        {{- else -}}
          {{ default "default" .Values.serviceAccount.name }}
        {{- end -}}
    {{- else -}}
        {{ default "default" .Values.serviceAccount.name }}
    {{- end -}}
{{- end -}}

{{/*
Return the proper cronjob.image name
*/}}
{{- define "statefulset.image" -}}
{{ include "nio-common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}
