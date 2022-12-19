#### SETUP

1. Set Azure subscription using ``az account set -s {sub_ID}``
2. Choose either bicep or azure CLI
    ***Bicep***: ``chmod +x main.sh && ./main.sh {RESOURCE_GROUP_NAME}``
    ***Azure CLI***: ``chmod +x simple.sh && ./simple.sh {RESOURCE_GROUP_NAME}``
3. Navigate to your Azure Devops project and go to Project Settings/Agent pools and click Add pool. 
4. Choose Azure virtual machine scale set as the pool type. Connect to your Azure subscription, and choose the newly created scale set. For the lowest possible costs, set ``number of agents to keep on standby`` to 0 and ``delay in minutes before deleting excess idle agents to 10``
