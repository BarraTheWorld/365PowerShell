## Prerequisites = 1
## Ensure you are connected to SharePoint Online first

Set-SPOSite -Identity https://m365b555418.sharepoint.com/sites/Marketing -LockState NoAccess ## Disable access to SharePoint Site for all users

Set-SPOTenant -NoAccessRedirectUrl http://www.ciaops.com ## Set redirection URL for tenant

Set-SPOSite -Identity https://m365b555418.sharepoint.com/sites/Marketing -LockState Unlock ## Enable access to SharePoint Site for all users