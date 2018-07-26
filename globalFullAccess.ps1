# Script to apply Full Access permission of one user to every mailbox in Exchange
# Done for Eco SUperfoods
# WARNING: THIS WILL PROVIDE FULL ACCESS TO EVERYONE FOR THIS ONE USER

Function globalFullAccess {
    Param($email)
    $usersEmail = $email
    try {
        Write-Host -ForegroundColor Magenta "`nProviding global full access permissions for user mailboxes to $email"
        Get-Mailbox -ResultSize unlimited -Filter {(RecipientTypeDetails -eq 'UserMailbox' ) -and (Alias -ne '$usersEmail')} | Add-MailboxPermission -User $usersEmail -AccessRights fullaccess -InheritanceType all -AutoMapping:$false
    } catch {
        write-host -ForegroundColor red "Issue trying to apply permissions - incorrect password or insufficient rights"
    }

    try {    
        Write-Host -ForegroundColor Magenta "`nProviding global full access permissions for shared mailboxes to $email"
        Get-Mailbox -ResultSize unlimited -Filter {(RecipientTypeDetails -eq 'SharedMailbox' ) -and (Alias -ne '$usersEmail')} | Add-MailboxPermission -User $usersEmail -AccessRights fullaccess -InheritanceType all -AutoMapping:$false
    } catch {
        write-host -ForegroundColor red "Issue trying to apply permissions - incorrect password or insufficient rights"
    }
    
}