#!/bin/sh -e

rm -rf build
script/check.sh --ci-mode
mvn clean install
mvn checkstyle:checkstyle
# TODO: Finish implementation, then uncomment.
#script/docker/build.sh
