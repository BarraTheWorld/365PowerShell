#.FullName

Get-ChildItem "\\hlgc01\d$\data\Users" -Filter normalOLD.dotm -recurse | Where-Object {
    ($_.Length / 1KB) -gt 800
} | Select-Object directory, @{Name="KBytes";Expression={ 
    "{0:N0}" -f ($_.Length / 1KB) }
} | Export-Csv C:\affectedUsers.csv