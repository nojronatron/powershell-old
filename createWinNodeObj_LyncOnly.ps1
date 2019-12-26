<#  Lync JSON Control Object
    Description: Creates a JSON representation of a Lync Plugin Command Set
        useful for testing WindowsNode (hopefully).
    Author: Jonathan Rumsey
    Created: Original concept from sometime in the Fall of 2015
    Updated: 13-Apr-2016 ~ All existing member messages validated
#>

# Create new custom PSObject
$lync_commands = New-Object -TypeName PSObject
$lync_commands | Add-Member -MemberType NoteProperty -Name "triggerUri" -Value "https://triggers.octoblu.com/flows/57342e41-1f6c-4ffe-ab50-27150943f374/triggers/5eea8940-fc45-11e5-950b-f906537af42d"

# workaround MeetNow
$LyncMeetNow = (@"
{
    "Lync": [
    {
        "Argument": {
            "Subject": "Subject1",
            "Description": "CreatedConference"
        },
        "Command": "MeetNow",
        "ShowOptions": false
    }
    ]
}
"@ | ConvertFrom-Json )

# JOIN MEETING
$LyncJoin = (@"
{
    "Lync":  [
    {
        "ShowOptions": false,
        "Argument":  {
            "trackParticipants":  false,
            "Subject":  "Conference",
            "Description":  "Scheduled Conference",
            "ConferenceAccessLevel":  "SameEnterprise",
            "LobbyByPass":  "Disabled",
            "LeaderAssignment":  "SameEnterprise",
            "JoinURL": "https://meet.citrix.com/jonathan.rumsey/Q0NGQ139"
        },
        "Command":  "Join"
    }
]
}
"@ | ConvertFrom-Json)

# END MEETING
$LyncEndMeeting = (@"
{
    "Lync":  [
    {
        "ShowOptions": false,
        "Argument": {
            "TrackParticipants": false,
            "Subject": "Conference1",
            "Description": "Scheduled Conference1",
            "ConferenceAccessLevel": "Invited",
            "LobbyByPass": "Disabled",
            "LeaderAssignment": "SameEnterprise",
            "JoinURL": "https://meet.citrix.com/jonathan.rumsey/Q0NGQ139",
            "phoneNumber": "4258954729",
            "Participants": [
                null
            ],
            "ConversationID": "AdGVts9UkGByl5XkTPaPItaNVaDxUg=="
        },
    "Command": "EndMeeting"
    }
    ]
}
"@ | ConvertFrom-Json) # ConversationID is "ID" returned after JOIN

# SET FULL SCREEN
$LyncSetFullScreen = (@"
{
    "Lync":  [
    {
        "ShowOptions": false,
        "Argument": {
            "TrackParticipants": false,
            "Subject": "Conference1",
            "Description": "Scheduled Conference1",
            "ConferenceAccessLevel": "Invited",
            "LobbyByPass": "Disabled",
            "LeaderAssignment": "SameEnterprise",
            "JoinURL": "https://meet.citrix.com/jonathan.rumsey/Q0NGQ139",
            "phoneNumber": "4258954729",
            "Participants": [
                null
            ],
            "ConversationID": "AdGVts9UkGByl5XkTPaPItaNVaDxUg=="
        },
    "Command": "SetFullScreen"
    }
    ]
}
"@ | ConvertFrom-Json)

# EXIT FULL SCREEN
$LyncExitFullScreen = (@"
{
    "Lync":  [
    {
        "ShowOptions": false,
        "Argument": {
            "TrackParticipants": false,
            "Subject": "Conference1",
            "Description": "Scheduled Conference1",
            "ConferenceAccessLevel": "Invited",
            "LobbyByPass": "Disabled",
            "LeaderAssignment": "SameEnterprise",
            "JoinURL": "https://meet.citrix.com/jonathan.rumsey/Q0NGQ139",
            "phoneNumber": "4258954729",
            "Participants": [
                null
            ],
            "ConversationID": "AdGVts9UkGByl5XkTPaPItaNVaDxUg=="
        },
    "Command": "ExitFullScreen"
    }
    ]
}
"@ | ConvertFrom-Json)

# ADD PARTICIPANTS
$LyncAddParticipants = (@"
{
    "Lync":  [
    {
        "Argument": {
            "Subject": "Conference1",
            "Description": "Scheduled Conference1",
            "Participants": [
                "jon@itproctology.com",
                "kiran@itproctology.com",
                "brian@itproctology.com"
            ],
            "ConversationID": "AdGVts9UkGByl5XkTPaPItaNVaDxUg=="
        },
        "Command": "AddParticipants",
        "ShowOptions": false
        }
    ]
}
"@ | ConvertFrom-Json)

# REMOVE PARTICIPANTS
$LyncRemoveParticipants = (@"
{
    "Lync":  [
    {
        "Argument": {
            "Subject": "Conference1",
            "Description": "Scheduled Conference1",
            "Participants": [
                "kiran@itproctology.com"
            ],
            "ConversationID": "AdGVts9UkGByl5XkTPaPItaNVaDxUg=="
        },
        "Command": "RemoveParticipants",
        "ShowOptions": false
        }
    ]
}
"@ | ConvertFrom-Json)

# START APPLICATION SHARE
$LyncStartApplicationShare = (@"
{
    "Lync":  [
    {
        "ShowOptions": false,
        "Argument": {
            "TrackParticipants": false,
            "Subject": "Conference1",
            "Description": "Scheduled Conference1",
            "ConferenceAccessLevel": "Invited",
            "LobbyByPass": "Disabled",
            "LeaderAssignment": "SameEnterprise",
            "JoinURL": "https://meet.citrix.com/jonathan.rumsey/Q0NGQ139",
            "phoneNumber": "4258954729",
            "Participants": [
                null
            ],
            "ConversationID": "AdGVts9UkGByl5XkTPaPItaNVaDxUg=="
        },
    "Command": "StartApplicationShare"
    }
    ]
}
"@ | ConvertFrom-Json)

# SYSTEM HEALTH
$SystemHealth = (@"
{
    "plugin": "Health",
    "Health": [
    {
        "Command": "Echo",
        "Argument": "Welcome to the machine!"
    }
    ]
}
"@ | ConvertFrom-Json)


# Add objects as a members of the new custom PSObject

#LyncCreateConference BUG
$lync_commands | Add-Member -MemberType NoteProperty -Name "LyncJoin" -Value $LyncJoin 
$lync_commands | Add-Member -MemberType NoteProperty -Name "LyncSetFullScreen" -Value $LyncSetFullScreen
$lync_commands | Add-Member -MemberType NoteProperty -Name "LyncExitFullScreen" -Value $LyncExitFullScreen
$lync_commands | Add-Member -MemberType NoteProperty -Name "LyncAddParticipants" -Value $LyncAddParticipants
$lync_commands | Add-Member -MemberType NoteProperty -Name "LyncRemoveParticipants" -Value $LyncRemoveParticipants
$lync_commands | Add-Member -MemberType NoteProperty -Name "LyncStartApplicationShare" -Value $LyncStartApplicationShare
#LyncLeaveMeeting NOT IMPLEMENTED
$lync_commands | Add-Member -MemberType NoteProperty -Name "LyncEndMeeting" -Value $LyncEndMeeting
$lync_commands | Add-Member -MemberType NoteProperty -Name "SystemHealth" -Value $SystemHealth
# Workarounds
$lync_commands | Add-Member -MemberType NoteProperty -Name "LyncMeetNow" -Value $LyncMeetNow

# Setup Payload
$payload = ( $lync_commands.SystemHealth | ConvertTo-Json -Depth 3 )
$payload = ( $lync_commands.LyncMeetNow | ConvertTo-Json -Depth 10 )

# POST the REST call
Invoke-RestMethod -Method Post -Uri ($lync_commands.triggerUri) -Body $payload -ContentType application/json

# clear-variable lync_commands
# clear-variable payload