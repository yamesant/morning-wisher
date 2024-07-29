targetScope = 'subscription'

var communicationModuleName = 'communication'
var morningwisherModuleName = 'morningwisher'
var communicationGroupName = 'rg-${communicationModuleName}'
var morningwisherGroupName = 'rg-${morningwisherModuleName}'

resource communicationGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: communicationGroupName
  location: deployment().location
}

module communicationModule 'modules/communicationModule.bicep' = {
  scope: communicationGroup
  name: communicationModuleName
}

resource morningwisherGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: morningwisherGroupName
  location: deployment().location
}

module morningwisherModule 'modules/morningwisherModule.bicep' = {
  scope: morningwisherGroup
  name: morningwisherModuleName
}
