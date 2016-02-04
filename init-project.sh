#!/bin/sh -e
# This tool is to initialize the project after cloning.
# The goal is to make easy to create and test new projects.

CAMEL=$(echo "${1}" | grep -E '^([A-Z][a-z0-9]+){2,}$') || CAMEL=""

if [ "${CAMEL}" = "" ]; then
    echo "Usage: ${0} UpperCamelCaseName"

    exit 1
fi

OS=$(uname)

if [ "${OS}" = "Darwin" ]; then
    SED="gsed"
else
    SED="sed"
fi

DASH=$(echo "${CAMEL}" | ${SED} -E 's/([A-Za-z0-9])([A-Z])/\1-\2/g' | tr '[:upper:]' '[:lower:]')
DOTS=$(echo "${DASH}" | ${SED} 's/-/\./g')
SLASHES=$(echo "${DASH}" | ${SED} 's/-/\//g')
find -E . -type f ! -regex '^.*/(build|\.git|\.idea)/.*$' -exec sh -c '${1} -i -e "s/JavaSkeleton/${2}/g" -e "s/java-skeleton/${3}/g" -e "s/java\.skeleton/${4}/g" ${5}' '_' "${SED}" "${CAMEL}" "${DASH}" "${DOTS}" '{}' \;
mkdir -p src/main/java/org/funtimecoding/"${SLASHES}"
mkdir -p src/test/java/org/funtimecoding/"${SLASHES}"
git mv src/main/java/org/funtimecoding/java/skeleton/JavaSkeletonMain.java "src/main/java/org/funtimecoding/${SLASHES}/${CAMEL}Main.java"
git mv src/test/java/org/funtimecoding/java/skeleton/JavaSkeletonMainTest.java "src/test/java/org/funtimecoding/${SLASHES}/${CAMEL}MainTest.java"
rm init-project.sh
rm sync-project.sh
echo "Done. Files were edited and moved using git. Review those changes."
