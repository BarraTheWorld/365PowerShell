New-Mailbox -Shared -Name "Masters Media" -DisplayName "Masters Media" -PrimarySmtpAddress media@mastersgames.com.au
Add-MailboxPermission -Identity media@mastersgames.com.au -User Intern1 -AccessRights FullAccess -InheritanceType All
Add-RecipientPermission -Identity media@mastersgames.com.au -Trustee Intern1 -AccessRights SendAs

Add-MailboxPermission -Identity media@mastersgames.com.au -User Intern2 -AccessRights FullAccess -InheritanceType All
Add-RecipientPermission -Identity media@mastersgames.com.au -Trustee Intern2 -AccessRights SendAs


Add-MailboxPermission -Identity media@mastersgames.com.au -User Intern3 -AccessRights FullAccess -InheritanceType All
Add-RecipientPermission -Identity media@mastersgames.com.au -Trustee Intern3 -AccessRights SendAs


Add-MailboxPermission -Identity media@mastersgames.com.au -User Intern4 -AccessRights FullAccess -InheritanceType All
Add-RecipientPermission -Identity media@mastersgames.com.au -Trustee Intern4 -AccessRights SendAs


Add-MailboxPermission -Identity media@mastersgames.com.au -User Stephen -AccessRights FullAccess -InheritanceType All
Add-RecipientPermission -Identity media@mastersgames.com.au -Trustee Stephen -AccessRights SendAs


Add-MailboxPermission -Identity media@mastersgames.com.au -User Wayne -AccessRights FullAccess -InheritanceType All
Add-RecipientPermission -Identity media@mastersgames.com.au -Trustee Wayne -AccessRights SendAs


Add-MailboxPermission -Identity media@mastersgames.com.au -User jeremy -AccessRights FullAccess -InheritanceType All
Add-RecipientPermission -Identity media@mastersgames.com.au -Trustee jeremy -AccessRights SendAs


Add-MailboxPermission -Identity media@mastersgames.com.au -User jacob -AccessRights FullAccess -InheritanceType All
Add-RecipientPermission -Identity media@mastersgames.com.au -Trustee jacob -AccessRights SendAs


Add-MailboxPermission -Identity media@mastersgames.com.au -User dylan -AccessRights FullAccess -InheritanceType All
Add-RecipientPermission -Identity media@mastersgames.com.au -Trustee dylan -AccessRights SendAs






