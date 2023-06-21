#!/usr/bin/env bash
#
# Get signature information from a .env file with
# APPLE_ID and APPLE_ID_PASSWORD in it
#
set -o allexport
source .env
set +o allexport

# Build
yarn clean
rm -rf ./node_modules ./dist
yarn

# Build Package
yarn dist

# Sign
if [[ -z $APPLE_ID ]]; then
  codesign -s - --deep --force ./dist/mac-universal/Razer\ macOS.app
fi

# Clean Up
unset APPLE_ID
unset APPLE_ID_PASSWORD
