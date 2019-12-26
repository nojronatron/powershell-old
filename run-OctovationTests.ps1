<#  Title: 
    Description: Execute Octovation Tests using JSON and a flow.
    Additional setup required:
        Make any necessary changes to commands (camelCase, PascalCase, Uri, OAuth Token, etc)
        Create-WinNodeCommandsObject.ps1 must be in path!
        Add your G2m and G2t OAuth Token to the CreateMeeting NoteProperty for each
        Deploy a WindowsNode to a Windows machine
        Deploy an Octoblu Flow, claim the WinNode, record the Trigger URL, and
            tell the WindowsNode Thing to Use Incoming Message
        Updated variable URL to match the existing Octoblu trigger
    Author: Jonathan Rumsey
    Created: 12-Mar-2016
    Updated: 14-Mar-2016; updated menu selection variables and text output
        Incorportate triggeruri property from the object
#>

if (-not (Test-Path -Path .\create-WinNodeCommandsObject.ps1 )) {
    Write-Warning "create-WinNodeCommandsObject.ps1 not found."
    Read-Host "Press the Enter key to quit."
    # exit
}

# Dot-source the WinNodCommandsObject creator and acquire the WindowsNode
. .\create-WinNodeCommandsObject.ps1

# Get the Octoblu Trigger Uri from the object NoteProperty, and set the REST Method
$Uri = $winNodeCommand.triggeruri
$method = "Post"

# Menu
$quitter = $false
while ($quitter -eq $false) {
    "
    Pick one of the following:

    1. Create Meeting (OAuth Token Needed)  A. Create Training (OAuth Token Needed)
    2. MeetNow                              B. Meet now
    3. Join Meeting (ID Needed)             C. Join Training (ID Needed)
    4. Get Meeting ID                       D. Get Meeting ID
    5. Start Screen Sharing                 E. Start Screen Sharing
    6. Pause Screen Sharing                 F. Pause Screen Sharing
    7. Stop Screen Sharing                  G. Stop Screen Sharing
    8. End Meeting                          H. End Training
    
    W. Health Check `"Echo`"
    X. List Plugins

    Q. Quit
    "
    $response = Read-Host -Prompt "Enter the item number of the command you wish to run"

    switch ($response){
        1 {$json_msg = $winNodeCommand.gtm_createMeeting; break}
        2 {$json_msg = $winNodeCommand.gtm_meetNow; break}
        3 {$json_msg = $winNodeCommand.gtm_join; break}
        4 {$json_msg = $winNodeCommand.gtm_getMeetingID; break}
        5 {$json_msg = $winNodeCommand.gtm_startScreenSharing; break}
        6 {$json_msg = $winNodeCommand.gtm_pauseScreenSharing; break}
        7 {$json_msg = $winNodeCommand.gtm_stopScreenSharing; break}
        8 {$json_msg = $winNodeCommand.gtm_endMeeting; break}
        9 {Write-Warning "`nNot implemented. Select something else..`n"; break}

        "A" {$json_msg = $winNodeCommand.gtt_createMeeting; break}
        "B" {$json_msg = $winNodeCommand.gtt_meetNow; break}
        "C" {$json_msg = $winNodeCommand.gtt_join; break}
        "D" {$json_msg = $winNodeCommand.gtt_getMeetingID; break}
        "E" {$json_msg = $winNodeCommand.gtt_startScreenSharing; break}
        "F" {$json_msg = $winNodeCommand.gtt_pauseScreenSharing; break}
        "G" {$json_msg = $winNodeCommand.gtt_stopScreenSharing; break}
        "H" {$json_msg = $winNodeCommand.gtt_endMeeting; break}
        "I" {Write-Warning "`nNot implemented. Select something else..`n"; break}

        "W" {$json_msg = $winNodeCommand.Health; break}
        "X" {$json_msg = $winNodeCommand.ListPlugins; break}
        "Q" {$json_msg = ""; $quitter = $true}
        default {Write-Host "`"$response`" is not a valid selection, try again." -ForegroundColor Red}
    }
    if ($quitter) {
        Write-Host "`nQuit Selected.`n" -ForegroundColor Red
        Write-Host ""
        exit
    }

    "You selected $response; $json_msg."

    # Sends REST call to the configured Uri with selected json message
    Invoke-RestMethod -Method $method -Uri $Uri -Body $json_msg -ContentType "application/json"
}