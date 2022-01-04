#!/bin/bash

PYTHON_VER=3.10.1

echo
echo "-----> Disable clamav:"
sudo systemctl stop clamav-daemon
sudo systemctl disable clamav-daemon

echo
echo "-----> Upgrading system:"
sudo apt -y update
sudo apt -y upgrade

echo
echo "-----> Install software:"
sudo apt -y install curl htop nano git
sudo apt -y install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libsqlite3-dev
sudo apt -y install libssl-dev libsqlite3-dev libreadline-dev libffi-dev libbz2-dev liblzma-dev
sudo apt -y install python3-distutils

echo
echo "-----> Create temp folder:"
cd ~ || exit
mkdir inosat
cd inosat || exit

echo
echo "-----> Existing python version:"
python3 -V

echo
echo "-----> Install poetry:"
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 -
# shellcheck disable=SC1090
source ~/.poetry/env
poetry config virtualenvs.in-project true

echo
echo "-----> Install python 3.10:"
wget https://www.python.org/ftp/python/$PYTHON_VER/Python-$PYTHON_VER.tgz
tar -xf Python-$PYTHON_VER.tgz && cd Python-$PYTHON_VER || exit
./configure --enable-optimizations && make -j "$(nproc)"
sudo make altinstall

echo
echo "-----> Installed python version"
python3.10 --version
