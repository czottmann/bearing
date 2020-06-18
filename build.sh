#!/bin/bash

rm -rf ./dist
mkdir ./dist

/usr/local/bin/platypus \
  --app-icon '/Applications/Platypus.app/Contents/Resources/PlatypusDefault.icns'  \
  --author 'Carlo Zottmann <carlo@zottmann.org>' \
  --bundle-identifier 'org.zottmann.Bearing' \
  --background \
  --bundled-file ./src \
  --interface-type 'Status Menu'  \
  --interpreter '/usr/bin/ruby'  \
  --name 'Bearing'  \
  --overwrite \
  --status-item-kind 'Text' \
  --status-item-title 'B' \
  --status-item-sysfont \
  --uri-schemes 'bearing' \
  ./src/main.rb

mv ./src/Bearing.app ./dist/