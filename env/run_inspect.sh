#!/bin/bash
# Run the Docker container

# Diplay commands and end script at first command fail or use of an unset variable
set -o errexit -o nounset -o xtrace -o pipefail

# Go to the backend root folder
cd "$(dirname "$0")/.."

# Get the app environment variables
source app/.env

# Kill any runing container decendent from $APP_NAME image
PAST_CONTAINERS=$(docker container list --quiet --filter ancestor=$APP_NAME)
if [ -n "$PAST_CONTAINERS" ]
then
   docker container kill $PAST_CONTAINERS
fi

# Create and run a container
# - The network of the container is linked to the network of the host (--network)
# - Link files between the host and the container (--volume)
# - Interactive terminal (--interactive --tty)
# - The container is based on the latest $APP_NAME image
# - Execute run_app command
docker container run \
	--network host \
	--volume "$PWD/app:/home/app/backend" \
	--volume "$PWD/env/setup/include/utilities/bin:/home/app/bin" \
	--interactive --tty \
	$APP_NAME:latest

