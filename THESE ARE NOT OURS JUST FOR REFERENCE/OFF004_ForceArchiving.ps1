##Description: Script to force email archiving policies to run on a Office 365 mailbox
##Prerequisites: NA
##Author: Serge de Klerk
##Version: 1.0

# Get O365 administrator’s full O365 email, for example, name@domain.onmicrosoft.com and password
$UserCredential = Get-Credential

# Connect to O365
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection 
Import-PSSession $Session

$Identity = Read-Host 'Enter the mailbox identity, i.e. first.last'
Start-ManagedFolderAssistant -Identity $Identity
Write-Host 'The archiving will commence in a few minutes. The sript has finished.'