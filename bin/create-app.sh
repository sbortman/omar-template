#!/usr/bin/env bash

SOURCE="${BASH_SOURCE[0]}"
TARGET=$1

mkdir $PWD/apps
cd $PWD/apps

# Will append with -app suffix to app name
APP_NAME=$TARGET-app
grails create-app $APP_NAME

cd $APP_NAME

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
    name: ${TARGET}
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

# Copy default configuration
CONFIG_FILE=$(find . -name application.yml)
cp $(dirname $SOURCE)/../apps/omar-template-app/grails-app/conf/application.yml ${CONFIG_FILE}
sed -i '' "s/omar.template/${TARGET//-/.}/g" ${CONFIG_FILE}

# Copy Spring Cloud Annotation
APPLICATION_FILE=$(find . -name Application.groovy)
cp $(dirname $SOURCE)/../apps/omar-template-app/grails-app/init/omar/template/app/Application.groovy ${APPLICATION_FILE}
sed -i '' "s/omar.template/${TARGET//-/.}/g" ${APPLICATION_FILE}

# Copy Docker starter files
mkdir -p $PWD/src/main/docker
cp $(dirname $SOURCE)/../apps/omar-template-app/src/main/docker/* $PWD/src/main/docker


