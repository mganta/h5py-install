#!/usr/bin/env bash

/usr/bin/anaconda/bin/conda install h5py

cd /tmp

git clone https://github.com/mganta/h5py-install.git

cd h5py-install

#sudo python setup.py install
sudo /usr/bin/anaconda/bin/conda-build h5spark
sudo /usr/bin/anaconda/bin/conda install --use-local h5spark
