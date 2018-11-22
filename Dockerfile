ARG APLINE_VERSION=3.8
FROM alpine:${APLINE_VERSION}

ARG CONSUL_TEMPLATE_VERSION=0.19.5

RUN set -xeuo pipefail \
    && apk update \
    && apk upgrade \
    && apk add --no-cache curl unzip \
    && curl -sSL https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip -o /tmp/consul-template.zip \
    && unzip -d /tmp /tmp/consul-template.zip \
    && mv /tmp/consul-template /bin/consul-template \
    && consul-template -version \
    && rm -rf /tmp/* \
    && apk del unzip curl

ENTRYPOINT ["consul-template"]
