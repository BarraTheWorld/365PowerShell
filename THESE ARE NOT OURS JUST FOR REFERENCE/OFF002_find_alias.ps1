##Description: Script to find a SMTP alias in a Office 365 tenant. Runs in regular Powershell
##Prerequisites: NA
##Author: Serge de Klerk
##Version: 1.0

#Get O365 administrator’s full O365 email, for example, name@domain.onmicrosoft.com and password
$UserCredential = Get-Credential

# Connect to O365
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection 
Import-PSSession $Session

#Get SMTP alias youa re trying to find
$SMTPAlias = Read-Host -Prompt "Which SMTP address are you looking for?"

Get-Mailbox -Identity * | Where-Object {$_.EmailAddresses -like 'smtp:' + $SMTPAlias}| Format-List Identity, EmailAddresses
