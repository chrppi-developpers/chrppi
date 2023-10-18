# chrppi: *CHR++ interpreter on the Web*

This project is a website that implement an interpreter for [CHR++](https://gitlab.com/vynce/chrpp).

The website can be acessed localy on [http://localhost:8000](http://localhost:8000) and it is deployed on [LERIA](https://leria-etud.univ-angers.fr/~viallard).

This repository is hosted on [Github](https://github.com/chrppi-developpers/chrppi).

## LERIA deployment

### Create and go inside a KVM container

```bash
ssh -p 2019 viallard@leria-etud.univ-angers.fr
kvm.create
kvm.start
ssh-keygen -f "/home/viallard/.ssh/known_hosts" -R "etud-kvm-viallard"
kvm.connect
```

### Setup host and user

```bash
echo "127.0.0.1        ${HOSTNAME}" >> /etc/hosts
apt-get install sudo --yes
useradd app --create-home --shell /bin/bash
usermod --append --groups sudo app
passwd --delete app
su --login app
```

### Install Docker

These commands below are a modified version of installation instructions for *Docker Desktop* on Debian decripbed in the [official documentation](https://docs.docker.com/desktop/install/debian/).

```bash
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg --yes
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install the Docker packages
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin --yes

# Manage Docker as a non-root user 
# Source: https://docs.docker.com/engine/install/linux-postinstall
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
```

### Clone the repository and deploy the app

```bash
sudo apt-get install git --yes
git clone https://github.com/chrppi-developpers/chrppi
cd chrppi/env
./build.sh
./run_app.sh
```