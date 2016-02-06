#!/bin/sh -e

if [ "$(command -v shellcheck || true)" = "" ]; then
    echo "Command not found: shellcheck"

    exit 1
fi

# shellcheck disable=SC2016
find . \( -name '*.sh' -and -not -path '*/.git/*' \) -exec sh -c 'shellcheck ${1} || true' '_' '{}' \;