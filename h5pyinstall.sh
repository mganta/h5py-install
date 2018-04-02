#!/usr/bin/env bash

/usr/bin/anaconda/bin/conda install h5py

git clone https://github.com/mganta/h5py-install.git

cd h5py-install

python setup.py install
