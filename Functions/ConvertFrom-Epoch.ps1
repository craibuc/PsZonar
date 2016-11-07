<#
.SUMMARY
Convert the number of seconds that have elapsed since 1970/01/01 00:00:00 UTC to a date/time value

.PARAMETER UnixTime
The # of seconds since 01/01/1970 00:00:00 UTC to be converted.

.EXAMPLE
PS> ConvertFrom-Epoch 0
Thursday, January 1, 1970 12:00:00 AM

#>
function ConvertFrom-Epoch
{
    [CmdletBinding()]   # enable Write-Verbose
    [OutputType([datetime])]
    param(
        [Parameter(Mandatory = $true,Position=0)]
        [long]$UnixTime
    )

    # $origin = New-Object -Type DateTime -ArgumentList 1970, 1, 1, 0, 0, 0, 0
    [datetime]$origin = '1970-01-01 00:00:00'
    $origin.AddSeconds($UnixTime)

}