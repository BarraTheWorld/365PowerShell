## Prerequisites = 1
## Ensure you are coonected to Exchange Online prior to running these commands

## Disable external domain forwarding
Set-RemoteDomain Default -AutoForwardEnabled $false ## configures just default Office 365 domain. Can do all if needed.

## Disable all mailbox forwarding
Get-Mailbox | Set-Mailbox -ForwardingAddress $Null
Get-Mailbox | Set-Mailbox -ForwardingsmtpAddress $Null