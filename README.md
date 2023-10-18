# chrppi: *CHR++ interpreter on the Web*

This project is a website that implement an interpreter for [CHR++](https://gitlab.com/vynce/chrpp).

The website can be acessed localy on [http://localhost:8000](http://localhost:8000) and it is deployed on [LERIA](https://leria-etud.univ-angers.fr/~viallard).

This repository is hosted on [Github](https://github.com/chrppi-developpers/chrppi).

## LERIA deployment

```bash
ssh -p 2019 viallard@leria-etud.univ-angers.fr
kvm.create
kvm.start
ssh-keygen -f "/home/viallard/.ssh/known_hosts" -R "etud-kvm-viallard"
kvm.connect
git clone https://github.com/chrppi-developpers/chrppi
cd chrppi/env
./build.sh
./run_app.sh
```