var emailServicesName = 'email-services-${uniqueString(resourceGroup().id)}'
var communicationServicesName = 'communication-services-${uniqueString(resourceGroup().id)}'
var emailDomainName = 'AzureManagedDomain'

resource emailServices 'Microsoft.Communication/emailServices@2023-06-01-preview' = {
  name: emailServicesName
  location: 'global'
  properties: {
    dataLocation: 'Australia'
  }
}

resource communicationServices 'Microsoft.Communication/CommunicationServices@2023-06-01-preview' = {
  name: communicationServicesName
  location: 'global'
  properties: {
    dataLocation: 'Australia'
    linkedDomains: [
      emailDomain.id
    ]
  }
}

resource emailDomain 'Microsoft.Communication/emailServices/domains@2023-06-01-preview' = {
  parent: emailServices
  name: emailDomainName
  location: 'global'
  properties: {
    domainManagement: 'AzureManaged'
    userEngagementTracking: 'Disabled'
  }
}

resource emailSender 'microsoft.communication/emailservices/domains/senderusernames@2023-06-01-preview' = {
  name: '${emailServicesName}/azuremanageddomain/donotreply'
  properties: {
    username: 'DoNotReply'
    displayName: 'DoNotReply'
  }
  dependsOn: [
    emailDomain
    emailServices
  ]
}
