<#  Title: 
    Description: Notify the launcher if an PING failures occur while running.
    Author: Jonathan Rumsey
    Created: 31-Aug-2016
    Updates:
		- Simplifications like 1 instead of 10 count, wrap everything in try/catch/finally, and use -erroraction stop to control failure mode.
#>

Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [string]
    $target_host_or_ipaddr
)

try {
    if ( $target_host_or_ipaddr.Length -ge 7 ) {
        while ($true) {
            Test-Connection -Count 1 -ComputerName $target_host_or_ipaddr -ErrorAction Stop | Out-Null
        } else {
            "Could not contact $target_host_or_ipaddr."
            $buttons=[System.Windows.Forms.MessageBoxButtons]::OKCancel
            [System.Windows.Forms.MessageBox]::Show($Error[0],"",$buttons)
            break
        }
    }   
}
catch {
    "Something went wrong:`n$Error[0]"
}
finally {
    "The script has exited."
}