function titleScreen
{
    param (
        [string]$Title = 'ONGC Support Shell Menu'
    )
    Clear-Host
    Write-Output "================ $Title ================"
    
    Write-Output "1: Microsoft 365 Support."
    Write-Output "2: PC Support."
    Write-Output "3: Server Support."
    Write-Output "4: Custom Support."
    Write-Output "Q: Press 'Q' to quit."

     $selection = Read-Host "Please make a selection"
     switch ($selection)
     {
        '1' {
             menu365
         } '2' {
             menuPc
         } '3' {
             menuSvr
         } '4' {
             menuCustom
         }
         
     }
}

#This Defines the menu Layout and Functions for Microsoft 365 Menu
function menu365
{


    param (
        [string]$Title = 'MicroSoft 365 Shell Support'
    )
    Clear-Host
    Write-Output "================ $Title ================"
    
    Write-Output "1: Azure"
    Write-Output "2: Exchange"
    Write-Output "3: SharePoint"
    Write-Output "4: Teams"
    Write-Output "5: Security & Compliance"
    Write-Output "6: Skype"
    Write-Output "7: O365 Admin"
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

#This Defines the menu Layout and Functions for PC Menu
function menuPc
{


    param (
        [string]$Title = 'PC Shell Support'
    )
    Clear-Host
    Write-Output "================ $Title ================"
    
    Write-Output "1: User Management"
    Write-Output "2: Application Management"
    Write-Output "3: File and Storage Management"
    Write-Output "4: Network Management "
    Write-Output "5: OS Managment"
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

#This Defines the menu Layout and Functions for Server Menu
function menuSvr
{


    param (
        [string]$Title = 'Server Shell Support'
    )
    Clear-Host
    Write-Output "================ $Title ================"
    
    Write-Output "1: AD Management"
    Write-Output "2: Application Management"
    Write-Output "3: File and Storage Management"
    Write-Output "4: Network Management "
    Write-Output "5: OS Managment"
    Write-Output "6: VM & Hyper-V Management"
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
function menuCustom
{


    param (
        [string]$Title = 'Custom Shell Support'
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


titleScreen


#Defines a Loop that will not end until the user physically presses Q
<#do
 {
     titleScreen
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
     pause
 }
 until ($selection -eq 'q')
#>


