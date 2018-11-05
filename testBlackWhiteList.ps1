$globalCred = get-credential

# USE WITH CAUTION DOESN'T WORK PROPERLY YET


function blockDomain ($domain){
    Write-Host -ForegroundColor Green "Adding the specified domain ($domain) the blocked domains list..."
    $blockedDomains = Get-HostedContentFilterPolicy -Identity Default | select-object BlockedSenderDomains | Out-String
    $blockedDomains
    $blockedDomains = $blockedDomains + $domain
    #Set-HostedContentFilterPolicy -Identity Default -BlockedSenderDomains $blockedDomains.BlockedSenderdomains.domain
    Write-Host -ForegroundColor Green "`nSuccess!"
    $blockedDomains
}

function allowDomain ($domain){
    Write-Host -ForegroundColor Green "Adding the specified domain ($domain) the allowed domains list..."
    Set-HostedContentFilterPolicy -Identity Default -AllowedSenderDomains $domain
    Write-Host -ForegroundColor Green "`nSuccess!"    
}

Function exchangeLogin {
    write-host "Connecting to Exchange online...."
    try {
        $exchangeSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/?proxyMethod=RPS -Credential $globalCred -Authentication Basic
        Import-PSSession $exchangeSession | Out-Null
        write-host -foregroundcolor green "Successfully connected to Exchange online!"
    } catch {
        write-host -foregroundcolor red "Failed to connect to Exchange online!"
    }
}
exchangeLogin



<#
This dont work yet but it's getting there

function blockEmail ($email){
    Write-Host -ForegroundColor Green "Adding the specified email ($email) the blocked senders list..."
    Set-HostedContentFilterPolicy -Identity Default -BlockedSenders $email
    Write-Host -ForegroundColor Green "`nSuccess!"
}

function allowEmail ($email){
    Write-Host -ForegroundColor Green "Adding the specified domain ($email) the allowed senders list..."
    Set-HostedContentFilterPolicy -Identity Default -AllowedSenders $email
    Write-Host -ForegroundColor Green "`nSuccess!"
}
#>