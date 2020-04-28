#! /bin/bash

URL=$(curl -sL https://minecraft.net/en-us/download/server/bedrock/ | grep bin-linux | sed "s/.*href=['\"]\([^'\"]*\)['\"].*/\1/g"); curl -O $URL

prev_files=("server.properties" "permissions.json" "valid_known_packs.json" "whitelist.json")

echo aaa

for prev_file in "${prev_files[@]}"
do
  if [ -f "data/$prev_file" ]; then
    cp "data/$prev_file" .
    pwd
  fi
done

echo bbb

s6-setuidgid abc unzip -q -o *.zip -d data
rm *.zip

echo ccc

for prev_file in "${prev_files[@]}"
do
  if [ -f "$prev_file" ]; then
    mv $prev_file "data/"
    chown abc:abc "data/$prev_file"
    pwd
  fi
done

echo ddd

cd data
# exec s6-setuidgid abc ./bedrock_server
pwd
s6-setuidgid abc ./bedrock_server
