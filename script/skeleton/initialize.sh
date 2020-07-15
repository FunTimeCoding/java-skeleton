#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(
    cd "${DIRECTORY}" || exit 1
    pwd
)
# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../../configuration/project.sh"
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
# TODO: Delete after testing the include way works throughout all projects.
#${FIND} . -regextype posix-extended -type f ! -regex "${EXCLUDE_FILTER}" -exec sh -c '${1} --in-place --expression "s/JavaSkeleton/${2}/g" --expression "s/java-skeleton/${3}/g" --expression "s/java\.skeleton/${4}/g" "${5}"' '_' "${SED}" "${NAME}" "${DASH}" "${DOTS}" '{}' \;
${FIND} . -regextype posix-extended -type f -regex "${INCLUDE_FILTER}" -exec sh -c '${1} --in-place --expression "s/JavaSkeleton/${2}/g" --expression "s/java-skeleton/${3}/g" --expression "s/java\.skeleton/${4}/g" "${5}"' '_' "${SED}" "${NAME}" "${DASH}" "${DOTS}" '{}' \;
# shellcheck disable=SC1117
${SED} --in-place --expression "s/bin\/js/bin\/${INITIALS}/g" --expression "s/'js'/'${INITIALS}'/g" README.md Vagrantfile Dockerfile
mkdir -p "src/main/java/org/funtimecoding/${SLASHES}"
mkdir -p "src/test/java/org/funtimecoding/${SLASHES}"
git mv src/main/java/org/funtimecoding/java/skeleton/JavaSkeletonMain.java "src/main/java/org/funtimecoding/${SLASHES}/${NAME}Main.java"
git mv src/test/java/org/funtimecoding/java/skeleton/TestJavaSkeletonMain.java "src/test/java/org/funtimecoding/${SLASHES}/Test${NAME}Main.java"
rmdir src/main/java/org/funtimecoding/java/skeleton || true
rmdir src/test/java/org/funtimecoding/java/skeleton || true
rmdir src/main/java/org/funtimecoding/java || true
rmdir src/test/java/org/funtimecoding/java || true
