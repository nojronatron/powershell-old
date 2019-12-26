function Get-UserModulePath {
    $Path = $env:PSModulePath -split ";" -match $env:USERNAME
    if (-not (Test-Path -Path $Path))
    {
        New-Item -Path $Path -ItemType Container | Out-Null
    }
        $Path
}
Invoke-Item (Get-UserModulePath)

if (-not (Test-Path "C:\Pester") ) {
    New-Item -Path "C:\Pester" -ItemType Directory -Force
    Start-Sleep -Seconds 1
    Read-Host "Extract Pester zip files to C:\Pester and then press the Enter key to continue."
} else {
    "C:\Pester exists. Will not overwrite."
}

Set-Location -Path "C:\Pester"

Get-Module -ListAvailable -Name Pester
Import-Module Pester
Get-Module -Name Pester | Select -ExpandProperty ExportedCommands
