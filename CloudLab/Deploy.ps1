$deploymentName = "CloudLabDeployment-" + "$(Get-Date -Format hhmm-ddMMyyyy)"

#Sign in
Write-Host "Logging in..." -ForegroundColor Green
Login-AzAccount;

New-AzDeployment  -name "$($deploymentName)-RGDeployment2" -TemplateFile ResourceGroup.json -Location australiaeast

New-AzResourceGroupDeployment -ResourceGroupName Network-RG01 -Name "$($deploymentName)-Network" -TemplateFile .\NetworkResources.json

New-AzResourceGroupDeployment -ResourceGroupName ANALYTICS-RG01 -Name "$($deploymentName)-Analytics" -TemplateFile .\Analytics.json

New-AzResourceGroupDeployment -ResourceGroupName SERVER-RG01 -Name "$($deploymentName)-Servers" -TemplateFile .\servers.json