function workAroundDupeKeys {
    Param(
        [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
        [ValidateScript( { ( [bool]( $_ -as [string])) } )]
        [string]
        $myDevicesOutput
    )

    try {
        # TODO: Detect the duplicate keys and use variables to fix, instead of hard coding for one specific case
        $jsonified_meshblu_mydevices = ( $myDevicesOutput.ToString().Replace("ConversationID","_ConversationID") | ConvertFrom-Json )
        if ( ($jsonified_meshblu_mydevices.getType().name) -eq "PSCustomObject") {
            return $jsonified_meshblu_mydevices
        } else {
            return "Convert From Json failed."
        }
    }
    catch {
        return "An error occurred."
    }
}


$meshblu_uri = "https://meshblu.octoblu.com/mydevices"
$meshblu_auth_uuid = "a4aa3970-b165-11e4-b992-6f94cdaa9870"
$meshblu_auth_token = "3c0a8dcdcf1e32482ddd3265024b65f71edca0a8"

$headers = @{
    meshblu_auth_uuid=$meshblu_auth_uuid;
    meshblu_auth_token=$meshblu_auth_token;
    accept="application/json"
}

$my_devices = Invoke-RestMethod -Uri $meshblu_uri -Headers $headers -ContentType "application/json" -Method Get

if (-not ($my_devices.devices)) {
    $my_devices | ConvertFrom-Json
    $my_devices_massaged = workarounddupekeys -myDevicesOutput $my_devices
} else {
    $my_devices_massaged = $my_devices
}

[array]$my_devices_uuids = @()

foreach ($item in $my_devices_massaged.devices) {
    if ( ($item.type.toString()) -match "ctxwin") {
        $found_type = $item.type
        $found_name = $item.name
        $found_uuid = $item.uuid
        "Found $found_name, a $found_type, UUID: $found_uuid"
        $my_devices_uuids += $found_uuid
    }
}
