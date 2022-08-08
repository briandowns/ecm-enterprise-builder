#!/bin/sh

# Does kubectl get nodes output matter if it has k3s in it.
#
# lke binary dist/artifacts/lke size 67350528 exceeds max acceptable size of 67108864 bytes (64 MiB) - 241664 diff

set -e

if [ "${DEBUG}" ]; then
    set -x
fi

PROG="lke"
SKIP_VALIDATE=${SKIP_VALIDATE:=false}
FIPS_BUILD_IMAGE=rancher/hardened-build-base:v1.18.1b7

# update_service_files renames the k3s systemd service files
# and updates the content to reflect the name of the enterprise
# build name.
update_service_files() {
    local service_file="${PROG}.service"
    local rootless_service_file="${PROG}-rootless.service"

    mv k3s.service "${service_file}"
    sed -i "s/k3s/${PROG}/g" "${service_file}"

    mv k3s-rootless.service "${rootless_service_file}"
    sed -i "s/k3s/${PROG}/g" "${rootless_service_file}"
}

# update_manifests updates the manifests to use the ${PROG}
# name for users, etc... (ccm & rolebindings)
update_manifests() {
    sed -i "s/k3s/${PROG}/g" manifests/ccm.yaml
    sed -i "s/k3s/${PROG}/g" manifests/rolebindings.yaml
}

git clone git@github.com:k3s-io/k3s.git
cd k3s

if [ ${FIPS} ]; then
    PROG=${PROG} SKIP_VALIDATE=${SKIP_VALIDATE} GOLANG=${FIPS_BUILD_IMAGE} make
else
    PROG=${PROG} SKIP_VALIDATE=${SKIP_VALIDATE} make
fi

update_service_files
update_manifests

exit 0
