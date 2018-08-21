## Prerequisites = 1
## Connect to Exchange Online before running these commands

Get-mailbox -resultsize unlimited | select name,retaindeleteditemsfor ## List current deleted item retention period

## Set all mailboxes to maximum 30 days deleted items
Get-mailbox -resultsize unlimited | set-mailbox -retaindeleteditemsfor 30