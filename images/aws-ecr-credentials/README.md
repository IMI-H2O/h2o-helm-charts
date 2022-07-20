# aws-ecr-credentials Docker image

Docker image to log into AWS ECR and store the resulting Docker password in a Kubernetes secret.

## Tags

This image is tagged according to the aws-cli and Kubernetes version that is used. The main version is taken from the `appVersion` property of `charts/aws-ecr-credentials/Chart.yaml`.

## Usage

The image takes the following environment variables

| Name | Description |
|-----|------|---------|-------------|
| `NAMESPACES` | List of namespaces where a pull secret should be created, space-separated.  |
| `AWS_ACCOUNT` | AWS account number. |
| `AWS_REGION` | AWS region where the ECR is located. |
| `AWS_ACCESS_KEY_ID` | AWS access key ID of the user that should pull docker images from ECR. |
| `AWS_SECRET_ACCESS_KEY` | AWS secret access key of the user that should pull docker images from ECR. |
| `SECRET_NAME` | Name of the secret that should be created in Kubernetes, `aws-registry` by default |
| `PATCH_SERVICEACCOUNT` | If set to `true`, the image will patch the `default` serviceaccount in each affected namespace so that the ECR login becomes a default image pull secret. |

## Build

This image should be built `docker buildx`. It has two build arguments:

- `KUBECTL_VERSION`: version of kubectl to use. By default, the currently stable version is used as found on <https://dl.k8s.io/release/stable.txt>.
- `AWS_VERSION`: version of `aws-cli` version 2 to use. By default the latest version is used.
