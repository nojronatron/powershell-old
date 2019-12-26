<#  Title: Process, Service, and TCP/UDP Port Analyzer
    Description: Simple testing tool that gathers and
        analyzes state information using simple before
        and after differencing.
    Usage: Run this script prior to executing a script
        or application. Once the application has been
        launched come back to this script's window and
        press the Enter key to gather diff data and
        start analysis.
    Author: Jonathan Rumsey
    Credits: Some functions were inspired or borrowed
        from posters @ StackExchange.com
    Created: 15-June-2015
    Latest Change: 16-June-2015 (Better comparison, Tee output, other minor fit-n-finish items)
#>

# Init logfile and reused variables
$logFile = "${env:userprofile}\desktop\PrePostProcessPortsLog.txt"
$now = Get-Date
$statusMsg = "Working."
Write-Output "Execution Run: $now" | Out-File -FilePath $logFile -Force

# Gather info on processes, services, and network ports
Write-Output $statusMsg
$preProcesses = Get-Process
$statusMsg += "."
Write-Output $statusMsg
$preServices = Get-Service
$statusMsg += "."
Write-Output $statusMsg
$prePorts = Invoke-Command -ScriptBlock {cmd.exe /c netstat -ao}
Write-Output "Done capturing get-process and netstat command outputs."

# Tell user to start-up the code/app/thingy and come back here to run the rest of the analysis script
$userPrompt = Read-Host "Run your code and then return here and press the Enter key"
$statusMsg += "."
Write-Output $statusMsg
$postProcesses = Get-Process
$statusMsg += "."
Write-Output $statusMsg
$postServices = Get-Service
$statusMsg += "."
Write-Output $statusMsg
$statusMsg += "."
Write-Output $statusMsg
$postPorts = Invoke-Command -ScriptBlock {cmd.exe /c netstat -ao}

# Output findings - some to logfile only, others to both screen and logfile
Write-Output "Writing data to logfiles..."
"Processes Running Prior to code execution --------------------" | Tee-Object -FilePath $logFile -Append | Write-Output
$preProcesses | sort -Property ProcessName | Out-File -FilePath $logFile -Append
"`n`nServices Running Prior to code execution --------------------" | Tee-Object -FilePath $logFile -Append | Write-Output
$preServices | sort -Property Name | Out-File -FilePath $logFile -Append
"`n`nNetwork Ports Listing Prior to  code execution --------------------" | Tee-Object -FilePath $logFile -Append | Write-Output
$prePorts | Out-File -FilePath $logFile -Append
"`n`nProcesses Running After code execution --------------------" | Tee-Object -FilePath $logFile -Append | Write-Output
$postProcesses | sort -Property ProcessName | Out-File -FilePath $logFile -Append
"`n`nServicees Running After code execution --------------------" | Tee-Object -FilePath $logFile -Append | Write-Output
$postServices | sort -Property Name | Out-File -FilePath $logFile -Append
"`n`nNetwork Ports Listing After code execution --------------------" | Tee-Object -FilePath $logFile -Append | Write-Output
$postPorts | Out-File -FilePath $logFile -Append

# Allow file-writes to finish up (on slower systems)
Start-Sleep -Seconds 3

# Compare and output
"`nDifferencing Analysis: Processes --------------------" | Tee-Object -FilePath $logFile -Append | Write-Output
Compare-Object -ReferenceObject $preProcesses -DifferenceObject $postProcesses -PassThru | Tee-Object -FilePath $logFile -Append | Write-Output
"`nDifferencing Analysis: Services --------------------" | Tee-Object -FilePath $logFile -Append | Write-Output
Compare-Object -ReferenceObject $preServices -DifferenceObject $postServices -PassThru | Tee-Object -FilePath $logFile -Append | Write-Output
"`nDifferencing Analysis: Ports --------------------" | Tee-Object -FilePath $logFile -Append | Write-Output
$postPorts | where { $prePorts -notcontains $_ } | Tee-Object -FilePath $logFile -Append | Write-Output

# Finish up logging
Write-Output "`n`n<EOF>" | Out-File -FilePath $logFile -Append
Write-Output "Script completed. See << $logFile >> for output."

# Clear variables.
Clear-Variable preProcesses
Clear-Variable preServices
Clear-Variable prePorts
Clear-Variable postProcesses
Clear-Variable postServices
Clear-Variable postPorts
Clear-Variable logFile