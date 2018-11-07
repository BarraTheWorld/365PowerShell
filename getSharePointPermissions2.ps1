Import-Module 'C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.dll'
Import-Module 'C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.Runtime.dll'
Import-Module 'C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.Publishing.dll'

$url ="https://ecosuperfood.sharepoint.com"
$context = New-Object Microsoft.SharePoint.Client.ClientContext($url)

$userCollection = $context.Web.SiteUsers
        $context.Load($userCollection)
        $context.ExecuteQuery()

        foreach ($user in $userCollection)
        {
            $userName = $user.LoginName
            Add-Content -Path C:\logs.log -Value $userName
            Add-Content -Path C:\logs.log -Value "-----------------------------------"
            $permissions = $context.Web.GetUserEffectivePermissions($user.LoginName)
            $context.ExecuteQuery()
            $PermissionKindObj=New-Object Microsoft.SharePoint.Client.PermissionKind
            $PermissionKindType=$PermissionKindObj.getType()

            foreach ($permissionKind in [System.Enum]::GetValues($PermissionKindType))
            {
                $type=$permissionKind.getType()
                $permisson = [System.Enum]::GetName($type, $permissionKind)
                $hasPermisssion = $permissions.Value.Has($permissionKind);
                if ($hasPermisssion)
                {
                    Add-Content -Path C:\logs.log -Value $permissionKind.ToString()                    
                }
            }
        }


#https://www.microsoft.com/en-au/download/details.aspx?id=42038