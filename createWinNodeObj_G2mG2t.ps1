<#  Title: WinNode Command Object Generator
    Description: WindowsNode Octoblu JSON as an Object
    Purpose: Use this to generate a Custom PS Object
        with WindowsNode JSON commands packaged in
        Object Properties with appropriate names.
        Note that invalid properties exist.
    Author: Jonathan Rumsey
    Initial: 12-Mar-2016
    Update: 15-Mar-2016; Generalized NoteProperties for general use
#>

$winNodeCommand = New-Object -TypeName PSObject
$winNodeCommand | Add-Member -MemberType NoteProperty -Name "Health" -Value @('{"Health":[ { "Command":"echo", "Argument":"test" }]}')
$winNodeCommand | Add-Member -MemberType NoteProperty -Name "ListPlugins" -Value @('{"Service":[ { "Command":"ListPlugins" }]}')
$winNodeCommand | Add-Member -MemberType NoteProperty -Name "blank" -Value @('{}')
$winNodeCommand | Add-Member -MemberType NoteProperty -Name "gtm_createMeeting" -Value @('{"G2m":[ { "Command":"createmeeting", "Argument": { "oauthtoken": "placeholderoauthtokendontuse" }}]}')
$winNodeCommand | Add-Member -MemberType NoteProperty -Name "gtm_meetNow" -Value @('{"G2m":[ { "Action": "meetnow" }]}')
$winNodeCommand | Add-Member -MemberType NoteProperty -Name "gtm_join" -Value @('{"G2m":[ { "Command": "join", "Argument": "123-456-789" }]}')
$winNodeCommand | Add-Member -MemberType NoteProperty -Name "gtm_endMeeting" -Value @('{"G2m":[ { "Command": "endmeeting" }]}')
$winNodeCommand | Add-Member -MemberType NoteProperty -Name "gtm_getMeetingID" -Value @('{"G2m":[ { "Command": "getmeetingid" }]}')
$winNodeCommand | Add-Member -MemberType NoteProperty -Name "gtm_startScreenSharing" -Value @('{"G2m":[ { "Command": "startscreensharing"  }]}')
$winNodeCommand | Add-Member -MemberType NoteProperty -Name "gtm_stopScreenSharing" -Value @('{"G2m":[ { "Command": "stopscreensharing" }]}')
$winNodeCommand | Add-Member -MemberType NoteProperty -Name "gtm_pauseScreenSharing" -Value @('{"G2m":[ { "Command": "pausescreensharing" }]}')
$winNodeCommand | Add-Member -MemberType NoteProperty -Name "gtm_leaveMeeting" -Value @('{"G2m":[ { "Command": "leavemeeting" }]}')
$winNodeCommand | Add-Member -MemberType NoteProperty -Name "alpha_numeric" -Value @('{a1b2c3d4e5}')
$winNodeCommand | Add-Member -MemberType NoteProperty -Name "gtt_createMeeting" -Value @('{"G2t":[ { "Command":"NOTIMPLEMENTED", "Argument": { "oauthtoken": "placeholderoauthtokendontuse" }')
$winNodeCommand | Add-Member -MemberType NoteProperty -Name "gtt_meetNow" -Value @('{"G2t":[ { "Action": "meetnow" }]}')
$winNodeCommand | Add-Member -MemberType NoteProperty -Name "gtt_join" -Value @('{"G2t":[ { "Command": "join", "Argument": "123-456-789" }')
$winNodeCommand | Add-Member -MemberType NoteProperty -Name "gtt_endMeeting" -Value @('{"G2t":[ { "Command": "endmeeting" }]}')
$winNodeCommand | Add-Member -MemberType NoteProperty -Name "gtt_getMeetingID" -Value @('{"G2t":[ { "Command": "getmeetingid" }]}')
$winNodeCommand | Add-Member -MemberType NoteProperty -Name "gtt_startScreenSharing" -Value @('{"G2t":[ { "Command": "startscreensharing"  }]}')
$winNodeCommand | Add-Member -MemberType NoteProperty -Name "gtt_stopScreenSharing" -Value @('{"G2t":[ { "Command": "stopscreensharing" }]}')
$winNodeCommand | Add-Member -MemberType NoteProperty -Name "gtt_pauseScreenSharing" -Value @('{"G2t":[ { "Command": "pausescreensharing" }]}')
$winNodeCommand | Add-Member -MemberType NoteProperty -Name "gtt_leaveMeeting" -Value @('{"G2t":[ { "Command": "leavemeeting" }]}')
$winNodeCommand | Add-Member -MemberType NoteProperty -Name "special_characters" -Value @('{*,-~//\\`}')
$winNodeCommand | Add-Member -MemberType NoteProperty -Name "triggerUri" -Value @('{https://octoblu-trigger-uri-to-your-flow}')
