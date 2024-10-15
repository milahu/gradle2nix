#!/usr/bin/env bash

if true; then

  # use nix to build gradle2nix
  # https://github.com/tadfisher/gradle2nix/issues/77

  # set JAVA_HOME for gradle2nix
  echo "installing java"
  export JAVA_HOME=$(nix-build --no-out-link '<nixpkgs>' -A jdk21)
  # this is faster, but requires openjdk-21 in /nix/store
  # export JAVA_HOME=$(ls -d /nix/store/*-openjdk-21* | grep -v '.drv$' | sort -V | tail -n1)

  function gradle2nix() {
    nix run github:tadfisher/gradle2nix/v2 -- "$@"
  }

else

  # use gradlew to build gradle2nix
  # set JAVA_HOME for gradlew
  echo "installing java"
  export JAVA_HOME=$(nix-build --no-out-link '<nixpkgs>' -A jdk21)

  # add java to PATH
  export PATH="$JAVA_HOME/bin:$PATH"

  # TODO build gradle2nix.jar
  ./gradlew assemble # no gradle2nix.jar
  ./gradlew build # error

  function gradle2nix() {
    java -jar gradle2nix.jar "$@"
  }

fi



echo "updating gradle.lock"
gradle2nix
