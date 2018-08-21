#THIS DEFINES THE MENUS FOR THE MENU365 FUNCTION
#This Defines the menu Layout and Functions for Azure Menu
function menuAzure
{


    param (
        [string]$Title = 'Azure Shell Support'
    )
    Clear-Host
    Write-Output "================ $Title ================"
    
    Write-Output "1: DNS Reporting"
    Write-Output "Q: Press 'Q' to quit."

     $selection = Read-Host "Please make a selection"
     switch ($selection)
     {
        '1' {
             'You chose option #1'
         } '2' {
             'You chose option #2'
         } '3' {
             'You chose option #3'
         }
     }
}

#This Defines the menu Layout and Functions for Exchange Menu
function menuExchange
{


    param (
        [string]$Title = 'Exchange Shell Support'
    )
    Clear-Host
    Write-Output "================ $Title ================"
    
    Write-Output "1: DNS Reporting"
    Write-Output "Q: Press 'Q' to quit."

     $selection = Read-Host "Please make a selection"
     switch ($selection)
     {
        '1' {
             'You chose option #1'
         } '2' {
             'You chose option #2'
         } '3' {
             'You chose option #3'
         }
     }
}

#This Defines the menu Layout and Functions for SharePoint Menu
function menuSharePoint
{


    param (
        [string]$Title = 'SharePoint Shell Support'
    )
    Clear-Host
    Write-Output "================ $Title ================"
    
    Write-Output "1: DNS Reporting"
    Write-Output "Q: Press 'Q' to quit."

     $selection = Read-Host "Please make a selection"
     switch ($selection)
     {
        '1' {
             'You chose option #1'
         } '2' {
             'You chose option #2'
         } '3' {
             'You chose option #3'
         }
     }
}

#This Defines the menu Layout and Functions for Teams Menu
function menuTeams
{


    param (
        [string]$Title = 'Teams Shell Support'
    )
    Clear-Host
    Write-Output "================ $Title ================"
    
    Write-Output "1: DNS Reporting"
    Write-Output "Q: Press 'Q' to quit."

     $selection = Read-Host "Please make a selection"
     switch ($selection)
     {
        '1' {
             'You chose option #1'
         } '2' {
             'You chose option #2'
         } '3' {
             'You chose option #3'
         }
     }
}

#This Defines the menu Layout and Functions for Security Menu
function menuSecurity
{


    param (
        [string]$Title = 'Security & Compliance Shell Support'
    )
    Clear-Host
    Write-Output "================ $Title ================"
    
    Write-Output "1: DNS Reporting"
    Write-Output "Q: Press 'Q' to quit."

     $selection = Read-Host "Please make a selection"
     switch ($selection)
     {
        '1' {
             'You chose option #1'
         } '2' {
             'You chose option #2'
         } '3' {
             'You chose option #3'
         }
     }
}

#This Defines the menu Layout and Functions for Office 365 Menu
function menuAdminO365
{


    param (
        [string]$Title = 'Office 365 Admin Shell Support'
    )
    Clear-Host
    Write-Output "================ $Title ================"
    
    Write-Output "1: DNS Reporting"
    Write-Output "Q: Press 'Q' to quit."

     $selection = Read-Host "Please make a selection"
     switch ($selection)
     {
        '1' {
             'You chose option #1'
         } '2' {
             'You chose option #2'
         } '3' {
             'You chose option #3'
         }
     }
}
