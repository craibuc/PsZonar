<#
.SUMMARY
Convert a SecureString to plain (i.e. unsecured) text

.EXAMPLE
PS > $password = ConvertTo-SecureString 'pa55w0rd' -AsPlainText -Force
PS > ConvertTo-PlainText $password
'pa55word'

#>
function ConvertTo-PlainText
{

    [CmdletBinding()]   # enable Write-Verbose
    param(
        [Parameter(Mandatory=$true,Position=0)]
        [SecureString]$SecureString
    )

    # $SecurePassword = ConvertTo-SecureString $PlainPassword
    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecureString)
    [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

}
