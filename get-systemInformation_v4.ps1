<#  Title: get-systemInfo
    Description: Acquire WMI info from local or remote computer
    Example: To acquire WMI info from remote host:
        PS:> get-systemInfo [host.domain.ext]
    Example: To acquire WMI info from localhost:
        PS:> get-systemInfo
    Author: Jonathan Rumsey
    Created: Original version circa PowerShell 2.0
    Updated: 23-Dec-2015

    TODO's:
        Detect PS host version (2 or 4) and operate the correct commands (this or external script)
        Detect if run w/out elevation (pass if elevated)

    This script was designed to make PSRemote calls to get WMI information from remote computers one-at-a-time
    1) PowerShell 4.0 installed on host where script is run
    2) Host(s) must be Server 2008, 2008 R2, 2012, or 2012 R2
    3) Script will always prompt for credentials, even if local
    4) WinRM must be enabled on the target host (Enable-PsRemoting)
    5) Set-ExecutionPolicy must be set to RemoteSigned (or more lax policy) on local host
    8) Always launch "As Administrator" to ensure execution and remote rights are in affect
#>

param([string[]] $targets)

# Initialize an output file (clobber old ones)
function init-logfile([string]$log_file) {
    New-Item -Path $log_file -ItemType File -Force
    "`n`n"
    $file_header = "WMI Information Capture File: $target_host"
    $file_header | Tee-Object -FilePath $log_file -Append
    "`n=================================================" | Tee-Object -FilePath $log_file -Append
    $now = (Get-Date).DateTime
    "Logfile initialized $now" | Tee-Object -FilePath $log_file -Append
    "=================================================" | Tee-Object -FilePath $log_file -Append
    " " | Tee-Object -FilePath $log_file -Append
}

# Create a function to handle clearing variables and exiting the script
function run-exitRoutine() {
    # Close the ps session(s)
    foreach ($i in Get-PSSession) {
        Remove-PSSession -Name $i.Name 
    }
    Clear-Variable targets
    Clear-Variable user_creds
    Clear-Variable my_ps_session
    exit
}

Clear-Host
$target_length = $targets.Length
"target_length: $target_length"

# Check for an empty param
try {
    if ( $targets.Length -lt 1 ) {
        # param was empty, assign local computername as the target host
        $targets = $env:COMPUTERNAME
    }
}
catch {
    $this_error = ($Error[0].Exception)
    "Error: $this_error occurred."
}

# Otherwise report back the hostname
finally { 
    "target: $targets"
    "Target(s) checks passed."
}

# Get user credentials so user prompted only once (user MUST pick targets in same domain)    
$user_creds = Get-Credential -Message "PS-Remoting will be used to access WMI on local and remote systems. Enter a domain user account with sufficient priviledges to run WMI queries."

