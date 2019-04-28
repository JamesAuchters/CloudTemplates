$deploymentName = "CloudLabDeployment-$(Get-Date -Format hhmm-ddMMyyyy)"

#Sign in
Write-Host "Logging in..." -ForegroundColor Green
Login-AzAccount;

New-AzDeployment  -name "$deploymentName-RGDeployment" -TemplateFile ResourceGroup.json -Location australiaeast

$cloudShellDeployment = New-AzResourceGroupDeployment -ResourceGroupName CLOUDSHELL-RG01 -Name "$deploymentName-CloudShell"  -TemplateFile .\CloudShell.json

$AnalyticsDeployment = New-AzResourceGroupDeployment -ResourceGroupName ANALYTICS-RG01 -Name "$deploymentName-Analytics" -TemplateFile .\Analytics.json

$NetworkDeployment = New-AzResourceGroupDeployment -ResourceGroupName Network-RG01 -Name "$deploymentName-Network" -TemplateFile .\NetworkResources.json -OMSWorkspaceResourceId $AnalyticsDeployment.outputs['workspaceResourceId'].value

$ServerDeployment = New-AzResourceGroupDeployment -ResourceGroupName SERVER-RG01 -Name "$deploymentName-Servers" -TemplateFile .\servers.json -OMSWorkspaceResourceId $AnalyticsDeployment.outputs['workspaceResourceId'].value