#THIS DEFINES THE MENUS FOR THE MENUPC FUNCTION
#This Defines the menu Layout and Functions for User Menu
function menuUserManagement
{


    param (
        [string]$Title = 'User Management Shell Support'
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

#This Defines the menu Layout and Functions for Applications Menu
function menuAppManagement
{


    param (
        [string]$Title = 'PC Application Shell Support'
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

#This Defines the menu Layout and Functions for File & Storage Menu
function menuFileStorage
{


    param (
        [string]$Title = 'File & Storage Shell Support'
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

#This Defines the menu Layout and Functions for Network Menu
function menuNetwork
{


    param (
        [string]$Title = 'Network Shell Support'
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

#This Defines the menu Layout and Functions for OS Management Menu
function menuOSManagement
{


    param (
        [string]$Title = 'OS Management Shell Support'
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
