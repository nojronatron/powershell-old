$display_commands = New-Object -TypeName PSObject
$display_commands | Add-Member -MemberType NoteProperty -Name "triggerUri" -Value "https://triggers.octoblu.com/flows/4e802560-4b7d-427b-a001-a004066117ed/triggers/040e9820-fb57-11e5-9a0b-631b84899828"

$display_off = (@"
{
    "plugin": "Display",
    "Display": [
    {
        "Command": "Off",
        "Argument": 0
    }
    ]
}
"@ | ConvertFrom-Json )

$display_on = (@"
{
    "plugin": "Display",
    "Display": [
    {
        "Command": "On",
        "Argument": 0
    }
    ]
}
"@ | ConvertFrom-Json )

$display_standby = (@"
{
    "plugin": "Display",
    "Display": [
    {
        "Command": "Standby",
        "Argument": 0
    }
    ]
}
"@ | ConvertFrom-Json )

$display_commands | Add-Member -MemberType NoteProperty -Name "DisplayOff" -Value $display_off
$display_commands | Add-Member -MemberType NoteProperty -Name "DisplayOn" -Value $display_on
$display_commands | Add-Member -MemberType NoteProperty -Name "DisplayStandby" -Value $display_standby

$payload = ( $display_commands.DisplayOff | ConvertTo-Json -Depth 3 )
$payload = ( $display_commands.DisplayOn | ConvertTo-Json -Depth 3 )
$payload = ( $display_commands.DisplayStandby | ConvertTo-Json -Depth 3)

Invoke-RestMethod -Method Post -Uri ($display_commands.triggerUri) -Body $payload -ContentType application/json

# clear-variable display_commands
# clear-variable payload