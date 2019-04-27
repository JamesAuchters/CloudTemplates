az group create \
    --name AzureBootCamp-RG01 \
    --location australiaeast

az group deployment create --resource-group AzureBootCamp-RG01 --template-file git StorageAccount.json