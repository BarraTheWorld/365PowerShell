$mailboxList = Get-Mailbox
Write-Host "Please Enter your Domain Extension for your tenant"
$domainExt = Read-Host

function removePermissions { #Remove Permissions for all mailboxes from John
foreach ($mailbox in $mailboxList){
 
   Remove-MailboxPermission -Identity $mailbox.PrimarySmtpAddress -User John
}
         }

function addPermissions { #Add Permissions based on each users email address and give user John Full Access
foreach ($mailbox in $mailboxList){
 
   Add-MailboxPermission -Identity $mailbox.PrimarySmtpAddress -User John -AccessRights FullAccess -AutoMapping:$True
}
                        }

function getFullPermissions { #Checks that each user has the correct access
foreach ($mailbox in $mailboxList){

   Get-MailboxPermission $mailbox.PrimarySmtpAddress | Where-Object -Property User -Match $domainExt | Select-Object @{Label="Mailbox";Expression={($mailbox.PrimarySMTPAddress)}}, User, AccessRights
}
                        }

function getSendAsPermissions { #Checks that each user has the correct permissions
foreach ($mailbox in $mailboxList){

   Get-RecipientPermission $mailbox.PrimarySmtpAddress | Where-Object -Property Trustee -Match $domainExt | Select-Object Identity, Trustee, AccessRights
}
                            }

function getFullCalendarPermissions { #Checks that each user has the correct access
foreach ($mailbox in $mailboxList){

   Get-MailboxPermission $mailbox.PrimarySmtpAddress:\Calendar | Where-Object -Property User -Match $domainExt | Select-Object @{Label="Calendar";Expression={($mailbox.PrimarySMTPAddress)}}, User, AccessRights
}
                        }

function removePermissionsStatic { #Remove permissions based on a single mailbox for each user
foreach ($mailbox in $mailboxList){
 
   Remove-MailboxPermission -Identity rentals@hirrr.com.au -User "$mailbox"
}
                                 }

function addPermissionsStatic { #Add permissions based on a single mailbox for each user
foreach ($mailbox in $mailboxList){

   Add-MailboxPermission -Identity rentals@hirr.com.au -User "$mailbox" -AccessRights FullAccess -AutoMapping:$false
}
                              }



