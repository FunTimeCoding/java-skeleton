#!/bin/sh -e

rm -rf build
script/check.sh --ci-mode
mvn --quiet clean install
mvn --quiet checkstyle:checkstyle
# TODO: Finish implementation, then uncomment.
#script/docker/build.sh
