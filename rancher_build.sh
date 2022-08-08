#!/bin/sh

set -e

if [ "${DEBUG}" ]; then
    set -x
fi

PROG=${PROG:=enterprise}
FIPS_BUILD_IMAGE=${FIPS:=rancher/hardened-build-base:v1.18.4b7}

git clone git@github.com:rancher/rancher.git
cd rancher

if [ ${FIPS} ]; then
    PROG=${PROG} BUILD_IMAGE=${FIPS_BUILD_IMAGE} make build
else
    PROG=${PROG} make build
fi

exit 0
