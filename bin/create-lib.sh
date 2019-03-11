#!/usr/bin/env bash

SOURCE="${BASH_SOURCE[0]}"
TARGET=$1

# Will append -lib suffix to lib name
LIB_NAME=$TARGET-lib
mkdir -p $PWD/libs/$LIB_NAME
cp $(dirname $SOURCE)/../libs/omar-template-lib/build.gradle $PWD/libs/$LIB_NAME
