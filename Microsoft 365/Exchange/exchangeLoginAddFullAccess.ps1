﻿Get-PSSession | Remove-PSSession

$globalCred = Get-Credential

Function exchangeLoginFullAccess {
    write-host "Connecting to Exchange online...."
    try {
        $exchangeSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/?proxyMethod=RPS -Credential $globalCred -Authentication Basic
        Import-PSSession $exchangeSession | Out-Null
        write-host -foregroundcolor green "Successfully connected to Exchange online!"

        
    } catch {
        write-host -foregroundcolor red "Failed to connect to Exchange online!"
    }
}
exchangeLoginFullAccess
