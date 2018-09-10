#!/bin/sh -e

# Development mode mounts the project root so it can be edited and re-ran without rebuilding the image and recreating the container.

if [ "${1}" = --development ]; then
    DEVELOPMENT=true
else
    DEVELOPMENT=false
fi

docker ps --all | grep --quiet java-skeleton && FOUND=true || FOUND=false

if [ "${FOUND}" = false ]; then
    WORKING_DIRECTORY=$(pwd)

    if [ "${DEVELOPMENT}" = true ]; then
        docker create --name java-skeleton --volume "${WORKING_DIRECTORY}:/java-skeleton" funtimecoding/java-skeleton
    else
        docker create --name java-skeleton funtimecoding/java-skeleton
    fi

    # TODO: Specifying the entry point overrides CMD in Dockerfile. Is this useful, or should all sub commands go through one entry point script? I'm inclined to say one entry point script per project.
    #docker create --name java-skeleton --volume "${WORKING_DIRECTORY}:/java-skeleton" --entrypoint /java-skeleton/bin/other.sh funtimecoding/java-skeleton
    #docker create --name java-skeleton funtimecoding/java-skeleton /java-skeleton/bin/other.sh
    # TODO: Run tests this way?
    #docker create --name java-skeleton funtimecoding/java-skeleton /java-skeleton/script/docker/test.sh
fi

docker start --attach java-skeleton
