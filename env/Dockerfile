# The Linux distribution is debian 12
FROM debian:12

# The Id of the user is 1000 by default
ARG UID=1000

# Copy the environment setup scripts to image /tmp folder
ADD env/setup /tmp/setup

# Setup the user
RUN bash -c '/tmp/setup/user.sh $UID'

# Copy the backend to app home
ADD app /home/app/backend

# Finish setup
RUN bash '/tmp/setup/packages.sh'
RUN bash '/tmp/setup/utilities.sh'

# Define default user and  work directory
USER app
WORKDIR /home/app/backend