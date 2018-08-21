LiveCred = Get-Credential 
; $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $LiveCred -Authentication Basic –AllowRedirection 
; Import-PSSession $Session 

#PLEASE NOTE THIS HAS BEEN ADDED TO MAKE THIS SCRIPT PUBLIC CUSTOMER INFORMATION WAS IN PLACE OF THESE VARIABLES 

Write-Output 'Please enter email address 1' 
$emailaddress1 = Read-Host
Write-Output 'Please enter email address 2'
$emailaddress2 = Read-Host

# Change the username below, (username:\calander)
; Get-MailboxFolderPermission $user :\calendar 

# Change Both Usernames Below, Second Username will be gaining PublishingEditor Access for First Username. 
;Add-MailboxFolderPermission -Identity $emailaddress1 :\calendar -user $emailaddress2 -AccessRights LimitedDetails
;#Remove-MailboxFolderPermission -Identity $emailaddress1 :\calendar –user $emailaddress2

; Read-Host -Prompt “Press Enter to exit”