$baseOfAudit = "\\SERVER01\Data"

$reportFolderPath = "C:\Users\User\Documents\reportFolders.xlsx"
$reportGroupPath = "C:\Users\User\Documents\reportGroup.xlsx"

$domain = (Get-ADDomain).NetBiosName
$groups = Get-ADGroup -Filter *
$groupMembers = @()
foreach ($g in $groups) {
    $groupMembers += New-Object -TypeName PSobject -Property @{"Name"=$g.Name;"Members"=([array](Get-ADGroupMember $g.DistinguishedName))}

}

$i = 0;
function process_folder ($currentBase = $baseOfAudit) {
    if ($global:i -eq 0) {
        Write-Host -ForegroundColor Yellow ("Processing: " + $currentBase.FullName)
    }
    $global:i = ($global:i + 1) % 1000
    $daclList = (Get-ACL $currentBase.FullName -ErrorAction SilentlyContinue).Access
    #Write-Host -ForegroundColor Green ("DACL Entries: " + $daclList.Count)
    #Write-Host -ForegroundColor Green ("DACL Entries Not Inherited: " + ([array]($daclList | where {($_.isInherited -eq $false)})).Count)
    if (([array]($daclList | where {($_.isInherited -eq $false) -and ($_.IdentityReference -like ($domain + "\*"))})).Count -gt 0) {
        $global:report += 
            New-Object -TypeName psobject -Property @{
                "Path" = $currentBase.FullName;
                "Permission" = ([array]($daclList | where {($_.IdentityReference -like ($domain + "\*"))}))
            }
         
    }
    $subdirs = [array](Get-ChildItem -Directory $currentBase.FullName -ErrorAction SilentlyContinue)
    foreach ($f in $subdirs) {
        #Write-Host -ForegroundColor Cyan ("About to process " + $f.FullName)
        process_folder $f    
    }
}


$report = @()
process_folder (Get-Item $baseOfAudit);


$e = @(); 
foreach ($r in $report) { 
    $e += New-Object -TypeName PSObject -Property @{"Path" = $r.Path;"Allow/Deny"="";"User"="";"AccessLevel"="";"Inherited"=""};
    foreach ($p in $r.permission) {
        $e += New-Object -TypeName PSObject -Property @{"Allow/Deny"=$p.AccessControlType;"User"=$p.IdentityReference;"AccessLevel"=$p.FileSystemRights;"Inherited"=$p.IsInherited}
    }
}
$gr = @(); 
foreach ($g in $groupMembers) {
    $gr += New-Object -TypeName PSObject -Property @{"GroupName"=$g.Name;"Member"=""}; 
    foreach ($m in ($g.Members | Where {$_.ObjectClass -ne "computer"})) {
        $gr += New-Object -TypeName PSObject -Property @{"GroupName"="";"Member"=$m.name}
    }
}

Remove-Item $reportFolderPath -Force -Confirm:$false -ErrorAction SilentlyContinue
Remove-Item $reportGroupPath -Force -Confirm:$false -ErrorAction SilentlyContinue



$e | Select Path, "Allow/Deny", AccessLevel, User, Inherited | Export-XLSX $reportFolderPath   -WorksheetName "Permission Report" -ReplaceSheet



$gr | Select GroupName,Member | Export-XLSX $reportGroupPath   -WorksheetName "Group Membership Report" -ReplaceSheet


