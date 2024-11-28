{{/*
Generate common labels for resources.
These labels ensure consistency across all resources in the chart.
*/}}
{{- define "common.labels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.Version }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Generate a fully qualified name for a resource.
Useful for creating unique resource names based on the release.
*/}}
{{- define "common.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{ .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else if .Values.nameOverride -}}
{{ .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- else -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end -}}
{{- end }}

{{/*
Generate a name for a service account.
Fallbacks to "common.fullname" if not explicitly set in values.
*/}}
{{- define "common.serviceAccountName" -}}
{{- if .Values.serviceAccount.name -}}
{{ .Values.serviceAccount.name | trunc 63 | trimSuffix "-" }}
{{- else -}}
{{ include "common.fullname" . }}
{{- end -}}
{{- end }}
