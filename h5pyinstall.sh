#!/usr/bin/env bash

/usr/bin/anaconda/bin/conda install h5py

cd /tmp

rm -rf /tmp/h5spark

git clone https://github.com/mganta/h5spark.git

/usr/bin/anaconda/bin/conda update --yes conda-build

#cd h5spark
/usr/bin/anaconda/bin/conda-build h5spark
/usr/bin/anaconda/bin/conda install --yes --use-local h5spark
