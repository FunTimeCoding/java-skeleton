#!/bin/sh -e

if [ "${1}" = --help ]; then
    echo "Usage: ${0} [--ci-mode]"

    exit 0
fi

if [ "${1}" = --ci-mode ]; then
    mvn --batch-mode checkstyle:checkstyle
else
    mvn checkstyle:checkstyle
fi
