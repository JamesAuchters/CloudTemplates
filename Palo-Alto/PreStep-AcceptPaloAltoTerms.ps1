$AzureSubscriptionId = "YOUR_AZURE_SUBSCRIPTION_ID"
$aadTenantId = "<Active Directory ID>"

Connect-AzAccount -Tenant $aadTenantId
Select-AzSubscription -SubscriptionId $AzureSubscriptionId

Get-AzMarketplaceTerms -Name byol -Product vmseries1 -Publisher paloaltonetworks | Set-AzMarketplaceTerms -Accept