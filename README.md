# chrppi: *CHR++ interpreter on the Web*

This project is a website that implement an interpreter for [CHR++](https://gitlab.com/vynce/chrpp).

The website can be acessed localy on [http://localhost:8000](http://localhost) and it is deployed on [LERIA](https://leria-etud.univ-angers.fr/~viallard).

This repository is hosted on [Github](https://github.com/chrppi-developpers/chrppi).

## Technologies by dependance/usage

- Container engine (Podman)
	- C++ package manager (Conan)
		- Web framework (Drogon)
			- CSS framework (Bulma)
			- C++ interpreter (cling)
				- CHR++ compiler (chrppc)

## Requirements

- `Bash` Unix shell
- `Podman` container engine

## LERIA deployment

Deploy the app on the LERIA server.

More information on the [LERIA wiki](https://wiki.leria.univ-angers.fr/ua_members/cloud).

### Build and prepare the app

```bash
./env/build.sh
./env/inspect.sh
./build.sh
exit
sed --in-place --regexp-extended "s/(EXTERNAL_PORT=).*/\180/" app/.env
```

### Upload the app to LERIA

```bash
./env/clean.sh
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

### Set up the KVM container

```bash
echo "127.0.0.1 ${HOSTNAME}" >> /etc/hosts
apt-get install sudo --yes
useradd user --create-home --shell /bin/bash
usermod --append --groups sudo user
passwd --delete user
mv chrppi.tgz /home/user
su --login user
tar --verbose --extract --gzip --file chrppi.tgz
sudo rm chrppi.tgz
```

### Build and copy the app

```bash
cd chrppi/env
sudo apt-get install podman --yes
sudo loginctl enable-linger user
./build.sh
./root_copy.sh
```

### Run the app as root

```bash
sudo ./inspect.sh
./run.sh
```

## Rootless deployment

LERIA deployment use root because leria only expose port 80 and we can't modify network routing.

However, rootless deployement is more secure on most systems.

LERIA deployment is secure despite being rootful because podman runs in a Kernel-based Virtual Machine isolated from starwars.

To run the server in rootless mode you will need to select a registered or dynamic ports (a number between 1024 and 65535).

### Set external port

You will assign this value (`$port`) to the variable `EXTERNAL_PORT` in `app/.env` file.

```bash
sed --in-place --regexp-extended "s/(EXTERNAL_PORT=).*/\1$port/" app/.env 
```

### Set port forwarding

```bash
sudo iptables -t nat -I OUTPUT -p tcp -d 127.0.0.1 --dport 80 -j REDIRECT --to-ports $port
sudo iptables -t nat -I PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports $port
```

### Build and run the app

Then build and run the app with the current user on the select port.

```bash
./env/build.sh
./env/run.sh
```
