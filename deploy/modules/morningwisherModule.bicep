param communicationGroupName string
param communicationServicesName string

var functionAppName = 'morningwisher-${uniqueString(resourceGroup().id)}'
var storageAccountName = substring('morningwisher${uniqueString(resourceGroup().id)}', 0, 24)
var appServicePlanName = 'morningwisher'

resource communicationServices 'Microsoft.Communication/CommunicationServices@2023-06-01-preview' existing = {
  name: communicationServicesName
  scope: resourceGroup(communicationGroupName)
}

resource functionApp 'Microsoft.Web/sites@2023-12-01' = {
  name: functionAppName
  kind: 'functionapp,linux'
  location: resourceGroup().location
  properties: {
    siteConfig: {
      appSettings: [
        {
          name: 'EmailCommunicationConfig__ConnectionString'
          value: communicationServices.listKeys().primaryConnectionString
        }
        // {
        //   name: 'EmailCommunicationConfig__RecipientAddress'
        //   value: 
        // }
        // {
        //   name: 'EmailCommunicationConfig__SenderAddress'
        //   value: 
        // }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'dotnet-isolated'
        }
        {
          name: 'WEBSITE_USE_PLACEHOLDER_DOTNETISOLATED'
          value: '1'
        }
        {
          name: 'AzureWebJobsStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccountName};AccountKey=${listKeys(storageAccount.id,'2019-06-01').keys[0].value};EndpointSuffix=core.windows.net'
        }
        {
          name: 'WEBSITE_CONTENTAZUREFILECONNECTIONSTRING'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccountName};AccountKey=${listKeys(storageAccount.id,'2019-06-01').keys[0].value};EndpointSuffix=core.windows.net'
        }
      ]
      linuxFxVersion: 'DOTNET-ISOLATED|8.0'
    }
    serverFarmId: appServicePlan.id
  }
}

resource scm 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2023-12-01' = {
  parent: functionApp
  name: 'scm'
  properties: {
    allow: true
  }
}

resource ftp 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2023-12-01' = {
  parent: functionApp
  name: 'ftp'
  properties: {
    allow: true
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: appServicePlanName
  location: resourceGroup().location
  kind: 'functionapp'
  properties: {
    reserved: true
  }
  sku: {
    tier: 'Dynamic'
    name: 'Y1'
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccountName
  location: resourceGroup().location
  kind: 'Storage'
  sku: {
    name: 'Standard_LRS'
  }
}
