#THIS DEFINES THE MENUS FOR THE MENUSVR FUNCTION
#This Defines the menu Layout and Functions for AD Menu
function menuUserManagementSvr
{


    param (
        [string]$Title = 'AD Management Shell Support'
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
function menuAppManagementSvr
{


    param (
        [string]$Title = 'Server Application Shell Support'
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
function menuFileStorageSvr
{


    param (
        [string]$Title = 'Server File & Storage Shell Support'
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
function menuNetworkSvr
{


    param (
        [string]$Title = 'Server Network Shell Support'
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
function menuOSManagementSvr
{


    param (
        [string]$Title = 'Server OS Management Shell Support'
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

#This Defines the menu Layout and Functions for VM Management Menu
function menuVMManagementSvr
{


    param (
        [string]$Title = 'Server VM Management Shell Support'
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
