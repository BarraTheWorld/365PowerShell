function connect-site($webs,$creds){ 
 
Connect-PNPonline -Url $webs -Credentials $cred 
 
} 
 
function get-sitepermission($web,$cred){ 
 
$rec=@() 
 
connect-site -webs $web -creds $cred 
 
if($web -eq $parentsitename) 
{ 
#Write-Host "Parent site permission" $web 
$Pgroups=Get-PNPGroup 
foreach($Pgroup in $Pgroups) 
{ 
$DLGP = "" | Select "SiteUrl","GroupName","Permission" 
$pPerm=Get-PNPGroupPermissions -Identity $Pgroup.loginname -ErrorAction SilentlyContinue |Where-Object {$_.Hidden -like "False"} 
if($pPerm -ne $null) 
{ 
$DLGP.SiteUrl=$web 
$DLGP.GroupName=$Pgroup.loginname 
$DLGP.Permission=$pPerm.Name 
$rec+= $DLGP 
} 
} 
} 
$subwebs=Get-PNPSubWebs 
foreach($subweb in $subwebs) 
{ 
connect-site -webs $subweb.Url -creds $cred 
#Write-Host $subweb.Url 
$groups=Get-PNPGroup 
foreach($group in $groups) 
{ 
$DLGP = "" | Select "SiteUrl","GroupName","Permission" 
$sPerm=Get-PNPGroupPermissions -Identity $group.loginname -ErrorAction SilentlyContinue |Where-Object {$_.Hidden -like "False"} 
if ($sPerm -ne $null) 
{ 
$DLGP.SiteUrl=$subweb.Url 
$DLGP.GroupName=$group.loginname 
$DLGP.Permission=$sPerm.Name 
$rec+=$DLGP 
} 
} 
Write-Host $subweb.Url "permission fetched!" 
get-sitepermission -web $subweb.Url -cred $cred 
 
} 
return $rec 
} 
#Input parameter 
$cred=Get-Credential 
$parentsitename="https://ecosuperfood.sharepoint.com/"
$outputPath= "C:\AllSubsitegrouppermission.csv" 
 
$Sitepermission=get-sitepermission -web https://ecosuperfood.sharepoint.com/Sales/ -cred $cred 
$Sitepermission |Export-Csv -Path $outputPath