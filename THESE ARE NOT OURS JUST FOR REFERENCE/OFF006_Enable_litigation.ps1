##Description: Office 365 Enable litigation hold for all users. Runs in regular Powershell
##Prerequisites: NA
##Author: Serge de Klerk
##Version: 1.0

# Get O365 administrator’s full O365 email, for example, name@domain.onmicrosoft.com and password
$UserCredential = Get-Credential

# Connect to O365
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection 
Import-PSSession $Session
CLS
# Set litigation hold for all users
$Users = Get-Mailbox -ResultSize Unlimited -Filter {RecipientTypeDetails -eq "UserMailbox"}
	foreach ($User in $Users) { 
		Write-Host -ForegroundColor yellow "Enabling litigation hold for $($user.alias)..." 
		Set-Mailbox $user.alias -LitigationHoldEnabled $True 
		Write-Host -ForegroundColor green "Litigation hold is now enabled for $($user.alias)..." 
		}