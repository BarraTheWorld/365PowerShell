#------------------Get Mailbox Permissions for each mailbox in a Tenant-------------------------------#
#
# Using PrimarySMTPAddress as the -Identity for Get-MailboxPermission
# Only show Users that have the Defined Domain in the User Parameter
# Select-Object defines custom label showing the current PrimarySMTPAddress as well as User and AccessRights Parameters
#


function getFullPermissions {

$mailboxList = $Null
$mailboxList = Get-Mailbox
Write-Host "Please Enter your Domain Extension for your tenant"
$domainExt = Read-Host

foreach ($mailbox in $mailboxList){

   Get-MailboxPermission $mailbox.PrimarySmtpAddress | Where-Object -Property User -Match $domainExt | Select-Object @{Label="Mailbox";Expression={($mailbox.PrimarySMTPAddress)}}, User, AccessRights
}
                        }


#------------------Get Mailbox Permissions for each mailbox in a Tenant-------------------------------#
#
# Using PrimarySMTPAddress as the -Identity for Get-RecipientPermission
# Only show Users that have the Defined Domain in the Trustee Parameter
# Select-Object Identity, Trustee and AccessRights Parameters
#


function getSendAsPermissions {

$mailboxList = $Null
$mailboxList = Get-Mailbox
Write-Host "Please Enter your Domain Extension for your tenant"
$domainExt = Read-Host

foreach ($mailbox in $mailboxList){

   Get-RecipientPermission $mailbox.PrimarySmtpAddress | Where-Object -Property Trustee -Match $domainExt | Select-Object Identity, Trustee, AccessRights
}
                            }


#------------------Remove Mailbox Permissions for each mailbox in a Tenant For a Specific User-------------------------------#
#
# Using PrimarySMTPAddress as the -Identity for Remove-MailboxPermission
# User $User will have their permissions removed from each mailbox
# Prompts the user for the 'User' without the domain
#


function removePermissions {

$mailboxList = $Null
$User = $Null
$mailboxList = Get-Mailbox
Write-Host "Please Enter the User that you would like their permissions removed"
Write-Host "ie 'john'@domain.com.au only portion required is John"
$User = Read-Host

foreach ($mailbox in $mailboxList){
 
   Remove-MailboxPermission -Identity $mailbox.PrimarySmtpAddress -User $User
}
         }


#------------------Add Mailbox Permissions for each mailbox in a Tenant For a Specific User-------------------------------#
#
# Using PrimarySMTPAddress as the -Identity for Add-MailboxPermission
# User $User will have their permissions Added to each mailbox
# Prompts the user for the 'User' without the domain
# AutoMapping True ensures that Outlook will show these mailboxes
#


function addPermissions {
foreach ($mailbox in $mailboxList){

$mailboxList = $Null
$mailboxList = Get-Mailbox
Write-Host "Please Enter the User that you would like their permissions removed"
Write-Host "ie 'john'@domain.com.au only portion required is John"
$User = Read-Host
 
   Add-MailboxPermission -Identity $mailbox.PrimarySmtpAddress -User $User -AccessRights FullAccess -AutoMapping:$True
}
                        }


#------------------Add Mailbox Permissions to a specific mailbox in a Tenant For a All Users-------------------------------#
#
# Using $staticMailbox as the -Identity for Add-MailboxPermission
# $mailbox will have their permissions Added to each mailbox
# Prompts the user for the 'Mailbox' with the domain
# AutoMapping $True ensures that Outlook will show these mailboxes $False will not auto add this to Outlook
#

function addPermissionsStatic {


$mailboxList = $Null
$staticMailbox = $null
$mailboxList = Get-Mailbox
Write-Host "Please Enter the Email Address that you would like the permissions added too"
Write-Host "ie john@domain.com.au including the domain"
$staticMailbox = Read-Host

foreach ($mailbox in $mailboxList){

   Add-MailboxPermission -Identity $staticMailbox -User "$mailbox" -AccessRights FullAccess -AutoMapping:$false
}
                              }


#------------------Remove Mailbox Permissions to a specific mailbox in a Tenant For a All Users-------------------------------#
#
# Using $staticMailbox as the -Identity for Remove-MailboxPermission
# Prompts the user for the 'Mailbox' with the domain
#


function removePermissionsStatic { 

$mailboxList = $Null
$staticMailbox = $null
$mailboxList = Get-Mailbox
Write-Host "Please Enter the Email Address that you would like the permissions added too"
Write-Host "ie john@domain.com.au including the domain"
$staticMailbox = Read-Host

foreach ($mailbox in $mailboxList){
 
   Remove-MailboxPermission -Identity $staticMailbox -User "$mailbox"
}
                                 }