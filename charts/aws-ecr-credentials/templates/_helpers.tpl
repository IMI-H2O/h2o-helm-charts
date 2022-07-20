{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "aws-ecr-credentials.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).∂
If release name contains chart name it will be used as a full name.
*/}}
{{- define "aws-ecr-credentials.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "aws-ecr-credentials.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "aws-ecr-credentials.namespace" -}}
{{- if .Values.namespaceOverride -}}
{{- .Values.namespaceOverride -}}
{{- else -}}
{{- .Release.Namespace -}}
{{- end -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "aws-ecr-credentials.labels" -}}
app.kubernetes.io/name: {{ include "aws-ecr-credentials.name" . }}
helm.sh/chart: {{ include "aws-ecr-credentials.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}


{{/*
Pod labels
*/}}
{{- define "aws-ecr-credentials.podLabels" -}}
app.kubernetes.io/name: {{ include "aws-ecr-credentials.name" . }}
helm.sh/chart: {{ include "aws-ecr-credentials.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{- end -}}

{{/*
Define resource names
*/}}
{{- define "aws-ecr-credentials.serviceAccount" }}
{{- include "aws-ecr-credentials.name" . -}}
{{- end }}

{{- define "aws-ecr-credentials.job" }}
{{- default (printf "%s-job" (include "aws-ecr-credentials.name" .)) -}}
{{- end }}

{{- define "aws-ecr-credentials.cronJob" }}
{{- default (printf "%s-cron" (include "aws-ecr-credentials.name" .)) -}}
{{- end }}

{{- define "aws-ecr-credentials.secret" }}
{{- default (printf "%s-aws-key" (include "aws-ecr-credentials.name" .)) -}}
{{- end }}

{{- define "aws-ecr-credentials.dockerSecret" }}
{{- default (printf "%s-aws-registry" (include "aws-ecr-credentials.name" .)) -}}
{{- end }}
