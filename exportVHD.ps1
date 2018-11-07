$vhdName = Get-ChildItem | Where-Object -Property Name -Match ".vhdx" | Get-VHD | Select-Object Path

function copyContents {

foreach ($vhdNames in $vhdName) {

$scan1 = Get-PSDrive | Where-Object -Property Provider -Match "FileSystem" | Select-Object Root
Mount-VHD -Path $vhdNames.Path
$scan2 = Get-PSDrive | Where-Object -Property Provider -Match "FileSystem" | Select-Object Root

$sourcePath = Compare-Object $scan1 $scan2
$sourcePath = $sourcePath.InputObject.Root
$sourcePath

$finalDot = $vhdNames.Path.LastIndexOf(".")
$finalSlash = $vhdNames.Path.LastIndexOf("\") + 1

$changedVhdName1 = ($vhdNames.Path).Remove($finalDot)
$changedVhdName = $changedVhdName1.Remove(0,$finalSlash)

$vhdNames.Path
$changedVhdName

robocopy $sourcePath $changedVhdName1 /MIR /SEC /R:2 /W:2

Dismount-VHD -Path $VhdNames.Path

                       }

}


function testVhd{

Dismount-VHD -Path $VhdName.Path
Mount-VHD -Path $VhdName.Path
}


#First Stage Migration

#Second Stage Migration

#Final Stage Migration

#Disable Profile Disks

#Log in with Each User

#Rename VHDX Folders to correct names
