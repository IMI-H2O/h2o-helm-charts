ARG AWS_VERSION=latest

FROM --platform=$BUILDPLATFORM alpine/curl as downloader
ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG KUBECTL_VERSION=stable

RUN echo "[${BUILDPLATFORM}] downloading kubectl version ${KUBECTL_VERSION} for platform ${TARGETPLATFORM}"

WORKDIR /tmp
# Download kubectl according the target platform
RUN if [ $KUBECTL_VERSION = stable ]; then KUBECTL_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt); fi; \
	curl -LO https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/$(echo $TARGETPLATFORM | cut -d'/' -f2)/kubectl \
  && chmod +x kubectl

FROM amazon/aws-cli:$AWS_VERSION

ENV AWS_ACCOUNT= \
	AWS_REGION= \
	AWS_ACCESS_KEY_ID= \
	AWS_SECRET_ACCESS_KEY= \
	SECRET_NAME=aws-registry \
	PATCH_SERVICEACCOUNT=

COPY update-ecr-credentials /usr/bin/update-ecr-credentials
COPY --from=downloader /tmp/kubectl /usr/local/bin/kubectl

USER 101
ENTRYPOINT []
CMD ["/usr/bin/update-ecr-credentials"]
