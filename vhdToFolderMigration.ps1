#New-VHD -Path "C:\test2.vhdx" -Fixed -SizeBytes 3GB

$copyLog = C:\errorvhdcopy.txt

$vhdName = Get-ChildItem | Where-Object -Property Name -Match ".vhdx" | Get-VHD | Select-Object Path



function createFolders {

#Mount-VHD -Path $vhdName.Path

foreach ($vhdNames in $vhdName) {

$changedVhdName = ($vhdNames.Path).TrimStart("C:\")
$changedVhdName = ($vhdNames.Path).TrimEnd(".vhdx")

$vhdNames.Path
$changedVhdName


#New-Item -ItemType Directory -Path $changedVhdName

}
                        }



function copyContents {

robocopy $vhdName $changedVhdName *.* /mov /e /w:1 /r:1 /tee /np /XO /xd "`$RECYCLE.BIN" /xf "desktop.ini" /log:$copyLog /v

                       }



function undoVhd{

Dismount-VHD -Path $VhdName.Path

}
