#!/usr/bin/env bash

SOURCE="${BASH_SOURCE[0]}"
TARGET=$1

mkdir $PWD/apps
cd $PWD/apps
grails create-app $TARGET
cd $TARGET

rm -rf .gitignore \
       gradle* \
       grailsw* \
       grails-wrapper.jar

cat >build.gradle <<EOL
/*
grails {
    plugins {
        //compile project( ":\${ rootProject.projectDir.name }-plugin" )
        if ( System.getenv('O2_INLINE_BUILD') ) {
        //    compile project(":omar-core-plugin")
        }
    }
}

dependencies {
    if ( ! System.getenv('O2_INLINE_BUILD') ) {
    // compile "io.ossim.omar.plugins:omar-core-plugin:+"
    }
}
*/
EOL
