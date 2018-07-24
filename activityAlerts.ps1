Function activityAlerts { 
    Param($email)

    # User who notifications will go to
    $alertEmail = $email

    # Applies alerts to all users
    $userEmail = $null

    Write-Host "`nEmail alerts to go to: $alertEmail for all users."
    Write-Host "`nAlerts to be set up: `n"
    Write-Host "1 - File and Page Alert"
    Write-Host "2 - Anonymous Links Alert"
    Write-Host "3 - File Sharing Alert"
    Write-Host "4 - Acces Policy"
    Write-Host "5 - OneDrive Site Alert"
    Write-Host "6 - Office Software Alert"
    Write-Host "7 - Mailbox Permissions Alert"
    Write-Host "8 - Password Alert"
    Write-Host "9 - Role Alert"
    Write-Host "10 - Company info"
    Write-Host "11 - Domain Alert `n"
    <#
    Write-Host -NoNewLine 'Press any key to continue...';
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
    #>
    createAlerts
}

## Function to create a number of standard Office 365 alerts
## Alert Activities found here - https://support.office.com/en-us/article/search-the-audit-log-in-the-office-365-security-compliance-center-0d4d0f35-390b-4518-800e-0c7ec95e946c?ui=en-US&rs=en-US&ad=US#auditlogevents&PickTab=Activities
Function createAlerts {
    Write-Host "-------------------------------------"
    try{
        $fileAndPage = @{
            "Name" = "File and Page Alert";
            "operation" = "Filemalwaredetected";
            "notifyuser" = $alertEmail;
            "userid" = $userEmail;
            "Description" = "SharePoint anti-virus engine detects malware in a file.";
        }
        $result=New-ActivityAlert @fileAndPage
        write-host -foregroundcolor green "`nCreate File and Page Alert"
    }catch {
        Write-Host -ForegroundColor red "Creating File and Page Policy Failed - already exists"
    }

    try{
        $anonLinks = @{
            "Name" = "Anonymous Links Alert";
            "operation" = "Anonymouslinkcreated","Anonymouslinkupdated","Anonymouslinkused";
            "notifyuser" = $alertEmail;
            "userid" = $userEmail;
            "Description" = "User created an anonymous link to a resource. User updated an anonymous link to a resource. An anonymous user accessed a resource by using an anonymous link.";
        }
        $result=New-ActivityAlert @anonLinks
        write-host -foregroundcolor green "Create Anonymous Links Alert"
    }catch{
        Write-Host -ForegroundColor red "Creating Anonymous Links Alert Failed - already exists"
    }

    try{
        $sharedAlert = @{
            "Name" = "Sharing Alert";
            "operation" = "Sharinginvitationcreated","Sharingpolicychanged";
            "notifyuser" = $alertEmail;
            "userid" = $userEmail;
            "Description" = "User shared a resource in SharePoint Online or OneDrive for Business with a user who isn't in your organization's directory. A SharePoint or global administrator changed a SharePoint sharing policy.";
        }
        $result=New-ActivityAlert @sharedAlert
        write-host -foregroundcolor green "Create File Sharing Alert"
     }catch{
        write-host -ForegroundColor red "Creating File Sharing Alert Failed - already exists"
     }

     try{
        $accessAlert = @{
            "Name" = "Access Alert";
            "operation" = "Deviceaccesspolicychanged","Networkaccesspolicychanged";
            "notifyuser" = $alertEmail;
            "userid" = $userEmail;
            "Description" = "Change in the unmanaged devices policy.Change in the location-based access policy (also called a trusted network boundary).";
        }
        $result = New-ActivityAlert @accessAlert
        write-host -foregroundcolor green "Create Access Policy"
    } catch {
        write-host -foregroundcolor red "Creating Access Policy failed - already exists"
    }

    try {
        $collectionAlert = @{
            "Name" = "Site Alert";
            "operation" = "Sitecollectioncreated","Sitedeleted","Sitecollectionadminadded";
            "notifyuser" = $alertEmail;
            "userid" = $userEmail;
            "Description" = "Creation of a new site collection OneDrive for Business site provisioned. A site was deleted.Site collection administrator or owner adds a person as a site collection administrator for a site.";
        }
        $result = New-ActivityAlert @collectionAlert
        write-host -foregroundcolor green "Create Site Alert"
    } catch {
        write-host -foregroundcolor red "Creating Site Alert failed - already exists"
    }

    try {
        $officeAlert = @{
            "Name" = "Office Alert";
            "operation" = "Officeondemandset";
            "notifyuser" = $alertEmail;
            "userid" = $userEmail;
            "Description" = "Site administrator enables Office on Demand, which lets users access the latest version of Office desktop applications.";
        }
        $result = New-ActivityAlert @officeAlert
        write-host -foregroundcolor green "Create Office Software Alert"
    } catch {
        write-host -foregroundcolor red "Creating Office Software Alert failed - already exists"
    }

    try {
        $permissionsAlert = @{
            "Name" = "Mailbox Alert";
            "operation" = "Add-mailboxpermission","Remove-mailboxpermission";
            "notifyuser" = $alertEmail;
            "userid" = $userEmail;
            "Description" = "An administrator assigned/removed the FullAccess mailbox permission to a user (known as a delegate) to another person`'s mailbox";
        }
        $result = New-ActivityAlert @permissionsAlert
        write-host -foregroundcolor green "Create Mailbox Permissions Alert"
    } catch {
        write-host -foregroundcolor red "Creating Mailbox Permissions Alert failed - already exists"
    }

    try {
        $passwordAlert = @{
            "Name" = "Password Alert";
            "operation" = "Change user password.","Reset user password.","Set force change user password.";
            "notifyuser" = $alertEmail;
            "userid" = $userEmail;
            "Description" = "User password changes";
        }
        $resut = New-ActivityAlert @passwordAlert
        write-host -foregroundcolor green "Create Passwords Alert"
    } catch {
        write-host -foregroundcolor red "Creating Passwords Alert failed - alread exists"
    }

    try {
        $roleAlert = @{
            "Name" = "Role Alert";
            "operation" = "Add member to role.","Remove member from role.";
            "notifyuser" = $alertEmail;
            "userid" = $userEmail;
            "Description" = "Added/Removed a user to an admin role in Office 365.";
        }
        $resut = New-ActivityAlert @roleAlert
        write-host -foregroundcolor green "Create Role Alert"
    } catch {
        write-host -foregroundcolor red "Creating Role Alert failed - already exists"
    }

    try {
        $companyInfoAlert = @{
            "Name" = "Company Information Alert";
            "operation" = "Set company contact information.","Set company information.","Set password policy.","Remove partner from company.";
            "notifyuser" = $alertEmail;
            "userid" = $userEmail;
            "Description" = "Change company information or password policy";
        }
        $result = New-ActivityAlert @companyInfoAlert
        write-host -foregroundcolor green "Create Company Information Alert"
    } catch {
        write-host -foregroundcolor red "Creating Company Information Alert failed - already exists"
    }

    try {
        $domainPolicy = @{
            "Name" = "Domain Alert";
            "operation" = "Add domain to company.","Remove domain from company.","Update domain.";
            "notifyuser" = $alertEmail;
            "userid" = $userEmail;
            "Description" = "Change of a custom domain in a tenant";
        }
        $result = New-ActivityAlert @domainPolicy
        write-host -foregroundcolor green "Create Domain Alert"
    } catch {
        write-host -foregroundcolor red "Creating Domain Alert failed - already exists"
    }
}


## Users who will have the alerts applied to
## blank = any user in your organization performs specific activity
## Select users = "user1@domain.com", "user2@domain.com", "user3@domain.com"
$userEmail = $null