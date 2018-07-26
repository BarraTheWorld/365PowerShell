# Script to apply Full Access permission of one user to every mailbox in Exchange
# Done for Eco SUperfoods
# WARNING: THIS WILL PROVIDE FULL ACCESS TO EVERYONE FOR THIS ONE USER

Function globalSendAs {
    Param($email)
    $usersEmail = $email
    try {
        Write-Host -ForegroundColor Magenta "`nProviding global send as permissions for mailboxes to $email"
        Get-Recipient | Where-Object {($_.RecipientType -eq “MailUser”) -or ($_.RecipientType -eq “UserMailbox”)} | Add-RecipientPermission -AccessRights SendAs -Trustee $usersEmail -Confirm:$false
    } catch {
        write-host -ForegroundColor red "Issue trying to apply permissions - incorrect password or insufficient rights"
    }
}