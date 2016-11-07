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
PS> Get-Jbustrip -Credential Get-Credential -StartingDate '10/01/2016' -EndingDate '10/31/2016'

Get credentials interactively.

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
    $startingEpoch = ConvertTo-Epoch $StartinDate
    $endingEpoch = ConvertTo-Epoch $EndingDate

    # $endpoint='https://lor0540.zonarsystems.net/interface.php'

    $url = "$($Host.PrivateData.ZonarUrl)?action=showopen&format=xml&operation=jbustrip&start=$startingEpoch&end=$endingEpoch"
    Write-Verbose $url
    
    $password = ConvertTo-PlainText $Credential.Password

    # get XML from service
    # (Invoke-WebRequst -u $url -c (New-Credential -user  $Credential.UserName -password $password)).Content
    ( Invoke-WebRequst -Url $url -Credential $Credential ).Content

    # time required to perform action
    Write-Verbose "Get-Jbustrip: $( Get-Date - $start)"

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
