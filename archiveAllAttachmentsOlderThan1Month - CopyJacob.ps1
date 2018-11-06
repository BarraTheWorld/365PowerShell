$ErrorActionPreference = "Stop"
[object] $outlook = New-Object -ComObject Outlook.Application
$mailboxFolders = $outlook.Session.Folders | Where-Object {$_.Name -like "Mailbox*"}
$folderCache = $outlook.GetNamespace("MAPI")
$folderCache.Stores
[object] $items = $folder.Items
#----------------------------- Checks if an email is older than 1 Month -----------------------------#
[object] $item = $items.Find("[ReceivedTime] < '" + [DateTime]::Now.AddMonths(-1).ToString() + "' ")


#-------------------- Checking for Output - Creating Output if not Found ----------------------#
if (!(Test-Path -PathType Container -LiteralPath "${env:USERPROFILE}\Outlook")) {
    New-Item -ItemType Directory -Path "${env:USERPROFILE}\Outlook" | Out-Null
}

 <#while ($item) {
    if ($item.Attachments.Count -gt 0) {
        Write-Output "$($item.Subject) ($($item.Attachments.Count))"
        [int] $oldSize = $item.Size
        while ($item.Attachments.Count -gt 0) {
            $attachment = $item.Attachments.Item(1);
            $attachment.SaveAsFile("${env:USERPROFILE}\Outlook\" + $item.ConversationID + "_" + $attachment.FileName)
            $attachment.Delete()
            $item.Save
        }

        [int] $newSize = $item.Size
        Write-Output "$oldSize -> $newSize ($([int]($newSize * 100 / $oldSize))%)"
    }

    $item = $items.FindNext()
}

#>


#Need to add creating folder directory and folders in those folders based on the subject name of an email
#Need to get all attachments not just ones that are older than 1 month
#need to auto close outlook when finished
#Need to auto save changes to outlook

$Path = $folder.FolderPath; New-Item $Path.Substring(2) -ItemType Directory 

$namespace.Folders

$outlook = New-Object -ComObject Outlook.Application
$namespace = $outlook.GetNamespace("MAPI")

$f = $namespace.GetDefaultFolder(6)
$f.name

function GetSubfolders($Parent) {  
    $folders = $Parent
    foreach ($folder in $folders) {  
        $Subfolder = $Parent.Folders.Item($folder.Name)  
        Write-Host($folder.Name)  
        GetSubfolders($Subfolder)  
    }  
}  

GetSubfolders($f)

function Get-MailboxFolder($folder)
{
"{0}" -f $folder.name

foreach ($f in $folder.folders)
{
Get-MailboxFolder $f
}
}

$ol = new-object -com Outlook.Application
$ns = $ol.GetNamespace("MAPI")
$mailbox = $ns.stores | where {$_.ExchangeStoreType -eq 0}
$mailbox.GetRootFolder().folders | foreach { Get-MailboxFolder $_}