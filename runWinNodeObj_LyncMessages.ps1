<#  Title: Run WinNodeObj_LyncOnly commands
    Description: Loads the Lync Only commands as an object
        and sends them to an Octoblu Flow for execution.
    Author: Jonathan Rumsey
    Initial: 12-Apr-2016
    Update (date, action):
#>

. .\$Home\Desktop\createWinNodeObj_LyncOnly.ps1

# JSON format validation
$lync_commands | Select-Object -Property LyncRemoveParticipants | ConvertTo-Json -Depth 10

# Setup Payload
$payload = ($lync_commands.LyncJoin | ConvertTo-Json -Depth 10)
$payload = ($lync_commands.LyncAddParticipants | ConvertTo-Json -Depth 10)
$payload = ($lync_commands.LyncStartApplicationShare | ConvertTo-Json -Depth 10)
$payload = ($lync_commands.LyncSetFullScreen | ConvertTo-Json -Depth 10)
$payload = ($lync_commands.LyncExitFullScreen | ConvertTo-Json -Depth 10)
$payload = ($lync_commands.LyncRemoveParticipants | ConvertTo-Json -Depth 10)
$payload = ($lync_commands.LyncEndMeeting | ConvertTo-Json -Depth 10)
$payload = ($lync_commands.SystemHealth | ConvertTo-Json -Depth 3)

# Send Rest call with JSON to Octoblu trigger
Invoke-RestMethod -Method Post -Uri ($lync_commands.triggerUri) -Body $payload -ContentType application/json

# Clear-Variable lync_commands
# Clear-Variable payload