#!/bin/bash
# Build the Docker image

# Diplay commands and end script at first command fail or use of an unset variable
set -o errexit -o nounset -o xtrace -o pipefail

# Go to the backend root folder
cd "$(dirname "$0")/.."

# Get the app environment variables
source app/.env

# Store possible past images and containers IDs
PAST_IMAGES=$(docker images --all | (grep "^$APP_NAME " || true) | awk '{ print $3 }')
PAST_CONTAINERS=$(docker container list --quiet --filter ancestor=$APP_NAME)

# Build a Docker image:
# - Name the image $APP_NAME (--tag)
# - Send informations to the Dockerfile  (--build-arg)
# - Set the Dockerfile location (--file)
# - Use the current directory as build context
docker image build \
	--tag $APP_NAME \
	--build-arg UID=$UID \
  --file env/Dockerfile \
  .

# Delete past images if they exists
if [ -n "$PAST_IMAGES" ]
then

  # Kill any runing container decendent from $APP_NAME image
  # Else, run fail to kill running container from past image
  if [ -n "$PAST_CONTAINERS" ]
  then
    docker container kill $PAST_CONTAINERS
  fi

  docker image remove --force $PAST_IMAGES
fi