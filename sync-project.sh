#!/bin/sh -e

TARGET_PROJECT="${1}"

if [ "${TARGET_PROJECT}" = "" ]; then
    echo "Usage: ${0} TARGET_PROJECT"

    exit 1
fi

if [ ! -d "${TARGET_PROJECT}" ]; then
    echo "Target directory does not exist."

    exit 1
fi

CAMEL=$(head -n1 "${TARGET_PROJECT}"/README.md | awk '{ print $2 }' | grep -E '^([A-Z][a-z0-9]+){2,}$') || CAMEL=""

if [ "${CAMEL}" = "" ]; then
    echo "Could not determine project name."

    exit 1
fi

OPERATING_SYSTEM=$(uname)

if [ "${OPERATING_SYSTEM}" = "Linux" ]; then
    FIND="find"
    SED="sed"
else
    FIND="gfind"
    SED="gsed"
fi

cp ./*.md "${TARGET_PROJECT}"
cp ./*.sh "${TARGET_PROJECT}"
cp .gitignore "${TARGET_PROJECT}"
rm "${TARGET_PROJECT}"/init-project.sh
rm "${TARGET_PROJECT}"/sync-project.sh
DASH=$(echo "${CAMEL}" | ${SED} -E 's/([A-Za-z0-9])([A-Z])/\1-\2/g' | tr '[:upper:]' '[:lower:]')
DOTS=$(echo "${DASH}" | ${SED} 's/-/\./g')
cd "${TARGET_PROJECT}" || exit 1
# shellcheck disable=SC2016
${FIND} . -type f -regextype posix-extended ! -regex '^.*/(build|target|\.git|\.idea)/.*$' -exec sh -c '${1} -i -e "s/JavaSkeleton/${2}/g" -e "s/java-skeleton/${3}/g" -e "s/java\.skeleton/${4}/g" ${5}' '_' "${SED}" "${CAMEL}" "${DASH}" "${DOTS}" '{}' \;
echo "Done. Files were copied to ${TARGET_PROJECT} and modified. Review those changes."
