1## Prerequisites = 1
## Ensure connection to Exchange Online prior to running commands

Get-mailbox | select-object displayname,litigationholdenabled ## Check litigation hold status

Get-mailbox | set-mailbox -litigationholdenabled $true ## Enable litigation hold for all mailboxes in tenant