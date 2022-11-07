#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(
    cd "${DIRECTORY}" || exit 1
    pwd
)
# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../../configuration/project.sh"

mkdir -p tmp
docker run --interactive --tty --rm \
    --name "${PROJECT_NAME_DASH}" \
    --volume "$(pwd)/tmp/m2:/root/.m2" \
    --volume "$(pwd):/${PROJECT_NAME_DASH}" \
    --entrypoint mvn \
    "${VENDOR_NAME_LOWER}/${PROJECT_NAME_DASH}" $@
