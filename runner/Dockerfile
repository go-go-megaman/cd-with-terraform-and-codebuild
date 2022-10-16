FROM --platform=$BUILDPLATFORM amazon/aws-cli:2.7.16

ARG TARGETOS
ARG TARGETARCH
ARG TERRAFORM_VERSION=1.3.2
ARG TFLINT_VERSION=0.41.0

WORKDIR /usr/bin
RUN yum install -y unzip-6.0-43.amzn2 tar-1.26 gzip-1.5 git-2.37.1-1.amzn2.0.1\
  && yum clean all \
  && curl -O https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_"${TARGETOS}"_"${TARGETARCH}".zip \
  && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
  && rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
  && curl -L -o /tmp/tflint.zip https://github.com/terraform-linters/tflint/releases/download/v"${TFLINT_VERSION}"/tflint_"${TARGETOS}"_"${TARGETARCH}".zip \
  && unzip /tmp/tflint.zip -d /usr/local/bin \
  && rm /tmp/tflint.zip

WORKDIR /
COPY . .
ENTRYPOINT [ "/entrypoint.sh" ]
