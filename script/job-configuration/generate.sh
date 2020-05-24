#!/bin/sh -e

REMOTE=$(git config --get remote.origin.url)
echo "${REMOTE}" | grep --quiet github.com && IS_GITHUB=true || IS_GITHUB=false

if [ "${IS_GITHUB}" = true ]; then
    echo "${REMOTE}" | grep --quiet git@github.com && IS_SSH=true || IS_SSH=false

    if [ "${IS_SSH}" = true ]; then
        # Machine user has SSH read access to public repositories.
        true
    fi
fi

# shellcheck disable=SC2016
jjm --locator "${REMOTE}" --build-command script/build.sh --junit 'target/surefire-reports/junitreports/TEST-*.xml' --checkstyle target/checkstyle-result.xml  --publish target/site/jacoco --recipients funtimecoding@gmail.com > configuration/job.xml
