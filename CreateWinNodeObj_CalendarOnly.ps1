<#  WindowsNode Calendar Control Object
    Description: Creates a JSON representation of a Calendar Plugin Command Set
        useful for testing WindowsNode (hopefully). Points to CHUCK
    Author: Jonathan Rumsey
    Created: Original concept from sometime in the Fall of 2015
    Updated: -original-
#>

# Create new custom PSObject
$calendar_commands = New-Object -TypeName PSObject

# ALPHA TRIGGER
$calendar_commands | Add-Member -MemberType NoteProperty -Name "triggerUri" -Value "https://triggers.octoblu.com/flows/57342e41-1f6c-4ffe-ab50-27150943f374/triggers/5eea8940-fc45-11e5-950b-f906537af42d"

# CHUCK TRIGGER
#$calendar_commands | Add-Member -MemberType NoteProperty -Name "triggerUri" -Value "https://triggers.octoblu.com/flows/480d5bb4-6107-45cb-b12b-fded5a2205bf/triggers/fdfa4e00-01ca-11e6-8b4e-bdd8750384bd"

# SYSTEM HEALTH
$SystemHealth = (@"
{
    "plugin": "Health",
    "Health": [
    {
        "Command": "Echo",
        "Argument": "Is there anybody out there?"
    }
    ]
}
"@ | ConvertFrom-Json)

# CALENDAR CREATE Office365
$CalendarCreateO365 = (@"
{
    "Calendar": [
    {
        "ShowOptions": false,
        "Argument": {
            "Count": 5,
            "AsUTC": false,
            "Appointment": {
                "Required": [
                {
                    "DisplayName": "Jonathan Rumsey",
                    "EmailAddr": "jon@itproctology.com"
                }
                ],
                "Optional": [
                    {}
                ],
                "Start": "2016-04-15T13:30:00-07:00",
                "End": "2016-04-15T14:30:00-07:00",
                "Subject": "Subject1",
                "Body": "Body1",
                "Location": {
                    "DisplayName": "RoomDisplayName1"
                }
            }
        },
        "Command": "Create"
    }
    ]
}
"@ | ConvertFrom-Json )

# CALENDAR CREATE EXCHANGE
$CalendarCreateExchange = (@"
{
    "Plugin": "calendar",
    "Calendar": [
    {
        "ShowOptions": false,
        "Argument": {
            "Count": 5,
            "AsUTC": false,
            "Appointment": {
                "Required": [
                {
                    "DisplayName": "Jonathan Rumsey",
                    "EmailAddr": "jonathan.rumsey@citrix.com"
                }
                ],
                "Optional": [
                    {}
                ],
                "Start": "2016-04-15T11:30:00-07:00",
                "End": "2016-04-14T12:30:00-07:00",
                "Subject": "Subject1",
                "Body": "Body1",
                "Location": {
                    "DisplayName": "RoomDisplayName1"
                }
            }
        },
        "Command": "Create"
    }
    ]
}
"@ | ConvertFrom-Json )


# UPDATE O365
$CalendarUpdateO365 = (@"
{
    "Calendar": [
    {
        "ShowOptions": false,
        "Argument": {
            "Count": 5,
            "AsUTC": false,
            "Appointment": {
                "Required": [
                {
                    "DisplayName": "Jonathan Rumsey",
                    "EmailAddr": "jon@itproctology.com"
                }
                ],
                "Optional": [
                    {}
                ],
                "Start": "2016-04-15T15:30:00-07:00",
                "End": "2016-04-15T17:00:00-07:00",
                "Subject": "Subject1",
                "Body": "Body1",
                "Location": {
                    "DisplayName": "RoomDisplayName1"
                }
            },
            "ID": "____________"
        },
        "Command": "Update"
    }
    ]
}
"@ | ConvertFrom-Json )


# UPDATE EXCHANGE
$CalendarUpdateExchange = (@"
{
    "Plugin": "calendar",
    "Calendar": [
    {
        "ShowOptions": false,
        "Argument": {
            "Count": 5,
            "AsUTC": false,
            "Appointment": {
                "Required": [
                {
                    "DisplayName": "Jonathan Rumsey",
                    "EmailAddr": "jonathan.rumsey@citrix.com"
                }
                ],
                "Optional": [
                    {}
                ],
                "Start": "2016-04-15T11:30:00-07:00",
                "End": "2016-04-14T13:00:00-07:00",
                "Subject": "Subject1",
                "Body": "Body1",
                "Location": {
                    "DisplayName": "RoomDisplayName1"
                }
            },
            "ID": "____________"
        },
        "Command": "Update"
    }
    ]
}
"@ | ConvertFrom-Json )


# GET CURRENT ITEM
$CalendarGetCurrentItem = (@"
{
    "plugin": "Calendar",
    "Calendar": [
    {
        "ShowOptions": false,
        "Argument": 
        {
            "Count": 5,
            "AsUTC": false,
            "Appointment": {
                "Location": {}
            }
        },
        "Command": "GetCurrentItem"
    }
    ]
}
"@ | ConvertFrom-Json)

# GET NEXT ITEMS
$CalendarGetNextItems = (@"
{
    "plugin": "Calendar",
    "Calendar": [
    {
        "ShowOptions": false,
        "Argument": 
        {
            "Count": 5,
            "AsUTC": false,
            "Appointment": {
                "Location": {}
            }
        },
        "Command": "GetNextItems"
    }
    ]
}
"@ | ConvertFrom-Json)

$calendar_commands | Add-Member -MemberType NoteProperty -Name "SystemHealth" -Value $SystemHealth
$calendar_commands | Add-Member -MemberType NoteProperty -Name "CalendarCreateO365" -Value $CalendarCreateO365
$calendar_commands | Add-Member -MemberType NoteProperty -Name "CalendarCreateExchange" -Value $CalendarCreateExchange
$calendar_commands | Add-Member -MemberType NoteProperty -Name "CalendarUpdateO365" -Value $CalendarUpdateO365
$calendar_commands | Add-Member -MemberType NoteProperty -Name "CalendarUpdateExchange" -Value $CalendarUpdateExchange
$calendar_commands | Add-Member -MemberType NoteProperty -Name "CalendarGetCurrentItem" -Value $CalendarGetCurrentItem # Domain-joined
$calendar_commands | Add-Member -MemberType NoteProperty -Name "CalendarGetNextItems" -Value $CalendarGetNextItems # Domain-joined

$payload = ($calendar_commands.SystemHealth | ConvertTo-Json -Depth 3)
$payload = ($calendar_commands.CalendarCreateO365 | ConvertTo-Json -Depth 10)
$payload = ($calendar_commands.CalendarCreateExchange | ConvertTo-Json -Depth 10)
$payload = ($Calendar_commands.CalendarUpdateO365 | ConvertTo-Json -Depth 10)
$payload = ($Calendar_commands.CalendarUpdateExchange | ConvertTo-Json -Depth 10)
$payload = ($calendar_commands.CalendarGetCurrentItem | ConvertTo-Json -Depth 10)
$payload = ($calendar_commands.CalendarGetNextItems | ConvertTo-Json -Depth 10)

Invoke-RestMethod -Method Post -Uri ($calendar_commands.triggerUri) -Body $payload -ContentType application/json

# Clear-Variable calendar_commands
# Clear-Variable payload