# Health Check

$health_json_msg = @"
{
"Health":[
    {
    "Command":"echo",
    "Argument":"test"
    }
]
}
"@

$list_plugins_json_msg = @"
{
"Service":[
    {
    "Command":"ListPlugins"
    }
]
}
"@

$gtm_create_meeting_oauth_msg = @"
{
"G2m":[
    {
    "Command":"createmeeting",
    "Argument": {
        "oauthtoken": "o9ZX8TtTvNGiTChGZgmsdAH7pBWs"
        }
    }
]
}
"@

$gtm_meet_now_msg = @"
{
"G2m":[
    {
    "Action": "MeetNow" 
    }
]
}
"@

$gtm_join_with_known_id_msg = @"
{
"G2m":[
    {
    "Command": "Join",
    "Argument": "745389829"
    }
]
}
"@

$gtm_end_meeting__msg = @"
{
"G2m":[
    {
    "Command": "endmeeting"
    }
]
}
"@

$gtm_get_sessionID_json_msg = @"
{
"G2m":[
    {
    "Command": "getmeetingid"
    }
]
}
"@

$gtm_start_screen_sharing_msg = @"
{
"G2m":[
    {
    "Command": "startscreensharing" 
    }
]
}
"@

$gtm_stop_screen_sharing_msg = @"
{
"G2m":[
    {
    "Command": "stopscreensharing"
    }
]
}
"@

$gtt_create_meeting_oauth_msg = @"
{
"G2t":[
    {
    "Command":"NOTIMPLEMENTED",
    "Argument": {
        "oauthtoken": "nOtImPlEmEnTeD"
        }
    }
]
}
"@

$gtt_join_with_known_id_msg = @"
{
"G2t":[
    {
    "Command": "Join",
    "Argument": "521998684"
    }
]
}
"@

$gtt_end_meeting__msg = @"
{
"G2t":[
    {
    "Command": "endmeeting"
    }
]
}
"@

$gtt_get_sessionID_json_msg = @"
{
"G2t":[
    {
    "Command": "getmeetingid"
    }
]
}
"@

$gtt_start_screen_sharing_msg = @"
{
"G2t":[
    {
    "Command": "startscreensharing" 
    }
]
}
"@

$gtt_stop_screen_sharing_msg = @"
{
"G2t":[
    {
    "Command": "stopscreensharing"
    }
]
}
"@

$gtt_meet_now_msg = @"
{
"G2t":[
    {
    "Action": "meetnow" 
    }
]
}
"@

$gtt_pause_screensharing_msg = @"
{
"G2t":[
    {
    "Command": "pausescreensharing" 
    }
]
}
"@


$gtt_leave_meeting_msg = @"
{
"G2t":[
    {
    "Command": "leavemeeting" 
    }
]
}
"@

