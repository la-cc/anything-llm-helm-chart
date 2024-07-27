{{- define "anything-llm.name" -}}
{{- if .Values.nameOverride -}}
{{- .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "anything-llm.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else if .Release.Name }}
{{- printf "%s-%s" (include "anything-llm.name" .) .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else }}
{{- "open-webui-ollama" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "anything-llm.labels" -}}
helm.sh/chart: {{ include "anything-llm.chart" . }}
app.kubernetes.io/name: {{ include "anything-llm.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "anything-llm.chart" -}}
{{ .Chart.Name }}-{{ .Chart.Version }}
{{- end -}}

{{- define "anything-llm.selectorLabels" -}}
app.kubernetes.io/name: {{ include "anything-llm.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
