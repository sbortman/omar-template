#!/usr/bin/env bash

SOURCE="${BASH_SOURCE[0]}"
TARGET=$1

mkdir -p $PWD/libs/$TARGET
cp $( dirname $SOURCE)/../libs/omar-template-lib/build.gradle $PWD/libs/$TARGET
