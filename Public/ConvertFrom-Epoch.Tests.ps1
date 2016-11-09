# $here = Split-Path -Parent $MyInvocation.MyCommand.Path
# $sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
# . "$here${directorySeparatorChar}$sut"
Import-Module PsZonar -Force

Describe "ConvertFrom-Epoch" {

    Context "Given a valid Epoch value" {

        #arrange
        $expected = '01/01/1970 00:00:00'

        It "Produce an equivalent date" {

            # act
            $actual = ConvertFrom-Epoch 0

            # assert
            $actual.GetType() | Should Be DateTime
            $actual | Should Be $expected
        }

    }

}
