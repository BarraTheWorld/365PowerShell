Set-ExecutionPolicy Unrestricted
$LiveCred = Get-Credential
$SMTPAlias = Read-Host -Prompt "Enter the admin SMTP address"
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $LiveCred -Authentication Basic -AllowRedirection
Import-PSSession $Session
Enable-OrganizationCustomization
New-ManagementRoleAssignment -Role "ApplicationImpersonation" -User $SMTPAlias