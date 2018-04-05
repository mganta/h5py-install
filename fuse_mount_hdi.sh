#! /bin/bash

usage() {
    echo ""
    echo "Usage: sudo -E bash mount_storage.sh <storage-account-name> <storage-account-key> <container-name>" ;
    exit 132;
}

#validate user input
if [ -z "$1" ]
    then
        usage
        echo "Storage account name must be provided."
        exit 137
fi

if [ -z "$2" ]
    then
        usage
        echo "Storage account key must be provided."
        exit 138
fi

if [ -z "$3" ]
    then
        usage
        echo "Container name must be provided."
        exit 139
fi



STORAGEACCOUNTNAME=$1
if [[ $1 == *blob.core.windows.net* ]]; then
    echo "Extracting storage account name from $1"
    STORAGEACCOUNTNAME=$(echo $1 | cut -d'.' -f 1)
fi
echo STORAGE ACCOUNT IS: $STORAGEACCOUNTNAME

STORAGEACCOUNTKEY=$2
CONTAINERNAME=$3

#install blobfuse
wget https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get update
sudo apt-get install blobfuse

#create tmp
sudo mkdir /mnt/blobfusetmp
sudo chown root:root /mnt/blobfusetmp

#create fuse config
mkdir /fuseconfig

echo "accountName $STORAGEACCOUNTNAME" > /fuseconfig/fuse_connection.cfg
echo "accountKey $STORAGEACCOUNTKEY" >> /fuseconfig/fuse_connection.cfg
echo "containerName $CONTAINERNAME" >> /fuseconfig/fuse_connection.cfg

chmod 700 /fuseconfig/fuse_connection.cfg

#create fuse container
mkdir /fusecontainer

chmod 755 /fusecontainer

sudo blobfuse /fusecontainer --tmp-path=/mnt/blobfusetmp  --config-file=/fuseconfig/fuse_connection.cfg -o attr_timeout=240 -o entry_timeout=240 -o negative_timeout=120 -o allow_other
