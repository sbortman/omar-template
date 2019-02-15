#!/usr/bin/env bash

SOURCE="${BASH_SOURCE[0]}"
TARGET=$1

mkdir $PWD/plugins
cd $PWD/plugins

# Target MUST end with -plugin suffix for this to work
grails create-plugin $TARGET

cd $TARGET

# Get rid of unnecessary files
rm -rf .gitignore \
       gradle* \
       grailsw* \
       grails-wrapper.jar

# Add placeholder for inclusion of dependencies
cat >build.gradle <<EOL
/*
if ( System.getenv('O2_INLINE_BUILD') ) {
    grails {
        plugins {
            if ( System.getenv('O2_INLINE_BUILD') ) {
            //    compile project(":omar-core-plugin")
            }
        }
    }
}

dependencies {
    //compile project( ":\${ rootProject.projectDir.name }-lib" )

    if ( ! System.getenv('O2_INLINE_BUILD') ) {
    // compile "io.ossim.omar.plugins:omar-core-plugin:+"
    }
}
*/
EOL
