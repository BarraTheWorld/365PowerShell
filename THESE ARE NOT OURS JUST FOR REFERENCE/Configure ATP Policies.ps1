## Prerequisites = 1
## Ensure Exchange Online module is loaded before unning commands

get-AtpPolicyForO365 ## Display default ATP safe links and other settings policy

get-safelinkspolicy ## Display default ATP safe links policy if any

get-safeattachmentpolicy  ## Display default safe attachments policy if any

Set-atppolicyforo365 -allowclickthrough $false -enablesafelinksforclients $true -enableatpforspoteamsodb $true -trackclicks $true

New-safelinkspolicy -name "PowerShell Policy" -admindisplayname "PowerShell" -donotallowclickthrough $true -donottrackuserclicks $false -enableforinternalsender $false -isenabled $true -scanurls $true -trackclicks $true

New-safeattachmentpolicy -name "PowerShell Policy" -admindisplayname "PowerShell" -enable $true -action dynamicdelivery -actiononerror $true -redirect $false
Discussion