Get-PSSession | Remove-PSSession

$globalCred = Get-Credential

exchangeLogin
securityLogin

#CHANGES MADE

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

Function securityLogin {
   write-host "Connecting to Security and Compliance Center...."
   try {
        connect-msolservice -credential $globalCred | Out-Null
        $securitySession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.compliance.protection.outlook.com/powershell-liveid/ -Credential $globalCred -Authentication Basic -AllowRedirection
        Import-PSSession $securitySession | Out-Null
        write-host -foregroundcolor green "Successfully connected to O365 Security and Compliance Center"
   } catch {
       write-host -ForegroundColor red "Failed to connect to eO365 Security and Compliance Center"
   }
}

Set-AdminAuditLogconfig -UnifiedAuditLogIngestionEnabled $true

New-RetentionCompliancePolicy -Name "7YR Retention" -ExchangeLocation All -SharePointLocation All  -ModernGroupLocation All -OneDriveLocation All -PublicFolderLocation All -Enabled $true
New-RetentionComplianceRule -Name "7YR Retention" -Policy "7YR Retention" -RetentionDuration 2555

Set-RetentionCompliancePolicy 