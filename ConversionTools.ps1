function Convert-MilesToKilometers {
    Param(
        [Parameter(Mandatory=$false,ValueFromPipeline=$true)]
        [ValidateScript( { ([bool]($_ -as [int32]) -or $_ -eq 0) } )]
        [ValidateRange(-2147483648,2147483647)]
        [int32]
        $miles = 0
    )
    try {
        return ( 1.60934 * [math]::Abs($miles) )
    }
    catch {
        Write-Warning "Unable to process the input."
    }
}

function Convert-FahrenheitToCelcius {
    Param(
        [Parameter(Mandatory=$false,ValueFromPipeline=$true)]
        [ValidateScript( { ([bool]($_ -as [int32]) -or $_ -eq 0) } )]
        [ValidateRange(-2147483648,2147483647)]
        [int32]
        $fahrenheit = 0
    )
    try {
        return [math]::Round( ( (5/9) * ( $fahrenheit -32 ) ), 2)
    }
    catch {
        Write-Warning "Unable to process the input."
    }
}

function Round-Number {
    Param(
        [Parameter(Mandatory=$false,ValueFromPipeline=$true,Position=0)]
        [ValidateScript( { ([bool]($_ -as [double]) -or $_ -eq 0) } )]
        [double]
        $input_value = 0,
        [Parameter(Mandatory=$false,ValueFromPipeline=$true,Position=1)]
        [ValidateScript( { ([bool]($_ -as [int16]) -or $_ -eq 0) } )]
        [ValidateRange(-32768,32767)]
        [int16]
        $round_to = 1
    )
    try {
        return [math]::Round( $input_value, [math]::Abs($round_to) )
    }
    catch {
        Write-Warning "Unable to process the input."
    }
}