#!/bin/sh

set -e

if [ "${DEBUG}" ]; then
    set -x
fi

PROG=${PROG:=lke}
BUILD_IMAGE=""
SKIP_VALIDATE=${SKIP_VALIDATE:=false}

if [ ${FIPS} ]; then
    BUILD_IMAGE=rancher/hardened-build-base:v1.18.4b7
fi

# update_service_files renames the k3s systemd service files
# and updates the content to reflect the name of the enterprise
# build name.
update_service_files() {
    local service_file="${PROG}.service"
    local rootless_service_file="${PROG}-rootless.service"

    mv k3s.service "${service_file}"
    sed -i 's/k3s/${PROG}/g' "${service_file}"

    mv k3s-rootless.service "${rootless_service_file}"
    sed -i 's/k3s/${PROG}/g' "${rootless_service_file}"
}

# git clone git@github.com:k3s-io/k3s.git
cd ${GOPATH}/src/github.com/briandowns/k3s

if [ "${BUILD_IMAGE}" != "" ]; then
    PROG=${PROG} IMAGE_NAME=${PROG} SKIP_VALIDATE=${SKIP_VALIDATE} GOLANG=${BUILD_IMAGE} make
else
    PROG=${PROG} IMAGE_NAME=${PROG} SKIP_VALIDATE=${SKIP_VALIDATE} make
fi

exit 0
