#$delegatedTenantIDs = Get-MsolPartnerContract -All -DomainName (Where-Object DomainName -Match "onmicrosoft.com") | Select-Object TenantId | Get-MsolPartnerInformation | Select-Object PartnerCompanyName ,@{Label="TenantID";Expression={(Get-MsolPartnerContract -All -DomainName (Where-Object DomainName -Match "onmicrosoft.com") | Select-Object TenantIds)}}

$delegatedTenantIDs = Get-MsolPartnerContract -All -DomainName (Where-Object DomainName -Match "onmicrosoft.com") | Select-Object TenantId

foreach ($delegatedTenantID in $delegatedTenantIDs) {

$tenantCompanyName = Get-MsolPartnerInformation -TenantId $delegatedTenantID.tenantid.guid | Select-Object PartnerCompanyName
Get-MsolDomain -TenantId $delegatedTenantID.tenantid.guid | Where-Object Name -Match "onmicrosoft.com" | Select-Object Name ,@{Label="Company Name";Expression={($tenantCompanyName.PartnerCompanyName)}} ,@{Label="TenantID";Expression={($delegatedTenantID.tenantid.guid)}}

}

#Get-MsolDomain -TenantId 8caf2b22-cb83-4240-a5ff-d10ff987579b | Select-Object Name



