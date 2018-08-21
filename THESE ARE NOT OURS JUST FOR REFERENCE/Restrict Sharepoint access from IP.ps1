## Prerequities = 1
## Ensure connection to Sharepoint Online first

get-spotenant | select ipaddressenforcement,ipaddressallowlist ## Determine if enabled and IP allow list

set-spotenant -ipaddressallowlist "13.72.227.236" ## Set IP allow list

set-spotenant -ipaddressenforcement $true ## Enable restriction to data based on IP

set-spotenant -ipaddressenforcement $false ## Disable restriction to data based on IP