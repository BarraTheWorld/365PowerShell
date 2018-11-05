Import-Module AzureAD
Import-Module MSOnline

$globalCred = Get-Credential

Connect-AzureAD -Credential $globalCred
Connect-MsolService -Credential $globalCred

$userName = "Jodie Robinson"

$tenantGroups = Get-AzureADGroup

foreach ($tenantGroup in $tenantGroups) {

Get-AzureADGroupMember -objectid $tenantGroup.objectid | Where-Object DisplayName -Match "$userName" | Select-Object DisplayName, @{Label="Group Name";Expression={($tenantGroup.DisplayName)}}

}