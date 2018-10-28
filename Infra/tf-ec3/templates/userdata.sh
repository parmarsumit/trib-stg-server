#!/usr/bin/env bash
apt-get update -y
apt-get install -y  python3-pil build-essential python3-pip
cd /opt
git clone https://github.com/Tribute-coop/server /opt/tribute
cd /srv
pip3 install virtualenv
virtualenv --python=python3 /srv/env
source /srv/env/bin/activate
/srv/env/bin/pip install -e /opt/tribute
mkdir -p media/CACHE
ilot migrate
ilot update
ilot collectstatic
ilot serve --ip=0.0.0.0 --port=9999 --no-ssl