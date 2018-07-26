# Script to connect to different Microsoft services
#
# Author: Jacob Shand & Benjamin Western
# Date: 24/07/2018
# 

# Link files to this script (master
# Same folder, called functions.ps1
#. C:\Users\%username%\OneDrive\Documents\WindowsPowerShell\activityAlerts.ps1
#. C:\Users\%username%\OneDrive\Documents\WindowsPowerShell\serviceConnectors.ps1

# Prompt user for credential to use for services
 
# Define Global credential Variable 
$Global:globalCred

## Variables
$credPath = "${env:\userprofile}\OneDrive\Documents\PowerShell\Global.Cred"   ## local file with credentials if required

#Check if Cred File exists in location - Prompts user if it doesn't and creates it
#Else just assigns the $Global:globalCred as the Cred File
Function checkCredentials{

## Get tenant login credentials
if (Test-Path -Path $credPath) {

    ## Get creds from local file
    $Global:globalCred = import-clixml -Path $credPath
}
else {
    ## Get creds manually
    $Global:globalCred = get-credential | Export-Clixml -Path $credPath
}
}

# Set global error pref so we can catch errors when logging in
$Global:ErrorActionPreference='stop'

# Check if modules are installed, if not install and import
try { 
    import-module msonline
} catch {
    install-module msonline -Force
    import-module msonline -Force
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

<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    ONGC Systems Cloud Management
#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

#region begin GUI{ 

$MainForm                        = New-Object system.Windows.Forms.Form
$MainForm.ClientSize             = '400,400'
$MainForm.text                   = "Form"
$MainForm.BackColor              = "#ffffff"
$MainForm.TopMost                = $false

$SharePointButton                = New-Object system.Windows.Forms.Button
$SharePointButton.BackColor      = "#4a90e2"
$SharePointButton.text           = "SharePoint"
$SharePointButton.width          = 159
$SharePointButton.height         = 67
$SharePointButton.location       = New-Object System.Drawing.Point(18,23)
$SharePointButton.Font           = 'Microsoft Sans Serif,10,style=Bold'

$AzureButton                     = New-Object system.Windows.Forms.Button
$AzureButton.BackColor           = "#4a90e2"
$AzureButton.text                = "Azure"
$AzureButton.width               = 159
$AzureButton.height              = 67
$AzureButton.location            = New-Object System.Drawing.Point(219,23)
$AzureButton.Font                = 'Microsoft Sans Serif,10,style=Bold'

$AdminPortalButton               = New-Object system.Windows.Forms.Button
$AdminPortalButton.BackColor     = "#4a90e2"
$AdminPortalButton.text          = "Admin Portal"
$AdminPortalButton.width         = 159
$AdminPortalButton.height        = 67
$AdminPortalButton.location      = New-Object System.Drawing.Point(219,119)
$AdminPortalButton.Font          = 'Microsoft Sans Serif,10,style=Bold'

$SecurityButton                  = New-Object system.Windows.Forms.Button
$SecurityButton.BackColor        = "#4a90e2"
$SecurityButton.text             = "Security Centre"
$SecurityButton.width            = 159
$SecurityButton.height           = 67
$SecurityButton.location         = New-Object System.Drawing.Point(20,120)
$SecurityButton.Font             = 'Microsoft Sans Serif,10,style=Bold'

$SkypeButton                     = New-Object system.Windows.Forms.Button
$SkypeButton.BackColor           = "#4a90e2"
$SkypeButton.text                = "Skype"
$SkypeButton.width               = 159
$SkypeButton.height              = 67
$SkypeButton.location            = New-Object System.Drawing.Point(20,312)
$SkypeButton.Font                = 'Microsoft Sans Serif,10,style=Bold'

$MainFormButton                  = New-Object system.Windows.Forms.Button
$MainFormButton.BackColor        = "#4a90e2"
$MainFormButton.text             = "Exit"
$MainFormButton.width            = 159
$MainFormButton.height           = 67
$MainFormButton.location         = New-Object System.Drawing.Point(219,311)
$MainFormButton.Font             = 'Microsoft Sans Serif,10,style=Bold'

$TeamsButton                     = New-Object system.Windows.Forms.Button
$TeamsButton.BackColor           = "#4a90e2"
$TeamsButton.text                = "Microsoft Teams"
$TeamsButton.width               = 159
$TeamsButton.height              = 67
$TeamsButton.location            = New-Object System.Drawing.Point(219,215)
$TeamsButton.Font                = 'Microsoft Sans Serif,10,style=Bold'

$ExchangeButton                  = New-Object system.Windows.Forms.Button
$ExchangeButton.BackColor        = "#4a90e2"
$ExchangeButton.text             = "Exchange Online"
$ExchangeButton.width            = 159
$ExchangeButton.height           = 67
$ExchangeButton.location         = New-Object System.Drawing.Point(18,215)
$ExchangeButton.Font             = 'Microsoft Sans Serif,10,style=Bold'

$MainForm.controls.AddRange(@($SharePointButton,$AzureButton,$AdminPortalButton,$SecurityButton,$SkypeButton,$MainFormButton,$TeamsButton,$ExchangeButton))

#region gui events {
$MainForm.Add_MouseDoubleClick({  })
$MainForm.Add_Load({ checkCredentials })
$SharePointButton.Add_MouseClick({ sharepointLogin })
$SharePointButton.Add_MouseHover({  })
$AzureButton.Add_MouseClick({ azureLogin })
$AzureButton.Add_MouseHover({  })
$SecurityButton.Add_MouseClick({ securityLogin })
$SecurityButton.Add_MouseHover({  })
$AdminPortalButton.Add_MouseClick({ adminLogin })
$AdminPortalButton.Add_MouseHover({  })
$ExchangeButton.Add_MouseClick({ exchangeLogin })
$ExchangeButton.Add_MouseHover({  })
$TeamsButton.Add_MouseClick({ teamsLogin })
$TeamsButton.Add_MouseHover({  })
$SkypeButton.Add_MouseClick({ skypeLogin })
$SkypeButton.Add_MouseHover({  })
$MainFormButton.Add_MouseClick({ 
    Get-PSSession | Remove-PSSession 
    $MainForm.Close() 
})
$MainFormButton.Add_MouseHover({  })
#endregion events }

#endregion GUI }


#Write your logic code here

[void]$MainForm.ShowDialog()
