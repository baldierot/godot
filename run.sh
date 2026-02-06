#!/bin/bash

TARGET="template_release"
DEBUG_SYMBOLS_FLAG="debug_symbols=no"
PLATFORM="web"
THREADS="no"

# Loop through arguments to check for 'debug' and 'linux'
while [[ "$#" -gt 0 ]]; do
  case $1 in
    debug)
      echo "DEBUG build requested."
      TARGET="template_debug"
      DEBUG_SYMBOLS_FLAG="debug_symbols=yes separate_debug_symbols=no"
      shift
      ;;
    linux)
      echo "LINUX platform requested."
      PLATFORM="linux"
      THREADS="yes"
      shift
      ;;
    *)
      break
      ;;
  esac
done

if [ "$TARGET" = "template_release" ]; then
  echo "RELEASE build requested."
fi

# The rest of the arguments are passed to scons
scons platform=$PLATFORM target=$TARGET $DEBUG_SYMBOLS_FLAG optimize=custom ccflags="-Oz" linkflags="-Oz" cppdefines="SIZE_EXTRA" lto=full threads=$THREADS "$@"
