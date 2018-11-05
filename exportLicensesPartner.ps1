$delegatedTenantIds = Get-MsolPartnerContract -All

foreach ($delegatedTenantId in $delegatedTenantIds) {

$tenantLicenses = Get-MsolAccountSku -TenantId $delegatedTenantId.TenantId
$tenantDomains = Get-MsolDomain -TenantId $delegatedTenantId.TenantId

 
            Write-host 
            Write-Host "Tenant Name: $($delegatedTenantId.Name)" -foregroundColor Yellow
            Write-Host
            Write-Host "Tenant Domains" $($tenantDomains.Name) -ForegroundColor Yellow
            write-host
            

        foreach ($tenantLicense in $tenantLicenses) {

            Write-Host
            Write-host "****************" -foregroundcolor Yellow
            Write-Host "License Type:"   $($tenantLicense.SkuPartNumber)  -foregroundColor White
            Write-Host "Active Units:"   $($tenantLicense.ActiveUnits)    -foregroundColor Green
            Write-host "Consumed Units:" $($tenantLicense.ConsumedUnits)  -foregroundColor Cyan
            Write-host "****************" -foregroundcolor Yellow

            }


}
