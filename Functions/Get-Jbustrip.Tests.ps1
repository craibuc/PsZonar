$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here${directorySeparatorChar}$sut"

Describe "Get-Jbustrip" {

    # arrange
    $credential = Get-Credential

    Context "When valid credentials and dates are supplied" {

        It "returns a array of PsCustomObjects" {
            # act
            $actual = Get-Jbustrip -Credential $credential -StartingDate '11/01/2016' -EndingDate '11/01/2016' -Verbose

            # assert
            $actual | Should Be PsObject[]
            
        }

    }

}