# pick one:
$quitter = $false
while ($quitter -eq $false) {
    "
    Pick one of the following:

    1. Create Meeting                  A. Create Training
    2. Join Meeting (ID: 745389829)    B. Join Training (ID: 929606108)
    3. End Meeting                     C. End Training
    4. MeetNow (tm)                    D. TrainNow (tm)
    5. Get GTM ID                      E. Get GTT ID
    6. GTM Start Screen Sharing        F. GTT Start Screen Sharing
    7. GTM Stop Screen Sharing         G. GTT Stop Screen Sharing

    
    W. Health Check `"Echo`"
    X. List Plugins

    Q. Quit
    "
    $response = Read-Host -Prompt "Enter the item number of the command you wish to run"
    switch ($response){
        1 {$json_msg = $gtm_create_meeting_oauth_msg; Write-Host "`nGTM Plugin - Create Meeting selected.`n" -ForegroundColor Yellow; break}
        2 {$json_msg = $gtm_meet_now_msg; Write-Host "`nGTM Plugin - Meet Now selected.`n" -ForegroundColor Yellow; break}
        3 {$json_msg = $gtm_get_sessionID_json_msg; Write-Host "`nGTM Plugin - Get MeetingID selected.`n" -ForegroundColor Yellow; break}
        4 {$json_msg = $gtm_join_with_known_id_msg; Write-Host "`nGTM Plugin - Join Meeting selected.`n" -ForegroundColor Yellow; break}
        5 {$json_msg = $gtm_start_screen_sharing_msg; Write-Host "`nGTM Plugin - Start Screen Sharing selected.`n" -ForegroundColor Yellow; break}
        8 {$json_msg = $gtm_pause_screen_sharing_msg; Write-Host "'nGTM Plugin - Pause Screen Sharing selected. !!!`n" -ForegroundColor Yellow; break}
        6 {$json_msg = $gtm_stop_screen_sharing_msg; Write-Host "`nGTM Plugin - Stop Screen Sharing selected.`n" -ForegroundColor Yellow; break}
        9 {$json_msg = $gtm_leave_meeting_msg; Write-Host "`nGTM Plugin - Leave Meeting selected. !!!`n" -ForegroundColor Yellow; break}
        7 {$json_msg = $gtm_end_meeting_msg; Write-Host "`nGTM Plugin - End Meeting selected.`n" -ForegroundColor Yellow; break}

        "A" {$json_msg = $gtt_create_meeting_oauth_msg; Write-Host "`nGTT Plugin - Create Training selected.`n" -ForegroundColor Yellow; break}
        "B" {$json_msg = $gtt_meet_now_msg; Write-Host "`nGTT Plugin - TrainNow selected.`n" -ForegroundColor Yellow; break}
        "C" {$json_msg = $gtt_get_sessionID_json_msg; Write-Host "`nGTT Plugin - Get TrainingID selected.`n" -ForegroundColor Yellow; break}
        "D" {$json_msg = $gtt_join_with_known_id_msg; Write-Host "`nGTT Plugin - Join Training selected.`n" -ForegroundColor Yellow; break}
        "E" {$json_msg = $gtt_start_screen_sharing_msg; Write-Host "`nGTT Plugin - Start Screen Sharing selected.`n" -ForegroundColor Yellow; break}
        "H" {$json_msg = $gtt_pause_screensharing_msg; Write-Host "`nGTT Plugin - Pause Screen Sharing selected.`n" -ForegroundColor Yellow; break}
        "F" {$json_msg = $gtt_stop_screen_sharing_msg; Write-Host "`nGTT Plugin - Stop Screen Sharing selected.`n" -ForegroundColor Yellow; break}
        "I" {$json_msg = $gtt_leave_meeting_msg; Write-Host "`nGTT Plugin - Leave Meeting selected.`n" -ForegroundColor Yellow; break}
        "G" {$json_msg = $gtt_end_meeting_msg; Write-Host "`nGTT Plugin - End Training selected.`n" -ForegroundColor Yellow; break}

        "?" {$json_msg = $health_json_msg; Write-Host "`nHealth Plugin selected.`n" -ForegroundColor Yellow; break}
        "!" {$json_msg = $list_plugins_json_msg; Write-Host "`nList Plugins called.`n" -ForegroundColor Yellow; $answered = $true; break}
        "Q" {$json_msg = ""; $quitter = $true}
        default {Write-Host "`"$response`" is not a valid selection, try again." -ForegroundColor Red}
    }
    if ($quitter) {
        Write-Host "`nQuit Selected.`n" -ForegroundColor Red
        Write-Host ""
        exit
    }

Write-Host "Response was `"$response`"." -ForegroundColor Cyan
Write-Host "Json_Msg is: `"$json_msg`"" -ForegroundColor Yellow

# Following Doug Finkle's advice:
<# maessage the JSON
$obj_json_msg = $json_msg | ConvertFrom-Json
$body = $obj_json_msg | ConvertTo-Json
#>

# do
$method = "Post"
$Uri = "https://triggers.octoblu.com/flows/9a3b704c-80a4-4419-93e2-219ef1844a3f/triggers/a5536bf0-88a4-11e5-a8ac-c169a1f48f07"
Invoke-RestMethod -Method $method -Uri $Uri -Body $json_msg -ContentType "application/json"

}
