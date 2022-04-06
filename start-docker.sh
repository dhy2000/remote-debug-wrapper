#!/bin/bash

docker stop ssh-run ; docker rm ssh-run || true

docker run -dit   \
    --name=ssh-run \
    -p 10022:22 \
    --restart=always \
ssh-run:latest
