# Script to connect to different Microsoft services
#
# Author: Jacob Shand & Benjamin Western
# Date: 24/07/2018
# 

# Link files to this script (master
# Same folder, called functions.ps1
. C:\Users\User\Documents\GitHub\365PowerShell\activityAlerts.ps1
. C:\Users\User\Documents\GitHub\365PowerShell\serviceConnectors.ps1
# Prompt user for credential to use for services
 
#$globalCred = "null"

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

$ONGCPowerShell                  = New-Object system.Windows.Forms.Form
$ONGCPowerShell.ClientSize       = '900,300'
$ONGCPowerShell.text             = "ONGC Systems Cloud Management"
$ONGCPowerShell.BackColor        = "#ffffff"
$ONGCPowerShell.TopMost          = $true

$SharePoint                      = New-Object system.Windows.Forms.Button
$SharePoint.BackColor            = "#4aa8e2"
$SharePoint.text                 = "SharePoint"
$SharePoint.width                = 250
$SharePoint.height               = 50
$SharePoint.location             = New-Object System.Drawing.Point(110,30)
$SharePoint.Font                 = 'Microsoft Sans Serif,10,style=Bold'

$Skype                           = New-Object system.Windows.Forms.Button
$Skype.BackColor                 = "#4aa8e2"
$Skype.text                      = "Skype"
$Skype.width                     = 250
$Skype.height                    = 50
$Skype.location                  = New-Object System.Drawing.Point(500,30)
$Skype.Font                      = 'Microsoft Sans Serif,10,style=Bold'

$AdminPortal                     = New-Object system.Windows.Forms.Button
$AdminPortal.BackColor           = "#4aa8e2"
$AdminPortal.text                = "Admin Portal"
$AdminPortal.width               = 250
$AdminPortal.height              = 50
$AdminPortal.location            = New-Object System.Drawing.Point(110,90)
$AdminPortal.Font                = 'Microsoft Sans Serif,10,style=Bold'

$SecurityCentre                  = New-Object system.Windows.Forms.Button
$SecurityCentre.BackColor        = "#4aa8e2"
$SecurityCentre.text             = "Security Centre"
$SecurityCentre.width            = 250
$SecurityCentre.height           = 50
$SecurityCentre.location         = New-Object System.Drawing.Point(500,91)
$SecurityCentre.Font             = 'Microsoft Sans Serif,10,style=Bold'

$Teams                           = New-Object system.Windows.Forms.Button
$Teams.BackColor                 = "#4aa8e2"
$Teams.text                      = "Teams"
$Teams.width                     = 250
$Teams.height                    = 50
$Teams.location                  = New-Object System.Drawing.Point(110,150)
$Teams.Font                      = 'Microsoft Sans Serif,10,style=Bold'

$Azure                           = New-Object system.Windows.Forms.Button
$Azure.BackColor                 = "#4aa8e2"
$Azure.text                      = "Azure"
$Azure.width                     = 250
$Azure.height                    = 50
$Azure.location                  = New-Object System.Drawing.Point(500,151)
$Azure.Font                      = 'Microsoft Sans Serif,10,style=Bold'

$Exchange                        = New-Object system.Windows.Forms.Button
$Exchange.BackColor              = "#4aa8e2"
$Exchange.text                   = "Exchange"
$Exchange.width                  = 250
$Exchange.height                 = 50
$Exchange.location               = New-Object System.Drawing.Point(110,210)
$Exchange.Font                   = 'Microsoft Sans Serif,10,style=Bold'

$ExitMain                        = New-Object system.Windows.Forms.Button
$ExitMain.BackColor              = "#4aa8e2"
$ExitMain.text                   = "Exit"
$ExitMain.width                  = 250
$ExitMain.height                 = 50
$ExitMain.location               = New-Object System.Drawing.Point(500,209)
$ExitMain.Font                   = 'Microsoft Sans Serif,10,style=Bold'
$ExitMain.ForeColor              = "#000000"

$ONGCPowerShell.controls.AddRange(@($SharePoint,$Skype,$AdminPortal,$SecurityCentre,$Teams,$Azure,$Exchange,$ExitMain))

#region gui events {
$SharePoint.Add_MouseClick({ sharepointLogin })
$Skype.Add_MouseClick({ skypeLogin })
$AdminPortal.Add_MouseClick({ adminLogin })
$SecurityCentre.Add_MouseClick({ activityAlerts jshand96@hotmail.com  })
$Teams.Add_MouseClick({ teamsLogin })
$Azure.Add_MouseClick({ azureLogin })
$Exchange.Add_MouseClick({ exchangeLogin })
$ExitMain.Add_MouseClick({ $ONGCPowerShell.Close() })
$ONGCPowerShell.Add_MouseDoubleClick({  })
$ONGCPowerShell.Add_Load({$globalCred = Get-Credential})
#endregion events }

#endregion GUI }


#Write your logic code here

[void]$ONGCPowerShell.ShowDialog()
