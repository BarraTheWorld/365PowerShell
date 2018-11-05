#-------------------------------- Way of Exporting For Each Object loop to Variable --------------------------------------#

Function exportTenantResults1 {

Set-Location C:\

$delegatedTenantIDs = Get-MsolPartnerContract -All | Select-Object TenantId
$tenantResults = @()

$tenantResults = foreach ($delegatedTenantID in $delegatedTenantIDs) {

$tenantCompanyName = Get-MsolPartnerInformation -TenantId $delegatedTenantID.tenantid.guid | Select-Object PartnerCompanyName
Get-MsolDomain -TenantId $delegatedTenantID.tenantid.guid | Where-Object Name -Match "onmicrosoft.com" | Select-Object @{Label="Company Name";Expression={($tenantCompanyName.PartnerCompanyName)}}, Name,@{Label="TenantID";Expression={($delegatedTenantID.tenantid.guid)}}

}

$tenantResults | export-Csv Results.csv

}

#-------------------------------- Way of Exporting For Each Object loop to Variable --------------------------------------#

Function exportTenantResults2 {

Set-Location C:\

$delegatedTenantIDs2 = Get-MsolPartnerContract -All -DomainName (Where-Object DomainName -Match "onmicrosoft.com") | Select-Object TenantId
$tenantResults2 = @()

foreach ($delegatedTenantID2 in $delegatedTenantIDs2) {

$tenantCompanyName2 = Get-MsolPartnerInformation -TenantId $delegatedTenantID2.tenantid.guid | Select-Object PartnerCompanyName
$tenantResults2 += Get-MsolDomain -TenantId $delegatedTenantID2.tenantid.guid | Where-Object Name -Match "onmicrosoft.com" | Select-Object @{Label="Company Name";Expression={($tenantCompanyName2.PartnerCompanyName)}},Name ,@{Label="TenantID";Expression={($delegatedTenantID2.tenantid.guid)}}

}

$tenantResults2 | Export-Csv Results2.csv

}


#------------------------------- Way of compairing the two CSV files -------------------------------------#
#-------------------------- Results Show that these two different methos get the same results-----------------------------#


#$tenantResults[188].Name - This just lets us see a particular parameter from a spot in the array


#------------------------ Way of Testing the differences ---------------------#

Function compareResults {

 $file1 = Import-Csv -Path "C:\Results.csv"
 $file2 = Import-Csv -Path "C:\Results2.csv"

 Compare-Object $file1 $file2 -Property Name -IncludeEqual
 Compare-Object $file1 $file2 -Property TenantId -IncludeEqual
 Compare-Object $file1 $file2 -Property "Company Name" -IncludeEqual

 }