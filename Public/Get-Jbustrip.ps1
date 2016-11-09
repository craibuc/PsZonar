<#

.SUMMARY
Get XML data from Zonar's XML web-service

.PARAMETER Credential
PsCredential object

.PARAMETER StartingDate
Start of the period to be retrieved.

.PARAMETER EndingDate
End of the period to be retrieved.

.EXAMPLE
# Get credentials interactively.
PS> Get-Jbustrip -Credential Get-Credential -StartingDate '10/31/2016' -EndingDate '10/31/2016 23:59:59'

.EXAMPLE
# store the credentials
PS> $credential = Get-Credential

# store starting date
PS> $sd = [DateTime]::Today.AddDays(-1)

# store ending date
PS> $ed = [DateTime]::Today.AddSeconds(-1)

# get XML data from service
PS> $xml = Get-Jbustrip -Credential $credential -StartingDate $sd -EndingDate $ed

# display the results
PS> $xml.jbustrip.trip.asset

#>
function Get-Jbustrip
{
    [CmdletBinding()]   # enable Write-Verbose
    param(
        [Parameter(Mandatory=$true)]
        [pscredential]$Credential,

        [Parameter(Mandatory = $true)]
        [Alias('sd')]
        [datetime]$StartingDate,

        [Parameter(Mandatory = $true)]
        [Alias('ed')]
        [datetime]$EndingDate    )

    $start = Get-Date

    # convert date/time to Epoch
    # numbor of seconds that have elapsed since 1970/01/01 00:00:00 UTC
    $startingEpoch = ConvertTo-Epoch $StartingDate
    $endingEpoch = ConvertTo-Epoch $EndingDate

    # $endpoint='https://lor0540.zonarsystems.net/interface.php'
    $endpoint = $MyInvocation.MyCommand.Module.PrivateData.PSData.ZonarUrl
    Write-Debug "EP: $endpoint"

    $url = "$endpoint`?action=showopen&format=xml&operation=jbustrip&start=$startingEpoch&end=$endingEpoch"
    Write-Debug $url

    $password = ConvertTo-PlainText $Credential.Password

    # get XML from service
    # (Invoke-WebRequst -u $url -c (New-Credential -user  $Credential.UserName -password $password)).Content
    [xml]( Invoke-WebRequest -Uri $url -Credential $Credential ).Content

    # time required to perform action
    Write-Verbose "Get-Jbustrip: $( (Get-Date) - $start)"

    # add name of operation to object so it can be included in the pipeline
    # Add-Member -InputObject $results NoteProperty 'Operation' $operation
    # Add-Member -InputObject $results NoteProperty 'Records' $operation

    # return an object that contains the results + metadata
    # $result = [PSCustomObject] @{
    #     'Operation' = $operation;
    #     'Data' = $data;
    #     'Url' = $url
    # }
    # return to pipeline
    # $result

}


##
# alias
#

Set-Alias jbustrip Get-Jbustrip
