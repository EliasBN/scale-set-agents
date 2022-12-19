#!/bin/bash

RG_NAME=$1

if [ -z "$1" ]; then
    echo 'You must supply a resource group name'
    exit 1
fi

readonly KV_NAME=$RG_NAME'-kv'
# use current sub
readonly SUB_ID=$(az account show --query id)
readonly LOCATION='norwayeast'
readonly SECRET_NAME="scale-set"

# Create required azure resources
az group create --name $RG_NAME --location $LOCATION
az keyvault create \
  --name $KV_NAME \
  --resource-group $RG_NAME \
  --location $LOCATION \
  --enabled-for-template-deployment true


# Make randomly generated password for Scale set and upload it to keyvault
az keyvault secret set --vault-name $KV_NAME --name $SECRET_NAME --value $(openssl rand -base64 12) > /dev/null 2>&1

readonly ADMIN_PASSWORD=$(az keyvault secret show --vault-name $KV_NAME --name $SECRET_NAME --query value)

az deployment group create \
  --name agent-dmeo \
  --resource-group $RG_NAME \
  --template-file './main.bicep' \
  --parameters adminPassword="$ADMIN_PASSWORD" resourceGroupName="$RG_NAME"