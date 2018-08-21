## Prerequisites = 1
## Ensure you are connected to Exchange Online first

get-mailbox -resultsize unlimited ## Show all mailboxes in tenant
get-mailbox -resultsize unlimited | name,auditenabled ## Show whether auditing is enabled for each mailbox

get-mailbox -resultsize unlimited | set-mailbox -auditenabled $true ## enable auditing for all mailboxes
Discussion