$mailboxList = Get-Mailbox

foreach ($mailbox in $mailboxList){

    Remove-MailboxPermission -Identity rentals@hirrr.com.au -User "$mailbox"

    Add-MailboxPermission -Identity rentals@hirr.com.au -User "$mailbox" -AccessRights FullAccess -AutoMapping:$false
}