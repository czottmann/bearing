#!/bin/bash

mkdir ./dist

/usr/local/bin/platypus \
  --app-icon '/Applications/Platypus.app/Contents/Resources/PlatypusDefault.icns'  \
  --author 'Carlo Zottmann <carlo@zottmann.org>' \
  --background \
  --bundled-file ./src \
  --interface-type 'None'  \
  --interpreter '/usr/bin/ruby'  \
  --name 'Bearing'  \
  --overwrite \
  --quit-after-execution \
  --uniform-type-identifiers 'public.item|public.folder' \
  --uri-schemes 'bearing' \
  ./src/bearing-handler.rb \
  ./dist/Bearing
