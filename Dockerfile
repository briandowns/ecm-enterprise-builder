FROM rancher/hardened-build-base:v1.18.3b7

RUN apk update && \
    apk upgrade --no-cache

COPY . .
