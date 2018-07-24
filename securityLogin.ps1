Function securityLogin {
    #try {
        connect-msolservice -credential $globalCred
        $securitySession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.compliance.protection.outlook.com/powershell-liveid/ -Credential $globalCred -Authentication Basic -AllowRedirection -AllowClobber
        Import-PSSession $securitySession
        write-host -foregroundcolor green "Successfully connected to O365 Security and Compliance Center"
   #} catch {
        write-host -ForegroundColor red "Failed to connect to eO365 Security and Compliance Center"
   #}
}