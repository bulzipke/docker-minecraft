#! /bin/bash

URL=$(curl -sL https://minecraft.net/en-us/download/server/bedrock/ | grep bin-linux | sed "s/.*href=['\"]\([^'\"]*\)['\"].*/\1/g"); curl -O $URL

prev_files=("server.properties" "permissions.json" "valid_known_packs.json" "whitelist.json")

for prev_file in "${prev_files[@]}"
do
  if [ -f "data/$prev_file" ]; then
    cp "data/$prev_file" .
  fi
done

s6-setuidgid abc unzip -q -o *.zip -d data
rm *.zip

for prev_file in "${prev_files[@]}"
do
  if [ -f "$prev_file" ]; then
    mv $prev_file "data/"
  fi
done

cd data
exec s6-setuidgid abc ./bedrock_server