foreach ($target_host in $targets) { 
    "Host: $target_host"
    $log_file_name = "$target_host WMI Information.txt"
    $log_file_wip = Join-Path -Path "$env:userprofile" -ChildPath "Desktop"
    $log_file = "$log_file_wip\$log_file_name"
    init-logfile($log_file)

    # Check if running in ISE, if so, end the script
    if ( (Get-Host).Name -match "PowerShell ISE" ) {
        $now = (Get-Date).DateTime
        "Do not run this script within the PowerShell ISE. Re-run from a PowerShell command-line session." | Out-File -FilePath $env:userprofile\desktop\get-systeminformation-err.log -Force
        "Last run time: $now" | Out-File -FilePath $env:userprofile\desktop\get-systeminformation-err.log -Append
        run-exitRoutine
    }

    # Check if running in PS 4.0, otherwise exit the script
    if ( -not (Get-Host).Version -match "4.0" ) {
        "`n`nThis script is designed specifically for PowerShell v.4.0. The ability to run other versions has not been added yet. Upgrade to PS v.4.0 and try again." | Tee-Object -FilePath $log_file -Append
        run-exitRoutine
    }

    # Define a new PSSession
    try { $my_ps_session = New-PSSession -Computername $target_host -Credential $user_creds }
    catch { 
        "An error occurred.`n$Error[0]" 
        run-exitRoutine
    }

    # Create session and get information from designated computer
    try {
        Invoke-Command -Session $my_ps_session -ScriptBlock {
        "================`nComputer System`n================"
        gwmi -Class Win32_ComputerSystem
        "================`nBIOS`n================"
        gwmi -Class Win32_BIOS | select -Property Caption,Description,Manufacturer,PrimaryBIOS,SMBIOSVersion,Status
        "================`nPhysical Memory`n================"
        gwmi -Class Win32_PhysicalMemory | select -Property Capacity,DataWidth,DeviceLocator,Speed | Format-List
        "================`nEnclosure`n================"
        gwmi -Class Win32_SystemEnclosure | select -Property Manufacturer,Model,SerialNumber,SMBIOSAssetTag | Format-List
        "================`nProcessor(s)`n================"
        gwmi -Class Win32_Processor | select -Property DeviceID,Name,Description,NumberOfCores,CurrentClockSpeed,MaxClockSpeed,Status
        "================`nOperating System`n================"
        gwmi -Class Win32_OperatingSystem | select -Property Name,Caption,Description,OsArchitecture,NumberOfProcesses,Version,ServicePackMajorVersion,ServicePackMinorVersion,WindowsDirectory,LastBootUpTime
        "================`nPage File Setting`n================"
        gwmi -Class Win32_PageFileSetting | select -Property Name,InitialSize,MaximumSize | Format-List
        "================`nPage File Utilization`n================"
        gwmi -Class Win32_PageFileUsage | select -Property Caption,AllocatedBaseSize,CurrentUsage,PeakUsage | Format-List
        "================`nProcesses`n================"
        gwmi -Class Win32_Process | select -Property Name,ExecutablePath | Format-Table
        "================`nServices`n================"
        get-service | where {$_.Status -eq "Running"} | select -Property Status,Name,DisplayName | Format-Table
        "================`nNetwork Adapters`n================"
        gwmi -Class Win32_NetworkAdapter | where {$_.AdapterType -match "Ethernet 802.3"} | select -Property AdapterType,Description,MACAddress,Manufacturer,Name,NetConnectionID,PhysicalAdapter
        "================`nNetwork Configurations`n================"
        gwmi -Class Win32_NetworkAdapterConfiguration | where {$_.IPEnabled -eq "True"} | select -property Description,IPAddress,IPSubnet,DefaultIpGateway,MACAddress,DNSServerSearchOrder,FullDnsRegistrationEnabled,DNSDomainSuffixSearchOrder
        "================`nSCSI Controllers`n================"
        gwmi -Class Win32_ScsiController | select -Property Name,Caption,CreationClassName,DriverName | Format-List
        "================`nTape Drives`n================"
        gwmi -Class Win32_TapeDrive | select -Property Caption,Description,DeviceID,Status
        "================`nLogical Disks`n================"
        gwmi -Class Win32_LogicalDisk -Filter "DriveType=3" | select -Property DeviceID,Size,FreeSpace,VolumeName,VolumeDirty
        "================`nShared Folders`n================"
        gwmi -Class Win32_Share | select -Property Name,Path,Status,Type | Format-List
        "================`nInstalled Products`n================"
        gwmi -Class Win32_Product | select -Property Name,Version | Format-Table
        "================`nQFE Updates`n================"
        gwmi -Class Win32_QuickFixEngineering | select -Property HotFixId,Description,InstalledOn | Format-Table
        } | Tee-Object -FilePath $log_file -Append
    # Tell the operator where to find the output file
    "`n`n=================================================" | Tee-Object -FilePath $log_file -Append
    "`nScript execution completed." | Tee-Object -FilePath $log_file -Append
    "Output log file: $log_file `n"
    }
    catch { 
        "`n================`nAn error occurred while getting WMI info:`n$Error[0] `n================"
        run-exitRoutine 
    }
}

# End of script
run-exitRoutine