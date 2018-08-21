## Prerequisites = 1
## ensure you connect to Exhanage OnLine first

get-mailbox -resultsize unlimited ## Show all tenant mailboxes
get-mailbox -resultsize unlimited | select name,auditenabled ## display all tenant mailboxes and whether auditing in enabled

## Get all mailboxes and loop through each and report auit actions that are set
$mailboxes = get-mailbox -resultsize unlimited ## save all tenant mailboxes to a variable
foreach ($mailbox in $mailboxes){ ## loop through every mailbox
    Write-host "Mailbox =",$mailbox.primarysmtpaddress ## show the mailbox email address
    Write-host "Audited items =", $mailbox.auditadmin ## show the current mailbox auditing settings
    write-host ## write a blank line
}

## Set all mailbox audting actions for each type of area that can be audited (Admin, Delegate and Owner)

Get-Mailbox -ResultSize Unlimited | Set-Mailbox -Auditadmin @{Add="Copy","Create","FolderBind","HardDelete","MessageBind","Move","MoveToDeletedItems","SendAs","SendOnBehalf","SoftDelete","Update","UpdateFolderPermissions","UpdateInboxRules","UpdateCalendarDelegation"}

Get-Mailbox -ResultSize Unlimited | Set-Mailbox –Auditdelegate @{Add="Create","FolderBind","HardDelete","Move","MoveToDeletedItems","SendAs","SendOnBehalf","SoftDelete","Update","UpdateFolderPermissions","UpdateInboxRules","UpdateCalendar"}
## "UpdateInboxRules","UpdateCalendarDelegation" currently produce an error but actually get set. Expect fix July 2018

Get-Mailbox -ResultSize Unlimited | Set-Mailbox –Auditowner @{Add="Create","HardDelete","Move","Mailboxlogin","MoveToDeletedItems","SoftDelete","Update","UpdateFolderPermissions","UpdateInboxRules","UpdateCalendarDelegation"}

Get-Mailbox -ResultSize Unlimited | select name, AuditLogAgeLimit ## View current mailbox audit limit, the default is 90 days

Get-Mailbox -ResultSize Unlimited | Set-Mailbox -AuditLogAgeLimit 180 ## Set each mailbox audit limit to 180 days