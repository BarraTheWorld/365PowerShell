$affectedUsers = Get-ChildItem "\\hlgc01\d$\data\Users" -Filter normal.dotm -recurse | Where-Object {
    ($_.Length / 1KB) -gt 0
}

foreach ($user in $affectedUsers){
    Rename-Item $user.FullName normalOld2.dotm
    Copy-Item \\hlgc01\Software\ongc\Templates\BrokenNormal\Normal.dotm -Destination $user.FullName -Force
}