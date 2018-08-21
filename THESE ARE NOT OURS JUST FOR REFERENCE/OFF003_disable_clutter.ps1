##Description: Script to disable Clutter in Office 365. Runs in regular Powershell
##Prerequisites: NA
##Author: Serge de Klerk
##Version: 1.0

# Get O365 administrator’s full O365 email, for example, name@domain.onmicrosoft.com and password
$UserCredential = Get-Credential

# Connect to O365
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection 
Import-PSSession $Session

# If you want to disable Clutter for only 1 mailbox, uncomment the lines below
# $Mailbox = Read-Host -Prompt "For which mailbox do you want to disable Clutter, i.e. user@domain.com.au"
# Set-Clutter -Identity $Mailbox -Enable $false

# If you want to disable Clutter for all mailboxes, uncomment the lines below
# Get-Mailbox -ResultSize Unlimited | Set-Clutter -Enable $True