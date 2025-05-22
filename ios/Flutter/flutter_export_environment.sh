#!/usr/bin/env bash
# Dieses Skript bleibt im Repo und darf NICHT mehr überschrieben werden!
FLUTTER_BIN="$(command -v flutter)"
if [ -z "$FLUTTER_BIN" ]; then
  echo "❌  Flutter nicht gefunden – bitte Flutter installieren & PATH setzen."
  exit 1
fi
export FLUTTER_ROOT="$(dirname "$(dirname "$FLUTTER_BIN")")"
export FLUTTER_APPLICATION_PATH="$SRCROOT/.."
export COCOAPODS_PARALLEL_CODE_SIGN=true
export FLUTTER_TARGET=lib/main.dart
export FLUTTER_BUILD_DIR=build
export FLUTTER_BUILD_NAME=1.0.0
export FLUTTER_BUILD_NUMBER=1
export DART_OBFUSCATION=false
export TRACK_WIDGET_CREATION=true
export TREE_SHAKE_ICONS=false
export PACKAGE_CONFIG=.dart_tool/package_config.json
