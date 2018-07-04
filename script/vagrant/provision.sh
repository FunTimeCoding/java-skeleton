#!/bin/sh -e

export DEBIAN_FRONTEND=noninteractive
apt-get --quiet 2 install neovim multitail htop git tree hunspell shellcheck openjdk-8-jdk-headless maven
