

# aws-ecr-credentials

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)

Seemlessly update AWS ECR credentials into Kubernetes as a pull secret to pull private repositories with.

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Joris Borgdorff | <joris@thehyve.nl> |  |

## Source Code

* <https://github.com/IMI-H2O/h2o-helm-charts/tree/master/charts/aws-ecr-credentials>

## Prerequisites
* Kubernetes 1.17+
* Kubectl 1.17+
* Helm 3.1.0+

## AWS setup

Create an IAM user that has the following policies enabled:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowPull",
            "Effect": "Allow",
            "Action": [
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
            ],
            "Resource": "arn:aws:ecr:<AWS region>:<AWS account number>:repository/<repository wildcard>"
        },
        {
            "Sid": "AllowLogin",
            "Effect": "Allow",
            "Action": "ecr:GetAuthorizationToken",
            "Resource": "*"
        }
    ]
}
```

In the snippet above, replace `<AWS region>`, `<AWS account number>` and `<repository wildcard>` with their respective values. Provide these values and the credentials of the created user in the `aws` values object.
## Pull secret usage

If `patchServiceAccount` is set to true, the created secret will be set as one of the default pull secrets for the namespaces. Individual deployments then don't need to be modified. If a default pull secret is not required, they need to be set as follows. Suppose the full name of the chart is `aws-ecr-credentials`, then the secret will be called `aws-ecr-credentials-aws-registry`. Then in your kubernetes deployment use `imagePullSecrets: aws-ecr-credentials-aws-registry`.

Example:
```yaml
apiVersion: apps/v1
kind: Deployment
spec:
  template:
    spec:
      imagePullSecrets:
      - name: aws-ecr-credentials-aws-registry
      containers:
        - name: node
          image: node:latest
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| image.repository | string | `"thehyve/aws-ecr-credentials"` | Docker image repository |
| image.tag | string | `""` | Docker image tag |
| image.pullPolicy | string | `"Always"` | Docker image pull policy |
| imagePullSecrets | list | `[]` | Docker registry secret names as an array |
| nameOverride | string | `""` | String to partially override fullname template with a string (will prepend the release name) |
| fullnameOverride | string | `""` | String to fully override fullname template with a string |
| podAnnotations | object | `{}` | Additional annotations for Job pods |
| podSecurityContext | object | `{}` | Security context for pods |
| securityContext | object | `{}` | Security context for containers |
| nodeSelector | object | `{}` | Node labels for pod assignment |
| namespaceOverride | string | `""` | Namespace where the AWS login jobs will take place. By default, the helm chart namespace is used. |
| targetNamespaces | list | `["default"]` | Namespaces where the Amazon Elastic Container Registry secret will be created and maintained |
| patchServiceAccount | bool | `true` | Whether to patch the `default` service account to use the created secret as a default image pull secret in the target namespaces |
| aws.account | string | `""` | AWS account number of the ECR |
| aws.region | string | `""` | AWS region where ECR repositories are hosted |
| aws.accessKeyId | string | `""` | AWS access key ID, preferably of a read-only user for the ECR |
| aws.secretAccessKey | string | `""` | AWS secret access key corresponding to the access key ID |
