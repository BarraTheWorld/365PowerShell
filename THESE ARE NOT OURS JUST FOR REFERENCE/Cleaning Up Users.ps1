# Version 1.01 

#For multiple users, enter username as ("user1", "user2", "user3", "....")
$users = @("User1", "User2")
$userAdmin = Read-Host
$userAdmin2 = Read-Host

if ($session -eq $null) {
    $UserCredential = Get-Credential
    $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
    Import-PSSession $Session
}

foreach ($u in $users) {
    Write-Host "Processing $u"
    
    $userObj = Get-ADUser $u -Property MemberOf,Manager;
    $groups = $userObj.MemberOf

    $null = Add-MailboxPermission -AccessRights FullAccess -Identity $userObj.UserPrincipalName -User $userAdmin -Confirm:$false
    $null = Add-MailboxPermission -AccessRights FullAccess -Identity $userObj.UserPrincipalName -User $userAdmin2 -Confirm:$false
    $null = Add-MailboxPermission -AccessRights FullAccess -Identity $userObj.UserPrincipalName -User (Get-ADUser ($userObj.Manager)).UserPrincipalName -Confirm:$false

    $null = Add-RecipientPermission $u -AccessRights SendAs -Trustee $userAdmin -Confirm:$false
    $null = Add-RecipientPermission $u -AccessRights SendAs -Trustee $userAdmin2 -Confirm:$false
    $null = Add-RecipientPermission $u -AccessRights SendAs -Trustee (Get-ADUser ($userObj.Manager)).UserPrincipalName -Confirm:$false

    $null = Set-Mailbox -Identity $u -GrantSendOnBehalfTo $userAdmin -Confirm:$false
    $null = Set-Mailbox -Identity $u -GrantSendOnBehalfTo $Admin2 -Confirm:$false
    $null = Set-Mailbox -Identity $u -GrantSendOnBehalfTo (Get-ADUser ($userObj.Manager)).UserPrincipalName -Confirm:$false

    foreach ($g in $groups) {
        $groupObj = get-ADGroup $g
        if ($groupObj.DistinguishedName -like "*,OU=Distribution Groups,OU=OULOCATION,DC=OULOCATION,DC=internal") {
            Write-Host ("Removing $u from " + $groupObj.Name)
            Remove-ADGroupMember -Identity $g -Members $u -Confirm:$false
        }
    }
    Remove-ADGroupMember -Identity "All Staff" -Members $u -Confirm:$false

    $manager = Get-ADUser ($userObj.Manager) -Properties Title,TelephoneNumber
    $mTitle = $manager.Title
    $mName = $manager.Name
    $mPhone = $manager.TelephoneNumber
    $mEmail = $manager.UserPrincipalName
    $uName = $userObj.Name

   }

       $message = @"
<html>
<head>
<style type="text/css" style="display:none">
<!--
p
        {margin-top:0;
        margin-bottom:0}
-->
</style>
</head>
<body dir="ltr">
<div id="divtagdefaultwrapper" style="font-size:12pt; color:#000000; background-color:#FFFFFF; font-family:Calibri,Aria
l,Helvetica,sans-serif">
Thank you for your email.&nbsp;
<div><br>
</div>
<div>$uname no longer works at COMPANY NAME.&nbsp;</div>
<div><br>
</div>
<div>For all matters please contact:&nbsp;</div>
<div>$mName ($mTitle)</div>
<div>Ph: +$mPhone</div>
<div>Email:&nbsp;<span>$mEmail</span></div>
<div><span style="font-size:12pt"><br>
</span></div>
<div><span style="font-size:12pt">Alternatively, you can contact Reception &#43;PHONE NUMBER between 9am-5pm who can also 
assist with directing your call to the appropriate person.&nbsp;</span></div>
<div><span style="font-size:12pt"><br>
</span></div>
<div><span style="font-size:12pt">Kind regards,&nbsp;</span></div>
<div><span style="font-size:12pt">COMPANY NAME&nbsp;</span></div>
<div><span style="font-size:12pt"><b>Please note that this mailbox is no longer being monitored</b></span></div>
</div>
</body>
</html>

"@
    Set-MailboxAutoReplyConfiguration -Identity $u -AutoReplyState Enabled -InternalMessage $message -ExternalMessage $message
    Set-Mailbox $userObj.UserPrincipalName -Type Shared
    Disable-ADAccount $userObj.DistinguishedName
    Set-ADObject $userObj.DistinguishedName -replace @{msExchHideFromAddressLists=$true}
    Set-ADObject $userObj.DistinguishedName –clear ShowinAddressBook
    Set-ADUser $userObj.DistinguishedName -DisplayName ("xEM - " + $userObj.GivenName + " " + $userObj.Surname)
    Rename-ADObject $userObj.DistinguishedName -NewName ("xEM - " + $userObj.GivenName + " " + $userObj.Surname)