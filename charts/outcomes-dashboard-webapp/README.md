

# outcomes-dashboard-webapp

![Version: 0.1.1](https://img.shields.io/badge/Version-0.1.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.16.0](https://img.shields.io/badge/AppVersion-1.16.0-informational?style=flat-square)

A Helm chart for Kubernetes

## Prerequisites
* Kubernetes 1.17+
* Kubectl 1.17+
* Helm 3.1.0+

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| replicaCount | int | `1` |  |
| image.repository | string | `"quay.io/imi-h2o/outcomes-dashboard-webapp"` | docker image repository |
| image.pullPolicy | string | `"Always"` | image pull policy |
| image.tag | string | `"dev"` |  |
| imagePullSecrets | list | `[]` |  |
| nameOverride | string | `""` |  |
| fullnameOverride | string | `""` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| securityContext | object | `{}` |  |
| service.type | string | `"ClusterIP"` |  |
| service.port | int | `8080` |  |
| ingress.enabled | bool | `true` | Enable ingress controller resource |
| ingress.className | string | `""` | Ingress class name |
| ingress.annotations | object | check values.yaml | Annotations that define default ingress class, certificate issuer |
| ingress.path | string | `"/h2o($|/)(.*)"` | Path within the url structure |
| ingress.pathType | string | `"ImplementationSpecific"` |  |
| ingress.hosts | list | `["localhost"]` | Hosts to accept requests from |
| ingress.tls.secretName | string | `"radar-base-tls"` | TLS Secret Name |
| resources | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| nodeSelector | object | `{}` |  |
| tolerations | list | `[]` |  |
| affinity | object | `{}` |  |
| serverName | string | `"localhost"` | Host name |
| managementPortal.url | string | `"http://localhost:8080/managementportal"` | ManagementPortal URL |
| managementPortal.clientId | string | `"h2o_dashboard_webapp"` | ManagementPortal OAuth 2.0 client ID, having grant type authorization_code |
| managementPortal.clientSecret | string | `""` | ManagementPortal OAuth 2.0 client secret |
