#!/bin/bash

docker build -t storj_setup .
docker run -itd --name storj_setup storj_setup
docker cp storj_setup:/root/.local/share/storj/identity .

mkdir storj

docker run --rm -e SETUP="true" \
    --mount type=bind,source=/root/storj-docker/identity/storagenode,destination=/app/identity \
    --mount type=bind,source=/root/storj-docker/storj/,destination=/app/config \
    --name storagenode storjlabs/storagenode:latest

docker run -d --restart unless-stopped --stop-timeout 300 \
    -p 28967:28967 \
    -p 127.0.0.1:14002:14002 \
    -e WALLET="0xxxx" \
    -e EMAIL="x@x.com" \
    -e ADDRESS="x.x.x.x:28967" \
    -e STORAGE="500GB" \
    --mount type=bind,source=/root/storj-docker/identity/storagenode,destination=/app/identity \
    --mount type=bind,source=/root/storj-docker/storj/,destination=/app/config \
    --name storagenode storjlabs/storagenode:latest
