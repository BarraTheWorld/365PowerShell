<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    Untitled
#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

#region begin GUI{ 

$SecurityForm                    = New-Object system.Windows.Forms.Form
$SecurityForm.ClientSize         = '600,600'
$SecurityForm.text               = "Security & Compliance Management"
$SecurityForm.TopMost            = $false

$alertsButton                    = New-Object system.Windows.Forms.Button
$alertsButton.BackColor          = "#4a90e2"
$alertsButton.text               = "ALERTS"
$alertsButton.width              = 502
$alertsButton.height             = 251
$alertsButton.location           = New-Object System.Drawing.Point(31,49)
$alertsButton.Font               = 'Microsoft Sans Serif,10,style=Bold'

$SecurityForm.controls.AddRange(@($alertsButton))

#region gui events {
$SecurityForm.Add_Load({  })
$alertsButton.Add_MouseClick({  })
$alertsButton.Add_MouseHover({  })
#endregion events }

#endregion GUI }


#Write your logic code here

[void]$SecurityForm.ShowDialog()
