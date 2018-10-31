function createVMSwitch{
    $nicType = Read-Host "Would you like an External 'E' or Internal 'I' Switch? "
    switch ($nicType){
          E {Write-Output "You will have an External NIC" ; $nicType=$true}
          I {Write-Output "You will have an Internal Or Private Nic" ; $nicType=$false} 
                     }

if ($nicType){

                $switchName = Read-Host "Please Define a name for your new Virtual Switch"
                Get-NetAdapter
                $hostNic = Read-Host "Which Network adapter would you like to use?"
                $managementAllow = Read-Host "Would you like the Host OS to share this Adapater? Y / N ? "
                    Switch ($managementAllow) 
{ 
                    Y {Write-Output "Yes, OS will share NIC"; $managementAllow=$true} 
                    N {Write-Output "No, OS wont show NIC"; $managementAllow=$false} 
                    Default {$managementAllow=$false} 
} 

            New-VMSwitch -name $switchName -NetAdapterName $hostNic -AllowManagementOS $managementAllow | Out-Null

}else{

            $switchName = Read-Host "Please Define a name for your new Virtual Switch"
            $switchType = Read-Host "Please choost Internal 'I' Or Private 'P'"
                    Switch ($switchType) 
{ 
                    I {New-VMSwitch -SwitchType Internal -name $switchName} 
                    P {New-VMSwitch -SwitchType Private -name $switchName} 
                    Default {New-VMSwitch -SwitchType Internal -name $switchName} 
} 
            
}

}

