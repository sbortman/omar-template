#!/usr/bin/env bash

SOURCE="${BASH_SOURCE[0]}"
TARGET=$1

# Target MUST end with -lib suffix for this to work
mkdir -p $PWD/libs/$TARGET
cp $(dirname $SOURCE)/../libs/omar-template-lib/build.gradle $PWD/libs/$TARGET
