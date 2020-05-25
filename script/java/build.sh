#!/bin/sh -e

if [ "${1}" = --help ]; then
    echo "Usage: ${0} [--ci-mode]"

    exit 0
fi

if [ "${1}" = --ci-mode ]; then
    mvn --quiet --batch-mode clean install
else
    mvn --quiet clean install
fi
