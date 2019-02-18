#!/usr/bin/env bash

SOURCE="${BASH_SOURCE[0]}"
TARGET=$1

mkdir $PWD/apps
cd $PWD/apps

# Target MUST end with -app suffix for this to work
grails create-app $TARGET

cd $TARGET

# Get rid of unnecessary files
rm -rf .gitignore \
       gradle* \
       grailsw* \
       grails-wrapper.jar

# Add placeholder for inclusion of dependencies
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

# Setup Spring Cloud
cat >grails-app/conf/bootstrap.yml <<EOL
---
spring:
  application:
    name: ${TARGET::-4}
  cloud:
    config:
      enabled: false
      uri: http://localhost:8888
    discovery:
      enabled: false
    service-registry:
      auto-registration:
        enabled: \${spring.cloud.discovery.enabled}
EOL

APPLICATION_FILE=$(find . -name Application.groovy)
cp $(dirname $SOURCE)/../apps/omar-template-app/grails-app/init/omar/template/app/Application.groovy ${APPLICATION_FILE}
sed -i '' "s/omar.template/${TARGET//-/.}/g" ${APPLICATION_FILE}
