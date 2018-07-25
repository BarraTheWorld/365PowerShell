Function exchangeLogin {
    try {
        $exchangeSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/?proxyMethod=RPS -Credential $globalCred -Authentication Basic
        Import-PSSession $exchangeSession
        write-host -foregroundcolor green "Successfully connected to Exchange online!"
    } catch {
        write-host -foregroundcolor red "Failed to connect to Exchange online!"
    }
}

# Connect to O365 admin portal using given credential
Function adminLogin {
    try{
        Connect-msolservice -credential $globalCred
        write-host -ForegroundColor green "Successfully connected to O365 Admin Portal!"
    } catch {
        write-host -ForegroundColor red "Failed to connect to O365 admin portal!"
    }
}

# Connect to Teams service using given credential
Function teamsLogin {
    try{
        Connect-MicrosoftTeams -credential $globalCred
        Write-Host -ForegroundColor Green "Successfully connected to Microsoft Teams service!"
    } catch {
        Write-Host -ForegroundColor Red "Failed to connect to Microsoft Teams service!"
    }
}

# Connect to Sharepoint Online Service using given credentials
Function sharepointLogin{
    try {
    } catch {
    }
    ## Need to prompt user for SPO site details
}

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
# Connect to Skype for Business Online Portal using given credentials
# CMDLet not working yet
Function skypeLogin {
    try {
        Connect-MsolService -Credential $globalCred
        $skypeSession = New-csonlinesession -credential $globalCred
        write-host -ForegroundColor green "Successfully connected to Skype for Business Online Services"
    } catch {
        write-host -ForegroundColor red "Failed to connect Skype for Business Online Services"
    }  
}

Function azureLogin {
    try {
        Connect-AzureAD -Credential $globalCred
        Write-Host -ForegroundColor green "Successfully connected to the Azure AD service"
    } catch {
        Write-Host -ForegroundColor red "Failed to conenct to the Azure AD service"
    }
}
