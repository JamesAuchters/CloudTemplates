$deploymentName = "CloudLab"

#Sign in
Write-Host "Logging in..." -ForegroundColor Green
Login-AzAccount;

New-AzDeployment  -name "$($deploymentName)-RGDeployment" -TemplateFile ResourceGroup.json

New-AzResourceGroupDeployment -ResourceGroupName Network-RG01 -Name "$($deploymentName)-Network" -TemplateFile .\NetworkResources.json

New-AzResourceGroupDeployment -ResourceGroupName ANALYTICS-RG011 -Name "$($deploymentName)-Analytics" -TemplateFile .\Analytics.json