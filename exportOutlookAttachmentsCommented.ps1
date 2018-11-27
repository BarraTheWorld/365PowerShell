#Defines error action as continue - i.e skips errors
$ErrorActionPreference = "Continue"

#Defines Variables as null
$folder = $null
$f = $null
$path = $null
$item = $null
$items = $null
$attachment = $null
$attachments = $null


#Gets process Outlook and kills it
Get-Process | Where-Object -Property ProcessName -Match "Outlook" | Stop-Process

#Creates new Variable that is the Outlook Application
$outlook = New-Object -ComObject Outlook.Application

#Creates new NameSpace based on the Outlook Object using the MAPI header
$namespace = $outlook.GetNamespace("MAPI")

#Checks if the OutlookExport folder exists and creates it if it doesn't exist
if (Get-ChildItem "$env:HOMEPATH" | Where-Object -Property Name -Match "OutlookExport") {
    
    #Changes current location to Outlook Export Folder
    Set-Location -Path "$env:HOMEPATH\OutlookExport"

    }else{

    #Creates New Outlook Export Folder if not already there
    New-Item -ItemType Directory -Path "$env:HOMEPATH\OutlookExport"
    
    #Changes current location to the Newly created Outlook Export Folder
    Set-Location -Path "$env:HOMEPATH\OutlookExport"

     }

#Creates Function named Get-MailboxFolder($folder)
function Get-MailboxFolder($folder) {

#Prints Folder name to screen - I THINK?
"{0}" -f $folder.Name

    #checks for each folder in the folders variable
    foreach ($f in $folder.folders) {

        #Runs the Current Function inside itself now using the $f variable 
        Get-MailboxFolder $f

        #Creates new folder based on the current $f 
        New-Item $f.FolderPath.Substring(2) -ItemType Directory -Force

        #Defines $path variable as the current $f.folderpath
        $path = $f.FolderPath.Substring(2)

        #Defines $items as all folder items from the $f variable
        $items = $f.Items

        #Finds all items with the current sent time of today and defines the item variable as such
        $item = $items.Find("[SentOn] < '" + [DateTime]::Now.ToString() + "' ")
    
        #While each $item - Ie while there is an item in $item variable
        While ($item) {

            #if $item has a single attachment on it
            if ($item.Attachmnets.Count -gt 0) {

                #Writes the Subject and Attachment Count of the current Item to the terminal
                Write-Output "$($item.Subject) ($($Item.Attachments.Count))"

                #Defines $oldSize as an iteger and sets it as the current size of the $item
                [int] $oldSize = $item.Size

                #While there is more than one attachment on the current item (ie Email)
                while ($item.Attachments.Count -gt 0) {
                    
                    #Defines Attachment as one of the attachments in the $item variable (ie Email)
                    $attachment = $item.Attachments.Item(1)
                    
                    #Displays current attachment filename in the terminal window
                    $attachment.FileName

                    #Checks the current folder to see if the email subject is listed as a folder
                    if (Get-ChildItem "$env:HOMEPATH\OutlookExport\$($path)\" | Where-Object -Property Name -Match "$($item.TaskSubject)") {
                        
                        #for each attachment in the attachments varaible do the following
                        foreach ($attachments in $attachment) {

                            #Saves the current attachment in the for each loop to the subject folder with the file name appended to it
                            $attachments.SaveAsFile("$env:HOMEPATH\OutlookExport\$($path)\$($item.TaskSubject)" + $($attachments.FileName))

                            #Deletes the attachment from the current email - COMMENTED OUT DURING TESTING ONLY
                            #$attachments.Delete()

                            #Saves the $item (ie the email) without the attachment on it
                            $item.Save()
                        }

                    #If email subject folder does not exist ie $item.TaskSubject
                    } Else {
                            
                            #creates new directory based on the current $item (ie Email subject's Name) in the current directory
                            New-Item -ItemType Directory -Path "$env:HOMEPATH\OutlookExport\$($path)\$($item.TaskSubject)"

                            #for each attachment in the attachments varaible do the following
                            foreach ($attachments in $attachment) {

                                #Saves the current attachment in the for each loop to the subject folder with the file name appended to it
                                $attachments.SaveAsFile("$env:HOMEPATH\OutlookExport\$($path)\$($item.TaskSubject)" + $($attachments.FileName))

                                #Deletes the attachment from the current email - COMMENTED OUT DURING TESTING ONLY
                                #$attachments.Delete()

                                #Saves the $item (ie the email) without the attachment on it
                                $item.Save()

                            }
                        







                    }

                    #Moves onto the next email item in the while loop
                    $item = $items.FindNext()

                }

            }

        }

    }

}

#for each folder in the folders inside of the outlook object data file run the above function
foreach ($folder in $namespace.Folders) {

Get-MailboxFolder $folder

}

#Gets process Outlook and kills it
Get-Process | Where-Object -Property ProcessName -Match "Outlook" | Stop-Process
