$Outlook = New-Object -ComObject "Outlook.Application"

$Namespace = $Outlook.GetNameSpace("MAPI")

$folder = $Namespace.folders