# Please note this will NOT work for cloud only users, they MUST 
# use the MSOnline service (don't as don't tell)

Function passwordReset {
    Param ($userAccount, $newPassword )

    $userEmail = $userAccount
    $password = $newPassword | ConvertTo-SecureString -AsPlainText -Force

    Set-Mailbox $userAccount -Password $password
}

passwordReset adelev 12345678