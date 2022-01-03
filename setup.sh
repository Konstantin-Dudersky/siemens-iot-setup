#!/bin/bash

echo
echo "-----> Existing python version:"
python3 -V

echo
echo "-----> Updating system:"
sudo apt update
sudo apt -y upgrade

echo
echo "-----> Create temp folder"
cd ~ || exit
mkdir temp && cd temp || exit

echo "-----> Install poetry:"
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 -
poetry completions bash > /etc/bash_completion.d/poetry.bash-completion
poetry config virtualenvs.in-project true

echo
echo "-----> Install python 3.10:"
sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev curl libbz2-dev liblzma-dev

wget https://www.python.org/ftp/python/3.10.1/Python-3.10.1.tgz
tar -xf Python-3.10.1.tgz && cd Python-3.10.1 || exit
./configure --enable-optimizations && make -j 2 # 2 - число ядер, nproc
sudo make altinstall

echo
echo "-----> Install python version"
python3.10 --version