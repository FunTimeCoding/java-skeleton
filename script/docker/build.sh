#!/bin/sh -e

docker images | grep --quiet funtimecoding/java-skeleton && FOUND=true || FOUND=false

if [ "${FOUND}" = true ]; then
    docker rmi funtimecoding/java-skeleton
fi

docker build --tag funtimecoding/java-skeleton .
