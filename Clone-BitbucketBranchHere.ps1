<#
    Title: Clone BitBucket Branch Here
	Description: Use Git via PowerShell to check-out and get the latest code from a specified repo and branch.
		Use for test purposes. DEV should not rely on this script for development and/or patching.
	Author: Jonathan Rumsey, SW Test Engineer II, Citrix
	Created: Sometime in August, 2015
	Latest Changes:
		6-Oct-2015: Removed Ask-Question function; Add Invoke-Function to better handle
			execution flow and better capture comand output.
	
	TODOs:
		Proactively find existing GIT repos and return to user as optional location to select
#>

function Test-IsAdmin {
    <#
        .SYNOPSIS
            Checks to see if current user context of this powershell session is elevated or running with local Administrator privileges.
        .OUTPUTS
            System.Boolean
                True if elevated; False if not.
        .CREDITS
            https://www.stackoverflow.com/questions/9999963/powershell-test-admin-rights-within-powershell-script
    #>

    try {
        return (([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] "Administrator"))
    }
    catch {
        throw "An error occurred while checking if the current user has elevated privileges. The error was: '{0}'." -f $_ 
    }
}

# Variables
$clone_or_update # User updating existing GIT in filepath?
$git_username # Required to connect to private repo
$git_project_name # ID the project code to clone
$desired_branch # Branch of project code to pull
$git_working_directory # File Path to Git files in local
$starting_location = $pwd.Path

# Setup logfile to capture stuff
$log_file = Join-Path $env:userprofile -ChildPath "\desktop\clone_bitbucket_files_here.log"
if (!(Test-Path -Path $log_file)) {
	New-Item -Path $log_file -ItemType File
} else {
    if ("y" -in (Read-Host -Prompt "Logfile $log_file exists. Overwrite (y/n)?").ToLower().Trim()) {
		    New-Item -Path $log_file -ItemType File -Force
    } else {
	    Write-Output "Logfile will be appended"
    }
}
$timestamp = ((get-date).DateTime)
$logfile_entry = ("New logfile started at: $timestamp")
$logfile_entry += "`n---------------------------------`n"
$logfile_entry | Out-File -FilePath $log_file -Append

# Main
Clear-Host

# Test if running in PS ISE, if so, exit. Must run in standard PowerShell context
if ($psISE) {
    "Do not run this script in the PowerShell ISE." | Tee-Object -FilePath $log_file -Append
    Read-Host "Press Enter key to exit."
    exit
} else {
    "PowerShell ISE not detected."  | Tee-Object -FilePath $log_file -Append
}

# Test if running Elevated, if not, exit. Must run this elevated to avoid copy/write/create issues
"`n`nTesting for elevation..." | Tee-Object -FilePath $log_file -Append
if ( (Test-IsAdmin) -eq $false) {
    "Be certain to run this script in an elevated powershell session." | Tee-Object -FilePath $log_file -Append
    Read-Host  "Press Enter to exit this script."
    exit
} else {
    "Elevation test passed. Continuing on." | Tee-Object -FilePath $log_file -Append
}



# Check that git/bin is in local PATH
$git_and_python_paths = @("C:\Program Files (x86)\Git\bin","git\\bin")
"Existing path statement is $env:path" | Tee-Object -FilePath $log_file -Append
$split_path = ($env:path.Split(";").ToLower().Trim())
"split_path is now: $split_path" | Tee-Object -FilePath $log_file -Append
$iterations = 0
do {
    $this_path = $git_and_python_paths[$iterations]
    $this_sub_path = $git_and_python_paths[$iterations + 1]
	"this_path: $this_path" | Tee-Object -FilePath $log_file -Append
	"this_sub_path: $this_sub_path" | Tee-Object -FilePath $log_file -Append
    if (Test-Path -Path $this_path) {
        if (!($split_path -match $this_sub_path)) {
            "Appending $this_sub_path to path for THIS SESSION..." | Tee-Object -FilePath $log_file -Append
            $env:path += ";$this_path"
            "`nBe sure to add $this_path to your local environment variables`n" | Tee-Object -FilePath $log_file -Append
        }
    } else {
        "`nInstall $this_sub_path then rerun this script." | Tee-Object -FilePath $log_file -Append
    }
    $iterations += 2
}
until ($iterations -gt 1)
"`nNew PATH variable now contains these entries:`n" | Tee-Object -FilePath $log_file -Append
($env:PATH).split(";") | Tee-Object -FilePath $log_file -Append
"`n--------------------------------------------------" | Tee-Object -FilePath $log_file -Append

