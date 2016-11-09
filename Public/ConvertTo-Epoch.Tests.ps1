# $here = Split-Path -Parent $MyInvocation.MyCommand.Path
# $sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
# . "$here${directorySeparatorChar}$sut"
Import-Module PsZonar -Force

Describe "ConvertTo-Epoch" {

    Context "Given a valid DateTime value" {

        #arrange
        $expected = 0

        It "Produce an equivalent date" {

            # act
            $actual = ConvertTo-Epoch '01/01/1970 00:00:00'

            # assert
            $actual.GetType() | Should Be Double
            $actual | Should Be $expected
        }

    }

}
