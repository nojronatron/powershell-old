param
    (
        [parameter(Mandatory=$false,
            Position=0,
            HelpMessage="Enter the path that contains the files to compress.")]
            [String[]] $source_folder,
        [parameter(Mandatory=$false,
            Position=1,
            HelpMessage="Enter a path and filename like 'C:\foo\bar.zip'.")]
            [string[]] $target_zip_file
    )

Write-Host "Source Folder $source_folder."
Write-Host "Target Zip File $target_zip_file."
<#
$Size1 = $source_folder.Count
$Size2 = $target_zip_file.Count
Write-Host "Source Folder length is $Size1 and Target Zip file length is $Size2."
#>

# Clear-Host
$starting_path = $pwd.Path
$curr_path = $pwd.Path

$valid_source = $false

while ( -not $valid_source) {
    if (Test-Path -Path $source_folder ) {
        $valid_source = $true
    } else {
    Write-Host "A valid source path was not found." -ForegroundColor Red
    $source_folder = Read-Host "Enter the path that contains the files to compress."
    }
}
Write-Host "Target path `"$source_folder`" is valid." -ForegroundColor Cyan

$valid_extension = $false

while ( -not $valid_extension) {
    if ( -not ($target_zip_file -match ".zip") ) {
        Write-Host "The target filename should end in `".zip`". Appending ZIP extension." -ForegroundColor Red
        $target_zip_file += ".zip"
    } else {
        Write-Host "The target filename ends in `".zip`"." -ForegroundColor Cyan
        $valid_extension = $true
    }
}
Write-Host "Destination Zip Path `"$target_zip_file`" is valid." -ForegroundColor Cyan
"`n`n"

try {
    Write-Host "Attempting to zip $source_folder into $target_zip_file" -ForegroundColor Yellow
    if ( -not (Test-Path -Path $target_zip_file ) ) {
        # Do something (to deal with the "-DestinationPath" argument)
    }
    Invoke-Command -ScriptBlock { Compress-Archive -Path $source_folder -DestinationPath $target_zip_file -Update | Write-Host -ForegroundColor Yellow }
}
catch {
    Write-Host "Something went wrong!" -ForegroundColor Red
    Write-Host $Error[0]
}
finally {
    Set-Location -Path $starting_path
    Write-Host "Operation completed." -ForegroundColor Cyan
    " "
}
