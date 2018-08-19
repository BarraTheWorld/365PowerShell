. C:\Users\Jacob\Downloads\365PowerShell-master\365PowerShell-master\serviceConnectors.ps1
. C:\Users\Jacob\Downloads\365PowerShell-master\365PowerShell-master\domainLookup.ps1



write-host " Please select from the following options: `n"
write-host "1 - Connect to Exchange Online"
write-host "2 - Connect to Admin Portal"
write-host "3 - Connect to Teams Service"
write-host "4 - Connect to Sharepoint Admin Centre"
write-host "5 - Connect to Security and Compliance Centre"
write-host "6 - Connect to Skype for Business Online"
write-host "7 - Connect to Azure AD Service"
write-host "8 - Domain Lookup -> file"

$choice = Read-Host "`nEnter selection: "
switch($choice){
    '1'{
        $Global:globalCred = Get-Credential 
        exchangeLogin
        exchangeFunctions
    }'2'{
        $Global:globalCred = Get-Credential 
        adminLogin
    }'3'{
        $Global:globalCred = Get-Credential 
        teamsLogin
    }'4'{
        $Global:globalCred = Get-Credential 
        sharepointLogin
    }'5'{
        $Global:globalCred = Get-Credential 
        securityLogin
    }'6'{
        $Global:globalCred = Get-Credential 
        skypeLogin
    }'7'{
        $Global:globalCred = Get-Credential 
        azureLogin
    }'8'{
        dnsLookup
    }
}

Function global:exchangeFunctions {
    write-host "Welcome to Exchange Online! Please choose from the following options: "
    write-host "1 - Break everything"
    write-host "2 - Fix everything"

    $exchangeChoice = read-host "Enter selection: "
}

Function normalToShare {
    set-mailbox $emailAddress -Type shared
    Get-Mailbox -identity $emailAddress | fl recipienttypedetails
}