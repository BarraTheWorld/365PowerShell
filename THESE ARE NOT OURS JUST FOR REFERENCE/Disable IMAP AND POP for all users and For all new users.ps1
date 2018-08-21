## Prerequisites = 1
## Ensure connection to Exchange Online prior to running these commands

## Disable all mailbox POP3
Get-mailbox | set-casmailbox -popenabled $false

## Disable all mailbox IMAP
Get-mailbox | set-casmailbox -imapenabled $false

## Disable IMAP and POP3 for new users on any email plan
Get-CASMailboxPlan | Set-CASMailboxPlan -ImapEnabled $false -PopEnabled $false