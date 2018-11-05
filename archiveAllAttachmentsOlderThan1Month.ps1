$ErrorActionPreference = "Stop"
[object] $outlook = New-Object -ComObject Outlook.Application
[object] $folder = $outlook.Session.Accounts[1].Session.PickFolder()
[object] $items = $folder.Items
[object] $item = $items.Find("[ReceivedTime] < '" + [DateTime]::Now.AddMonths(-1).ToString() + "' ")
if (!(Test-Path -PathType Container -LiteralPath "${env:USERPROFILE}\Outlook")) {
    New-Item -ItemType Directory -Path "${env:USERPROFILE}\Outlook" | Out-Null
}

while ($item) {
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