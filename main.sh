#!/bin/bash

readonly RG_NAME='nkom-test'
readonly KV_NAME=$RG_NAME'-kv'
# use current sub
readonly SUB_ID=$(az account show --query id)
readonly LOCATION='westeurope'

# Create required azure resources
az group create --name $RG_NAME --location $LOCATION
az keyvault create \
  --name $KV_NAME \
  --resource-group $RG_NAME \
  --location $LOCATION \
  --enabled-for-template-deployment true

# Make randomly generated password for Scale set and upload it to keyvault
az keyvault secret set --vault-name $KV_NAME --name "testPassword" --value $(openssl rand -base64 12) > /dev/null 2>&1

readonly ADMIN_PASSWORD=$(az keyvault secret show --vault-name $KV_NAME --name "testPassword" --query value)

az deployment group create \
  --name nkom-demo \
  --resource-group $RG_NAME \
  --template-file './main.bicep' \
  --parameters adminPassword="$ADMIN_PASSWORD" resourceGroupName="$RG_NAME"