$Path = $env:PSModulePath -split ";" -match $env:USERNAME 

# Note, most modules in Program Files or system32
# Get-Module -ListAvailable | where { $_.Name -match "P" } | Select-Object -Property Name,Path

function Get-UserModulePath {
 
    $Path = $env:PSModulePath -split ";" -match $env:USERNAME
 
    if (-not (Test-Path -Path $Path))
    {
        New-Item -Path $Path -ItemType Container | Out-Null
    }
        $Path
}
 
Invoke-Item (Get-UserModulePath)

if (Get-Module -ListAvailable -Name Pester) {
    Import-Module Pester
    Get-Module -Name Pester | Select -ExpandProperty ExportedCommands
    Start-Sleep -Seconds 1
    "`nModule PESTER import operation completed."
} else {
    "`nModule PESTER not found."
}

if (Test-Path "C:\Pester") {
    "`n"
    gci -Path "C:\Pester"
    "`nPath C:\Pester already exists. Go play!"
} else {
    "`nCreating path C:\Pester for you to play in."
    New-Item -Path "C:\Pester" -ItemType Directory
}

