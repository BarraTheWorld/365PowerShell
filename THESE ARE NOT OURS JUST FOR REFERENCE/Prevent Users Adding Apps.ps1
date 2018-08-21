## Prerequisites = 1
## Requires connection to Exchange Online modules

Get-MsolCompanyInformation | fl DisplayName,UsersPermissionToUserConsentToAppEnabled ## Display the current setting

set-MsolCompanysettings -UsersPermissionToUserConsentToAppEnabled $false ## Disable ability to add apps