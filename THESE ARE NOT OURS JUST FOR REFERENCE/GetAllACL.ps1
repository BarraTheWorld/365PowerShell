#Create Support Folder
New-Item -Path c:\Support -ItemType directory 

#Create Permissions Folder
New-Item -Path c:\Support\Permissions -ItemType directory

#Create Results Folder
New-Item -Path c:\Support\Permissions\Results -ItemType directory

#Moving GetAllACL.ps1 to C:\PowerShell
Move-Item -Path "*GetAllACL.ps1" -Destination "C:\Support\Permissions\GetAllACL.ps1"

#Set variables
$path = Read-Host "Enter the path you wish to check"
$filename = Read-Host "Enter Output File Name"
$date = Get-Date

#Place Headers on out-put file
$list = "Permissions for directories in: $Path"
$list | format-table | Out-File "c:\Support\Permissions\Results\$filename"
$datelist = "Report Run Time: $date"
$datelist | format-table | Out-File -append "c:\Support\Permissions\Results\$filename"
$spacelist = " "
$spacelist | format-table | Out-File -append "c:\Support\Permissions\Results\$filename"

#Populate Folders Array
[Array] $folders = Get-ChildItem -path $path -force -recurse | Where {$_.PSIsContainer}

#Process data in array
ForEach ($folder in [Array] $folders)
{
#Convert Powershell Provider Folder Path to standard folder path
$PSPath = (Convert-Path $folder.pspath)
$list = ("Path: $PSPath")
$list | format-table | Out-File -append "c:\Support\Permissions\Results\$filename"

Get-Acl -path $PSPath | Format-List -property AccessToString | Out-File -append "c:\Support\Permissions\Results\$filename"

} #end ForEach