#!/bin/sh -e

export DEBIAN_FRONTEND=noninteractive
CODENAME=$(lsb_release --codename --short)

if [ "${CODENAME}" = jessie ]; then
    echo Europe/Berlin > /etc/timezone
    dpkg-reconfigure --frontend noninteractive tzdata
    apt-get --quiet 2 install vim multitail htop git tree hunspell shellcheck openjdk-8-jdk-headless maven
elif [ "${CODENAME}" = stretch ]; then
    apt-get --quiet 2 install neovim multitail htop git tree hunspell shellcheck openjdk-9-jdk-headless maven
fi
