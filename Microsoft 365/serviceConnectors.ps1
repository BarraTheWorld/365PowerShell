# -------------------------------------------------------------
# Main Service Connectors Script
#
# serviceConnectors.ps1
#
# Author: J Shand & B Western
# Version: All of them
# 
# 
#
# -------------------------------------------------------------

try { 
    Import-Module Microsoft.Online.SharePoint.PowerShell -DisableNameChecking
} catch {
    Install-Module Microsoft.Online.SharePoint.PowerShell -Force
    Import-Module Microsoft.Online.SharePoint.PowerShell -DisableNameChecking
}

try { 
    import-module msonline
} catch {
    install-module msonline -Force
    import-module msonline -Force
}

try {
    import-module MicrosoftTeams
} catch {
    install-module MicrosoftTeams -Force
    import-module MicrosoftTeams -Force
}

try { 
    import-module AzureAD
} catch {
    install-module AzureAD -Force
    import-module AzureAD -Force
}

try { 
    import-module AzureRM
} catch {
    install-module AzureRM -Force
    import-module AzureRM -Force
}

$globalCred = Get-Credential
$domain = Read-Host "Please enter your domain: "


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

# Connect to O365 admin portal using given credential
Function adminLogin {
    write-host "Connecting to Admin Portal...."
    try{
        Connect-msolservice -credential $globalCred | Out-Null
        write-host -ForegroundColor green "Successfully connected to O365 Admin Portal!"
    } catch {
        write-host -ForegroundColor red "Failed to connect to O365 admin portal!"
    }
}

# Connect to Sharepoint Online Service using given credentials
Function sharepointLogin{
    write-host "Connecting to Sharepoint online...."
    try {
        Connect-SPOService -Url https://$domain-admin.sharepoint.com -credential $globalCred | Out-Null
        Write-Host -ForegroundColor Green "Successfully connected to Sharepoint admin!"
    } catch {
        Write-Host -ForegroundColor red "Failed to connect to Sharepoint Admin"
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

Function azureLogin {
    write-host "Connecting to Azure AD service...."
    try {
        Connect-AzureAD -Credential $globalCred | Out-Null
        Write-Host -ForegroundColor green "Successfully connected to the Azure AD service"
    } catch {
        Write-Host -ForegroundColor red "Failed to conenct to the Azure AD service"
    }
}

Function connectAll {
    exchangeLogin
    adminLogin
    teamsLogin
    sharepointLogin
    securityLogin
    skypeLogin
    azureLogin
}

Import-Module Microsoft.Exchange.Management.ExoPowershellModule

Get-PSRepository

Find-Module "*exchange*"| Select-Object name

Connect-MsolService
Connect-AzureAD
Connect-AzureRmAccount
Connect-SPOService