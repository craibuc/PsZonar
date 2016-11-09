# $here = Split-Path -Parent $MyInvocation.MyCommand.Path
# $sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
# . "$here${directorySeparatorChar}$sut"
Import-Module PsZonar -Force

Describe "Get-Jbustrip" {

    # arrange
    $credential = Get-Credential
    $startingDate = [DateTime]::Today.AddHours(-1) # yesterday @ 00:00:00
    $endingDate = [DateTime]::Today.AddSeconds(-1) # yesterday @ 23:59:59

    Context "When valid credentials and dates are supplied" {

        It "returns a array of PsCustomObjects" {
            # act
            $actual = Get-Jbustrip -Credential $credential -StartingDate $startingDate -EndingDate $endingDate -Verbose

            # assert
            $actual | Should Be System.Xml.XmlDocument

        }

    }

}
