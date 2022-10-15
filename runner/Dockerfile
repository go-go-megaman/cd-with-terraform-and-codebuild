FROM amazon/aws-cli:2.7.16

WORKDIR /usr/bin
ARG TERRAFORM_VERSION=1.3.2
RUN yum install -y unzip-6.0-43.amzn2 tar-1.26 gzip-1.5 \
  && yum clean all \
  && curl -O https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
  && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
  && rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

WORKDIR /
COPY . .
ENTRYPOINT [ "/entrypoint.sh" ]
