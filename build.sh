#!/bin/sh -e

./run-style-check.sh --ci-mode
mvn clean install
