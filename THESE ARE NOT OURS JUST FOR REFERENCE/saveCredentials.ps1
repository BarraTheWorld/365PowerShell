#Asks User for Credentials
$Global:globalCred = Get-Credential

#Exports Credentials to specified Location
$Global:globalCred | Export-Clixml -Path "${env:\userprofile}\OneDrive\Documents\WindowsPowerShell\M365.Cred"

#Imports Credentials from Specified Location to Variable
$Global:globalCred = Import-Clixml -Path "${env:\userprofile}\OneDrive\Documents\WindowsPowerShell\M365.Cred"