#$webUrl = Read-Host -Prompt "HTTPS URL for your SP Online 2013 site"

$username = "admin@ecosuperfood.onmicrosoft.com"

$password = Read-Host -Prompt "Password for $username" -AsSecureString

$folder = "Sales" 
$ctx = New-Object Microsoft.SharePoint.Client.ClientContext("https://ecosuperfood.sharepoint.com")

$ctx.Credentials =New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($username,$password)

$web = $ctx.Web 

$lists = $web.Lists.GetByTitle($folder)

$query =[Microsoft.SharePoint.Client.CamlQuery]::CreateAllItemsQuery(10000)

$result = $lists.GetItems($query)

$ctx.Load($Lists)

$ctx.Load($result)

$ctx.ExecuteQuery()

foreach ($File in $result) { 
    Write-Host "Url: $($File["FileRef"]), title: $($File)"
}