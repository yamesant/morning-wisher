param emailServices_communication_services_email_2401_name string = 'communication-services-email-2401'
param CommunicationServices_communication_service_2401_name string = 'communication-service-2401'

resource emailServices_communication_services_email_2401_name_resource 'Microsoft.Communication/emailServices@2023-06-01-preview' = {
  name: emailServices_communication_services_email_2401_name
  location: 'global'
  properties: {
    dataLocation: 'Australia'
  }
}

resource CommunicationServices_communication_service_2401_name_resource 'Microsoft.Communication/CommunicationServices@2023-06-01-preview' = {
  name: CommunicationServices_communication_service_2401_name
  location: 'global'
  properties: {
    dataLocation: 'Australia'
    linkedDomains: [
      emailServices_communication_services_email_2401_name_AzureManagedDomain.id
    ]
  }
}

resource emailServices_communication_services_email_2401_name_AzureManagedDomain 'Microsoft.Communication/emailServices/domains@2023-06-01-preview' = {
  parent: emailServices_communication_services_email_2401_name_resource
  name: 'AzureManagedDomain'
  location: 'global'
  properties: {
    domainManagement: 'AzureManaged'
    userEngagementTracking: 'Disabled'
  }
}

resource emailServices_communication_services_email_2401_name_azuremanageddomain_donotreply 'microsoft.communication/emailservices/domains/senderusernames@2023-06-01-preview' = {
  name: '${emailServices_communication_services_email_2401_name}/azuremanageddomain/donotreply'
  properties: {
    username: 'DoNotReply'
    displayName: 'DoNotReply'
  }
  dependsOn: [
    emailServices_communication_services_email_2401_name_AzureManagedDomain
    emailServices_communication_services_email_2401_name_resource
  ]
}
