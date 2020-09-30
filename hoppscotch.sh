#!/usr/bin/env bash
# Copy this script to a directory within your $PATH and use it to launch the container

echo "Enabling XHost Forwarding"
xhost +local:docker

echo "Searching for Docker image ..."
DOCKER_IMAGE_ID=$(docker images -q hoppscotch:latest | head -n 1)
echo "Found and using ${DOCKER_IMAGE_ID}"

docker run --rm --privileged \
 --network host \
 -e DISPLAY=unix$DISPLAY \
 -v chromium_home:/home \
 -v /tmp/.X11-unix:/tmp/.X11-unix \
 -v /dev:/dev -v /run:/run \
 -v /etc/machine-id:/etc/machine-id \
 --ipc=host \
  ${DOCKER_IMAGE_ID}
