#!/bin/bash

rm -rf ./dist
mkdir ./dist

config_var() {
  ruby -e "require './src/config.rb'; puts $1"
}

/usr/local/bin/platypus \
  --app-icon '/Applications/Platypus.app/Contents/Resources/PlatypusDefault.icns' \
  --app-version "$(config_var VERSION)" \
  --author 'Carlo Zottmann <carlo@zottmann.org>' \
  --background \
  --bundle-identifier "$(config_var APP_BUNDLE_ID)" \
  --bundled-file ./src \
  --interface-type 'Status Menu'  \
  --interpreter '/usr/bin/ruby'  \
  --name 'Bearing'  \
  --overwrite \
  --status-item-kind 'Text' \
  --status-item-sysfont \
  --status-item-title 'B' \
  --uri-schemes "$(config_var URI_SCHEME)" \
  ./src/main.rb

mv ./src/Bearing.app ./dist/
