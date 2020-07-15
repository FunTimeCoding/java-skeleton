#!/bin/sh -e

REMOTE=$(git config --get remote.origin.url)
jjm --locator "${REMOTE}" --build-command script/build.sh --junit 'target/surefire-reports/junitreports/TEST-*.xml' --checkstyle target/checkstyle-result.xml --jacoco --recipients funtimecoding@gmail.com >configuration/job.xml
