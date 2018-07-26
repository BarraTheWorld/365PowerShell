# Script to apply Full Access permission of one user to every mailbox in Exchange
# Done for Eco SUperfoods
# WARNING: THIS WILL PROVIDE FULL ACCESS TO EVERYONE FOR THIS ONE USER

Function globalSendOnBehalf {
    Param($email)
    $usersEmail = $email
    try {
        Write-Host -ForegroundColor Magenta "`nProviding global send on behalf permissions for mailboxes to $email"
        Get-Recipient | Where-Object {($_.RecipientType -eq “MailUser”) -or ($_.RecipientType -eq “UserMailbox”)} | Set-Mailbox -GrantSendOnBehalfTo $usersEmail
    
    } catch {
        write-host -ForegroundColor red "Issue trying to apply permissions - incorrect password or insufficient rights"
    }
}