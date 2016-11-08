<#
.SUMMARY
Convert a date/time value to the number of seconds that have elapsed since 1970/01/01 00:00:00 UTC

.PARAMETER Date
The System.DateTime value to be converted.

.EXAMPLE
PS> ConvertTo-Epoch '01/01/1970 00:00:00'
0

#>
function ConvertTo-Epoch
{
    [CmdletBinding()]   # enable Write-Verbose
    [OutputType([long])]    
    param(
        [Parameter(Mandatory = $true,Position=0)]
        [datetime]$Date
    )

    $origin = Get-Date -Date "01/01/1970"
    # calculate the number of seconds between the specified date and 1/1/1970
    (New-TimeSpan -Start $origin -End $Date).TotalSeconds

}