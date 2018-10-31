################################################################################################################################################################
# This script connects to Office 365 and creates a shared mailbox based on user input
#
# To run the script
#
# .\New-SharedMailbox.ps1
#
# More Information can be found here:
# https://www.cogmotive.com/blog/
#
# Author: 				Alan Byrne
# Version: 				1.0
# Last Modified Date: 	18/09/2012
# Last Modified By: 	Alan Byrne
################################################################################################################################################################


#Main
Function Main {

	#Remove all existing Powershell sessions
	Get-PSSession | Remove-PSSession
	
	#Get user inputs
	Write-Host "This script will create a new shared mailbox on Office 365" -foregroundcolor "yellow"
	""
	Write-Host "Enter your Office 365 Administrator Username and Password"
	$cred = Get-Credential
	$SharedMailboxUserName = Read-Host "Enter a username for the new Shared mailbox (e.g. shared@yourdomain.com)"
	$SharedMailboxDisplayName = Read-Host "Enter a friendly name for the new Shared mailbox (e.g. My Shared Mailbox)"
		
	#Get alias from username
	$intAtLocation = [int]$SharedMailboxUserName.indexof("@")
	$SharedMailboxAlias = $SharedMailboxUserName.substring(0, $intAtLocation)
	
	#Call ConnectTo-ExchangeOnline function with correct credentials
	try
	{
		""
		Write-Host "Connecting to Office 365..." -foregroundcolor "yellow"
		""
		$msoExchangeURL = “https://ps.outlook.com/powershell/”
		$session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri $msoExchangeURL -Credential $cred -Authentication Basic -AllowRedirection
		Import-PSSession $session			
	}
	catch
	{
		Write-Host "Unable to Connect to Office 365.  Did you enter the details correctly?" -foregroundcolor "red"
		write-host $error[0]
		return ""
	}
	
	#Create the new Shared mailbox
	try
	{
		""
		Write-Host "Creating Shared Mailbox..." -foregroundcolor "yellow"
		""
		New-Mailbox -Name $SharedMailboxDisplayName -Alias $SharedMailboxAlias -Shared -PrimarySMTPAddress $SharedMailboxUserName
	}
	catch
	{
		Write-Host "Unable to create Shared Mailbox:" -foregroundcolor "red"
		write-host $error[0]
		return ""
	}
	
	""
	Write-Host "Waiting for 10 seconds for the mailbox to be created..." -foregroundcolor "yellow"
	""
	Start-Sleep -s 10
	""
	Write-Host "Setting 5GB Quota on Mailbox..." -foregroundcolor "yellow"
	""
	
	try
	{
		Set-Mailbox $SharedMailboxAlias -ProhibitSendReceiveQuota 5GB -ProhibitSendQuota 4.75GB -IssueWarningQuota 4.5GB
	}
	catch
	{
		Write-Host "Unable to set Quota" -foregroundcolor "red"
		write-host $error[0]
		return ""
	}
	
	Write-Host "Shared mailbox created: $SharedMailboxUserName" -foregroundcolor "green"
	""
	
	#Prompt user to add permissions to mailbox
	$title = "Add Mailbox Permissions"
	$message = "Do you want to add permissions to this mailbox?"

	$yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "Add Mailbox Permissions."
	$no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", "I'm done for now."
	$options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)

	$result = $host.ui.PromptForChoice($title, $message, $options, 0) 
	
	while ($result -eq 0) 
	{
		""
		#User to add to mailbox
		$UserToPermission = Read-Host "Enter the username for the person or group you want to give access to this mailbox (e.g you@domain.com)"
		
		#Get Permission Type
		$title = "Permission Type"
		$message = "What kind of Permissions do you want to give this user?"

		$FullAccess = New-Object System.Management.Automation.Host.ChoiceDescription "&Full Access", ""
		$ReadOnly = New-Object System.Management.Automation.Host.ChoiceDescription "&Read Only", ""
		$options = [System.Management.Automation.Host.ChoiceDescription[]]($FullAccess, $ReadOnly)

		$PermissionType = $host.ui.PromptForChoice($title, $message, $options, 0) 
		
		#Send As Permissions?
		$title = "Send As Permissions"
		$message = "Do you want to allow this user to Send As this shared mailbox?"

		$yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", ""
		$no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", ""
		$options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)

		$SendAs = $host.ui.PromptForChoice($title, $message, $options, 0) 
		
		#AutoMap Mailbox
		$title = "Automap Mailbox"
		$message = "Do you want the Shared Mailbox to automatically appear in the users Outlook/OWA?"

		$yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", ""
		$no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", ""
		$options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)

		$AutoMap = $host.ui.PromptForChoice($title, $message, $options, 0) 
	
		#Set the Permissions
		if ($PermissionType -eq 0)
		{
			try
			{
				""
				Write-Host "Setting Full Access permissions on the shared mailbox"
				""
				if ($AutoMap -eq 0)
				{
					Add-MailboxPermission $SharedMailboxDisplayName -User $UserToPermission -AccessRights FullAccess -AutoMapping $true
				}
				else
				{	
					Add-MailboxPermission $SharedMailboxDisplayName -User $UserToPermission -AccessRights FullAccess -AutoMapping $false
				}
			}
			catch
			{
				Write-Host "Unable to set permissions" -foregroundcolor "red"
				write-host $error[0]
				return ""
			}
		}
		else
		{
			try
			{
				""
				Write-Host "Setting Read Only permissions on the shared mailbox"
				""
				if ($AutoMap -eq 0)
				{
					Add-MailboxPermission $SharedMailboxDisplayName -User $UserToPermission -AccessRights ReadPermission -AutoMapping $true
				}
				else
				{	
					Add-MailboxPermission $SharedMailboxDisplayName -User $UserToPermission -AccessRights ReadPermission -AutoMapping $false
				}
			}
			catch
			{
				Write-Host "Unable to set permissions" -foregroundcolor "red"
				write-host $error[0]
				return ""
			}
		}
		
		#Set sendas permissions if required
		if ($SendAs -eq 0)
		{
			try
			{
				Add-RecipientPermission $SharedMailboxDisplayName -Trustee $UserToPermission -AccessRights SendAs
			}
			catch
			{
				Write-Host "Unable to set send as permissions" -foregroundcolor "red"
				write-host $error[0]
				return ""
			}
		}
		
		#See if user wants to add additional permissions to mailbox
		$title = "Add more mailbox permissions"
		$message = "Do you want to add another permission to this mailbox?"

		$yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "Add Mailbox Permissions."
		$no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", "I'm done for now."
		$options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)

		$result = $host.ui.PromptForChoice($title, $message, $options, 0) 
	}

	#Clean up session
	Get-PSSession | Remove-PSSession
}

# Start script
. Main
