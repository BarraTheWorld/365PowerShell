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

#--------------------Checks and Installs or Imports Required Modules for Connectors--------------------#

function importInstallModules{

#--------------------Import or Install & Import SharePoint Module--------------------#

try { 
    Import-Module Microsoft.Online.SharePoint.PowerShell -DisableNameChecking
} catch {
    Install-Module Microsoft.Online.SharePoint.PowerShell -Force
    Import-Module Microsoft.Online.SharePoint.PowerShell -DisableNameChecking
}

#--------------------Import or Install & Import msonline Module--------------------#

try { 
    import-module msonline
} catch {
    install-module msonline -Force
    import-module msonline -Force
}

#--------------------Import or Install & Import AzureAD Module--------------------#

try { 
    import-module AzureAD
} catch {
    install-module AzureAD -Force
    import-module AzureAD -Force
}

#--------------------Import or Install & Import AzureRM Module--------------------#

try { 
    import-module AzureRM
} catch {
    install-module AzureRM -Force
    import-module AzureRM -Force
}

}

#--------------------Login to Exchange Online--------------------#
Function exchangeLogin {

    $globalCred = Get-Credential

    write-host "Connecting to Exchange online...."

    try {
        $exchangeSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/?proxyMethod=RPS -Credential $globalCred -Authentication Basic
        Import-PSSession $exchangeSession | Out-Null
        Write-Host "Successfully connected to Exchange online!" -ForegroundColor green 
    } catch {
        Write-Host "Failed to connect to Exchange online!" -ForegroundColor red 
        Write-Host "Please make sure you entered the correct Credentials" -ForegroundColor Red
    }

    $globalCred = $null
}

#--------------------Login to O365 Portal--------------------#
Function portalLogin {

    $globalCred = Get-Credential

    write-host "Connecting to Admin Portal...."

    try{
        Connect-MsolService -credential $globalCred | Out-Null
        Write-Host "Successfully connected to O365 Admin Portal!" -ForegroundColor green
    } catch {
        Write-Host "Failed to connect to O365 admin portal!" -ForegroundColor red 
        Write-Host "Please make sure you entered the correct Credentials" -ForegroundColor Red
    }

    $globalCred = $null
}

#--------------------Login to SharePoint Online--------------------#
Function sharepointLogin{

    $globalCred = Get-Credential

    Write-Host "To connect to SharePoint Online Please enter the primary domain for the tenant" -ForegroundColor Yellow
    Write-Host "Example: https://domain-admin.SharePoint.com Where all we need is 'domain'" -ForegroundColor Yellow

    Write-Host "Please Enter a domain to connect to SharePoint Online" -ForegroundColor Red
    $domain = $null

    While($domain -eq $null){
        $domain= Read-Host "Enter a domain name (no prefix or suffix)" | ?{$_-match'^[a-zA-Z\s]+$'}
    }
    $username = $globalCred.UserName
    $length = $username.Length
    
    $atSymbol = $username.IndexOf("@") + 1
    $domainStrippedAt = $username.remove(0,$atSymbol)
    
    $firstDot = $domainStrippedAt.IndexOf(".")
    $domainStripped =  $domainStrippedAt.remove($firstDot)
    
    if ($domainStripped -eq $domain){

            write-host "Connecting to Sharepoint online...."

            try {
            Connect-MsolService -credential $globalCred | Out-Null
            Connect-SPOService -Url https://$domainStripped-admin.sharepoint.com -credential $globalCred | Out-Null
            Write-Host "Successfully connected to Sharepoint admin!" -ForegroundColor Green
            } catch {
            Write-Host "Failed to connect to SharePoint Admin!" -ForegroundColor red 
            Write-Host "Please make sure you entered the correct Credentials" -ForegroundColor Red
    }

    $globalCred = $null

        }else{

        Write-Host "Please make sure you have entered the domain correctly" -ForegroundColor Red

        }

    #checks to make sure that domain typed references domain cached in $globalCred 

    #passes domain to script

    #htrows error if anything is wrong at any point

    $globalCred = $null

}

#--------------------Login to Security Centre--------------------#
Function securityLogin {

    $globalCred = Get-Credential

   write-host "Connecting to Security and Compliance Center...."

   try {
        Connect-MsolService -credential $globalCred | Out-Null
        $securitySession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.compliance.protection.outlook.com/powershell-liveid/ -Credential $globalCred -Authentication Basic -AllowRedirection
        Import-PSSession $securitySession | Out-Null
        Write-Host "Successfully connected to O365 Security and Compliance Center" -ForegroundColor Green
   } catch {
        Write-Host "Failed to connect to Security and Compliance Center!" -ForegroundColor red 
        Write-Host "Please make sure you entered the correct Credentials" -ForegroundColor Red
   }

   $globalCred = $null
}

#--------------------Login to Azure Active Directory--------------------#
Function azureADLogin {

    $globalCred = Get-Credential

    write-host "Connecting to Azure AD service...."

    try {
        Connect-MsolService -credential $globalCred | Out-Null
        Connect-AzureAD -Credential $globalCred | Out-Null
        Write-Host "Successfully connected to the Azure AD service" -ForegroundColor Green
    } catch {
        Write-Host "Failed to connect to Azure Active Directory!" -ForegroundColor red 
        Write-Host "Please make sure you entered the correct Credentials" -ForegroundColor Red
    }

    $globalCred = $null
}

#--------------------Login to Azure Resource Management--------------------#
Function azureRMLogin {

    $globalCred = Get-Credential

    write-host "Connecting to Azure Resource Management...."

    try {
        Connect-MsolService -credential $globalCred | Out-Null
        Connect-AzureRmAccount -Credential $globalCred | Out-Null
        Write-Host "Successfully connected to the Azure AD service" -ForegroundColor Green
    } catch {
        Write-Host "Failed to connect to O365 admin portal!" -ForegroundColor red 
        Write-Host "Please make sure you entered the correct Credentials" -ForegroundColor Red
    }

    $globalCred = $null
}
