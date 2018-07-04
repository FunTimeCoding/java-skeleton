#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(cd "${DIRECTORY}" || exit 1; pwd)
# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../../lib/common.sh"
NAME=$(echo "${1}" | grep --extended-regexp '^([A-Z]+[a-z0-9]*){1,}$') || NAME=''

if [ "${NAME}" = '' ]; then
    echo "Usage: ${0} NAME"
    echo "Name must be in upper camel case."

    exit 1
fi

SYSTEM=$(uname)

if [ "${SYSTEM}" = Darwin ]; then
    SED='gsed'
    FIND='gfind'
else
    SED='sed'
    FIND='find'
fi

rm -rf script/skeleton
DASH=$(echo "${NAME}" | ${SED} --regexp-extended 's/([A-Za-z0-9])([A-Z])/\1-\2/g' | tr '[:upper:]' '[:lower:]')
INITIALS=$(echo "${NAME}" | ${SED} 's/\([A-Z]\)[a-z]*/\1/g' | tr '[:upper:]' '[:lower:]')
DOTS=$(echo "${DASH}" | ${SED} 's/-/\./g')
SLASHES=$(echo "${DASH}" | ${SED} 's/-/\//g')
# shellcheck disable=SC2016
${FIND} . -regextype posix-extended -type f ! -regex "${EXCLUDE_FILTER}" -exec sh -c '${1} --in-place --expression "s/JavaSkeleton/${2}/g" --expression "s/java-skeleton/${3}/g" --expression "s/java\.skeleton/${4}/g" --expression "s/bin\/js/bin\/${5}/g" --expression "s/js\\\\/${5}\\\\/g" "${6}"' '_' "${SED}" "${NAME}" "${DASH}" "${DOTS}" "${INITIALS}" '{}' \;
mkdir -p "src/main/java/org/funtimecoding/${SLASHES}"
mkdir -p "src/test/java/org/funtimecoding/${SLASHES}"
git mv src/main/java/org/funtimecoding/java/skeleton/JavaSkeletonMain.java "src/main/java/org/funtimecoding/${SLASHES}/${NAME}Main.java"
git mv src/test/java/org/funtimecoding/java/skeleton/JavaSkeletonMainTest.java "src/test/java/org/funtimecoding/${SLASHES}/${NAME}MainTest.java"
echo "# This dictionary file is for domain language." > "documentation/dictionary/${DASH}.dic"
