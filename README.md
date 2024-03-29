# chrppi: *CHR++ interpreter on the Web*

This project is a website that implement an interpreter for [CHR++](https://gitlab.com/vynce/chrpp).

The website can be acessed localy on [http://localhost:8000](http://localhost) and it is deployed on [LERIA](https://etud-kvm-viallard.leria-etud.univ-angers.fr).

This repository is hosted on [Github](https://github.com/chrppi-developpers/chrppi).

## Technologies by dependance/usage

- Container engine (Podman)
	- C++ package manager (Conan)
		- C++ web framework (Drogon)
			- CSS framework (Bulma)
			- C++ interpreter (cling)
			- CHR++ compiler (chrppc)

## Requirements

Any machine running macOS or GNU/Linux should be supported, but we recommend using a `Debian` based operating system as we did.

The absolute path of the root folder should not contain spaces in order to allow compilation (excecution of `app/build.sh` and `app/run.sh`).

## LERIA deployment

Deploy the app on the LERIA server.

More informations on the [LERIA wiki](https://wiki.leria.univ-angers.fr/ua_members/cloud).

### Build and prepare the app

```bash
./env/build.sh
./env/inspect.sh
./build.sh
exit
sed --in-place --regexp-extended "s/(INTERNAL_PORT=).*/\180/" app/.env
sed --in-place --regexp-extended "s/(BUILD_TYPE=).*/\1Release/" app/.env
```

### Upload the app to LERIA

```bash
cd ..
tar --verbose --create --gzip --file chrppi.tgz chrppi
scp -P 2019 chrppi.tgz viallard@leria-etud.univ-angers.fr:~
```

### Create and connect to new KVM container

```bash
ssh -p 2019 viallard@leria-etud.univ-angers.fr
kvm.delete
kvm.create
scp chrppi.tgz root@etud-kvm-viallard:~
kvm.connect
```

### Extract the app

```bash
tar --verbose --extract --gzip --file chrppi.tgz
rm chrppi.tgz
mv chrppi /media/user
```
### Install third-party

```bash
cd /media/user/app/third-party
apt install cmake --yes
cmake --install llvm/build
cmake --install chrpp/build
cp llvm/build/lib/cmake/cling/ClingTargets.cmake /usr/local/lib/cmake/cling
```

### Install required Debian packages

```bash
cd ..
sed --in-place 's/bullseye/bookworm/' /etc/apt/sources.list
apt update
export DEBIAN_FRONTEND=noninteractive && apt upgrade --yes
apt install g++ --yes
```

### Execute the app as root

```bash
./execute.sh
```

### Access to the app

Got to https://etud-kvm-viallard.leria-etud.univ-angers.fr

## Rootfull Podman deployment

Deploy the app on any server with Podman in rootfull mode.

Use this method when you can't modify network routing.

Else, use rootless Podman deployment.

### Set ports

```bash
cd app
sed --in-place --regexp-extended "s/(INTERNAL_PORT=).*/\18080/" .env
sed --in-place --regexp-extended "s/(EXTERNAL_PORT=).*/\180/" .env
```

### Install and configure Podman

```bash
sudo apt-get install podman --yes
sudo loginctl enable-linger $USER
```

### Build and copy the app

```bash
cd ../env
./build.sh
./root_copy.sh
```

### Execute the app as root

```bash
sudo ./run.sh
```

## Rootless Podman deployment

Deploy the app on any server with Podman in rootless mode.

Rootfull deployment is needed when we can't modify network routing.

However, rootless deployement is more secure on most systems.

### Set internal port

Internal port is not important as long as its value is a registered or a dynamic ports (a number between 1024 and 65535):

```bash
sed --in-place --regexp-extended "s/(INTERNAL_PORT=).*/\18080/" app/.env 
```

### Set external port and port forwarding

To run the app in rootless mode you will need to select a registered or a dynamic ports.

You will assign this value (`$port`) to the variable `EXTERNAL_PORT` in `app/.env` file:

```bash
sed --in-place --regexp-extended "s/(EXTERNAL_PORT=).*/\1$port/" app/.env 
```

You will then map this port to port 80 with port forwarding:

```bash
sudo iptables -t nat -I OUTPUT -p tcp -d 127.0.0.1 --dport 80 -j REDIRECT --to-ports $port
sudo iptables -t nat -I PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports $port
```

### Install and configure Podman

```bash
sudo apt-get install podman --yes
sudo loginctl enable-linger $USER
```

### Build and run the app

Then build and run the app with the current user on the select port.

```bash
cd env
./build.sh
./run.sh
```
