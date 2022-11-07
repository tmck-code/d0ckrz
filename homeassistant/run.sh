#!/bin/bash

set -euxo pipefail


# Runs the HA docker image maintained by 'linuxserver'
# (https://hub.docker.com/r/linuxserver/homeassistant)
#
function run_linuxserver() {
  docker run -d \
    --name=homeassistant \
    -e PUID=1000 \
    -e PGID=1000 \
    -e TZ=Australia/Melbourne \
    --net=host \
    -p 8123:8123 `#optional` \
    -v $PWD/homeassistant/config:/config \
    --restart unless-stopped \
    lscr.io/linuxserver/homeassistant:latest
    # --device /path/to/device:/path/to/device `#optional` \
}

# Runs the official HA docker image. Docs are sparse/don't exist
# (https://hub.docker.com/r/homeassistant/home-assistant)
#
function run_homeassistant() {
  docker run -d \
    --name=homeassistant \
    --net=host \
    --privileged \
    -v $PWD/homeassistant/config:/config \
    -v /etc/localtime:/etc/localtime:ro
    --restart unless-stopped \
    image: "ghcr.io/home-assistant/home-assistant:stable"
}

run_linuxserver
