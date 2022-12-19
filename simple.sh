#!/bin/bash

RG_NAME=$1

if [ -z "$1" ]; then
    echo 'You must supply a resource group name'
    exit 1
fi

LOCATION="norwayeast"


az group create -n $RG_NAME -l $LOCATION

az vmss create \
--name "$RG_NAME-vmss" \
--resource-group $RG_NAME \
--image UbuntuLTS \
--vm-sku Standard_A1_v2 \
--location $LOCATION \
--storage-sku StandardSSD_LRS \
--authentication-type ssh \
--instance-count 0 \
--disable-overprovision \
--upgrade-policy-mode manual \
--single-placement-group false \
--platform-fault-domain-count 1 \
--load-balancer "" \
--generate-ssh-keys 