# Acquire Git target directory
"`n" | Tee-Object -FilePath $log_file -Append
Get-ChildItem -LiteralPath 'C:\'  | Tee-Object -FilePath $log_file -Append
"`n" | Tee-Object -FilePath $log_file -Append
$git_directory = Read-Host 'Enter target directory name to copy repo files into (example: C:\my_git_clone) '
if (Test-Path -Path $git_directory) {
    "Folder $git_directory exists!" | Tee-Object -FilePath $log_file -Append
    Get-ChildItem -Path $git_directory | Tee-Object -FilePath $log_file -Append
    Read-Host "Files in $git_directory will be overwritten. Press Enter to proceed or CTRL+C to quit"
    "Removing items in $git_directory..." | Tee-Object -FilePath $log_file -Append
    Invoke-Command -ScriptBlock {Remove-Item -Path $git_directory -Recurse -Force} | Tee-Object -FilePath $log_file -Append
}
if (!(Test-Path -Path $git_directory)) {
    New-Item -Path $git_directory -ItemType Directory
}
Set-Location -Path $git_directory

# Acquire BitBucket username and target project
$bitbucket_username = Read-Host "Enter your BitBucket username" 
$git_project_name = Read-Host "Enter the target project name e.g. red_iot_edu "
"bitbucket_username: $bitbucket_username" | Tee-Object -FilePath $log_file -Append
"git_project_name: $git_project_name" | Tee-Object -FilePath $log_file -Append

# Clone red_iot_edu project repo to PWD (requires username and password)
$git_command = @("https://$bitbucket_username@bitbucket.org/citrixlabsteam/$git_project_name")
"git_command: $git_command" | Tee-Object -FilePath $log_file -Append
Invoke-Command -ScriptBlock {git clone $git_command} | Tee-Object -FilePath $log_file -Append
"`n--------------------------------------------------" | Tee-Object -FilePath $log_file -Append

# Checkout target branch (requires username and password)
$git_working_path = (Join-Path -Path $git_directory -ChildPath $git_project_name)
"git_working_path: $git_working_path" | Tee-Object -FilePath $log_file -Append
Set-Location $git_working_path
"`nFollowing is the current git status output:" | Tee-Object -FilePath $log_file -Append
"`n--------------------------------------------------" | Tee-Object -FilePath $log_file -Append
Invoke-Command -ScriptBlock {git status} | Tee-Object -FilePath $log_file -Append
"`n--------------------------------------------------" | Tee-Object -FilePath $log_file -Append
"`nFollowing is the list of all branches:" | Tee-Object -FilePath $log_file -Append
"`n--------------------------------------------------" | Tee-Object -FilePath $log_file -Append
Invoke-Command -ScriptBlock {git branch -a} | Tee-Object -FilePath $log_file -Append
"`n--------------------------------------------------" | Tee-Object -FilePath $log_file -Append
$desired_branch = Read-Host "Enter the name of the branch to checkout (ex: `"Sprint6`" )"
"`n--------------------------------------------------" | Tee-Object -FilePath $log_file -Append
"desired_branch: $desired_branch" | Tee-Object -FilePath $log_file -Append
Invoke-Command -ScriptBlock {git checkout -b $desired_branch} | Tee-Object -FilePath $log_file -Append
"`n--------------------------------------------------" | Tee-Object -FilePath $log_file -Append

# Pull latest changes to the filesystem (requires username and password)
"`nPulling latest changes into local..." | Tee-Object -FilePath $log_file -Append
"git_command is `"$git_command`"" | Tee-Object -FilePath $log_file -Append
"desired_branch is `"$desired_branch`"" | Tee-Object -FilePath $log_file -Append
Read-Host "Final comand will be `"git pull $git_command $desired_branch`". Okay press Enter key, else CTRL+C to exit"
Invoke-Command -ScriptBlock {git pull $git_command $desired_branch} | Tee-Object -FilePath $log_file -Append
"`n--------------------------------------------------" | Tee-Object -FilePath $log_file -Append

# Confirm git status (for user's sanity)
"`nGit Status output follows..." | Tee-Object -FilePath $log_file -Append
"`n--------------------------------------------------" | Tee-Object -FilePath $log_file -Append
Invoke-Command -ScriptBlock {git status} | Tee-Object -FilePath $log_file -Append
"`n--------------------------------------------------" | Tee-Object -FilePath $log_file -Append
"`n`nEnd of script." | Tee-Object -FilePath $log_file -Append
Set-Location -Path $starting_location