#!/bin/bash

set -euo pipefail

if [ -z "${IMAGE:-}" ]; then
  echo "ENV var \$IMAGE must be set with the image (dir) to build"
  exit 1
fi

if [ ! -d "$IMAGE" ]; then
  echo "Image (dir) \"$IMAGE\" could not be found. Options are:"
  # Find all directories in the current root, filter out any hidden dirs
  find . -maxdepth 1 -type d -printf '%f\n' | grep -v '^\..*'
fi

cd $IMAGE

if [ -f docker-compose.yml ]; then
  echo "> Building with docker-compose"
  docker-compose build main
elif [ -f Dockerfile ]; then
  echo "> Building with docker"
  docker build -f Dockerfile -t tmck-code/$IMAGE:latest .
fi

echo "> Build for \"$IMAGE\" complete!"
