#!/bin/bash
# Inspect the Docker container

# Diplay commands and end script at first command fail or use of an unset variable
set -o errexit -o nounset -o xtrace -o pipefail

# Go to the backend root folder
cd "$(dirname "$0")/.."

# Get the app environment variables
source app/.env

# Fetch the running container ID that descend from the image $APP_NAME
CONTAINER_ID=$(docker ps --quiet --filter ancestor=$APP_NAME)

# Enter in Bash inside the running container
docker container exec \
	--interactive --tty \
	$CONTAINER_ID \
	bash