# Script to apply Send on behalf of for one user to every mailbox in Exchange
# Done for Eco SUperfoods
# WARNING: THIS WILL ADD THE USER TO SEND ON BEHALF OF FOR ALL USERS

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
