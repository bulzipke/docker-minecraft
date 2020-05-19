#!/bin/bash

if [ ! -f "/data/server.properties" ]; then
  exit 0
fi

echo STARTING MAP GENERATION
echo $(date)

echo CURRENT PID $$

echo CLEANING UP CURRENT WORLD
rm -rf /tmp/world

echo EXPORTING RUNNING WORLD
WORLD_NAME=$(cat /data/server.properties | grep level-name | grep -v \# | cut -d "=" -f2) && \
	cp -r "/data/worlds/${WORLD_NAME}" /tmp/world
chown -R abc:abc /tmp/world

echo GENERATING MAP
WORLDS=(0 1 2)
for WORLD in "${WORLDS[@]}"
do
  s6-setuidgid abc PapyrusCs --world=/tmp/world/db --output=/data/www --htmlfile=index.html --threads 16 -f png -q -1 -d $WORLD >> /logs/world_$WORLD.log 2>&1
done

echo DONE WITH MAP GENERATION
echo $(date)
