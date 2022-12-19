param resourceGroupName string
@secure()
param adminPassword string 

module scaleset 'modules/scale-set/scale-set.bicep' = {
  name: 'agent-scale-set'
  scope: resourceGroup(resourceGroupName)
  params: {
    vmssName: 'agents'
    adminPassword: adminPassword
  }
}
