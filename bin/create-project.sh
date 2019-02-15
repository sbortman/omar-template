#!/usr/bin/env bash

SOURCE="${BASH_SOURCE[0]}"
TARGET=$1

mkdir $PWD/$TARGET

cp $(dirname $SOURCE)/../.gitignore  $PWD/$TARGET
cp $(dirname $SOURCE)/../settings.gradle  $PWD/$TARGET
cp $(dirname $SOURCE)/../gradle.properties  $PWD/$TARGET
cp $(dirname $SOURCE)/../build.gradle  $PWD/$TARGET

sed -i '' "s/template/$TARGET/g" $PWD/$TARGET/gradle.properties
