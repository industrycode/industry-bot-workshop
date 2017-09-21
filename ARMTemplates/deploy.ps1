# script parameters
param($SubscriptionId=$(throw "You must specify a subscription ID"),$ResourcePrefix=$(throw "You must specify a resource prefix"),$ResourceGroupLocation=$(throw "You must specify a resource group location"))

$ResourceGroupName = "cisbot" + $ResourcePrefix + "rg"

Write-Host "Logging in and selecting subscription" -ForegroundColor Green
#Login-AzureRmAccount
Select-AzureRmSubscription -SubscriptionId $SubscriptionId

Write-Host "Creating resource group" -ForegroundColor Green
New-AzureRmResourceGroup -Name $ResourceGroupName -Location $ResourceGroupLocation

Write-Host "Deploying storage account via ARM template" -ForegroundColor Green
$StorageAccountName = $ResourcePrefix + "sa"
$StorageDeploymentOutput = New-AzureRmResourceGroupDeployment -Name "StorageAccount" -ResourceGroupName $ResourceGroupName -TemplateFile ./1-storageAccount.json -resourcePrefix $ResourcePrefix

Write-Host "Creating containers in storage account" -ForegroundColor Green
#TODO: Come back and script container creation
#New-AzureStorageContainer -Name adf-resources
#New-AzureStorageContainer -Name interaction-data

Write-Host "Deploying ADLS via ARM template" -ForegroundColor Green
$DataLakeDeploymentOutput = New-AzureRmResourceGroupDeployment -Name "StorageAccount" -ResourceGroupName $ResourceGroupName -TemplateFile ./2-dataLakeStore.json -resourcePrefix $ResourcePrefix
