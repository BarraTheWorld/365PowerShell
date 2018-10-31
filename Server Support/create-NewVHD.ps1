
#Set-VM -ProcessorCount
#Set-VM -Name
#Set-VM -DynamicMemory
#Set-VM -StaticMemory
#Set-VM -MemoryStartupBytes
#Set-VM -MemoryMinimumBytes
#Set-VM -MemoryMaximumBytes
#Set-VM -Generation #1 or 2
#Set-VM -AutomaticStartDelay
#Set-VM -AutomaticStartAction
#Set-VM -BootDevice #VHD etc


function createVHD
{
    $vhdPath = "C:\VHDs\test.vhdx"
    $vhdSize = 24GB
    New-VHD -Path $vhdpath -Dynamic -SizeBytes $vhdsize


}

 



#| Mount-VHD 
#   -Passthru 
    
    
    #|Initialize-Disk -Passthru 
    
    
    
    #|New-Partition -AssignDriveLetter 
    #-UseMaximumSize |Format-Volume -FileSystem NTFS -Confirm:$false -Force
