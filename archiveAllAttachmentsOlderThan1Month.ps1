$ErrorActionPreference = "Continue"

Get-Process | Where-Object -Property ProcessName -Match "Outlook" | Stop-Process

#-------------------------------------Answer 1-------------------------------------#
$outlook = new-object -com Outlook.Application
$namespace = $outlook.GetNamespace("MAPI")


#----------------------------- Checks if an email is older than 1 Month -----------------------------#

function Get-MailboxFolder($folder)
{
"{0}" -f $folder.name

foreach ($f in $folder.folders) {
Get-MailboxFolder $f
New-Item $f.FolderPath.Substring(2) -ItemType Directory -Force

$path = $f.FolderPath.substring(2)

$items = $f.Items

try {
$item = $items.Find("[SentOn] <= '" + [DateTime]::Now.ToString() + "' ")
} catch {
$item = $items.Find("[ReceivedTime] <= '" + [DateTime]::Now.ToString() + "' ")
}
 while ($item) {
    if ($item.Attachments.Count -gt 0) {
        #Write-Output "$($item.Subject) ($($item.Attachments.Count))"
        [int] $oldSize = $item.Size
        while ($item.Attachments.Count -gt 0) {
            $attachment = $item.Attachments.Item(1);
            $attachment.FileName
            $newPath = new-item $path\$($item.conversationID) -ItemType Directory
            foreach ($attachments in $attachment) {
            
            $attachments.SaveAsFile("C:\test1\$newPath" + "\" + $attachments.FileName)
            #$attachment.Delete()
            $item.Save()

            }
            $path
            $item = $false
        }

        [int] $newSize = $item.Size
        #Write-Output "$oldSize -> $newSize ($([int]($newSize * 100 / $oldSize))%)"
    }
    $item = $items.FindNext()
}

}
}

# iterate through folders
foreach ($folder in $namespace.Folders) {
Get-MailboxFolder $folder
}


Get-Process | Where-Object -Property ProcessName -Match "Outlook" | Stop-Process

#Creating folder based on subject of email
#Changing path to reflect new folder location based on subject
#Appending subject to - Items Archived
