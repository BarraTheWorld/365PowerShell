<#INFO
Description: retrieves users that are inactive for more than X days
Prerequisites: NA
Author: Serge de Klerk
Version: 1.0
#>
 
import-module activedirectory  

# Make sure you change the domain to reflect the customers
$domain = Read-Host�
$DaysInactive = 90  
$time = (Get-Date).Adddays(-($DaysInactive)) 
  
# Get all AD User with lastLogonTimestamp less than our time
Get-ADUser -Filter {LastLogonTimeStamp -lt $time} -Properties LastLogonTimeStamp |
  
# Output Name and lastLogonTimestamp into CSV  
select-object Name,@{Name="Stamp"; Expression={[DateTime]::FromFileTime($_.lastLogonTimestamp).ToString('yyyy-MM-dd_hh:mm:ss')}} | export-csv OLD_User.csv -notypeinformation