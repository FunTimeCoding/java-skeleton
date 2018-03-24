#!/bin/sh -e

script/check.sh --ci-mode
mvn clean install
