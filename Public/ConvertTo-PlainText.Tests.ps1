# $here = Split-Path -Parent $MyInvocation.MyCommand.Path
# $sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
# . "$here${directorySeparatorChar}$sut"
Import-Module PsZonar -Force

Describe "ConvertTo-PlainText" {

    Context "A System.SecureString is supplied" {

        # arrange
        $expected = 'pa55w0rd'
        $securePassword = ConvertTo-SecureString $expected -AsPlainText -Force

        It "Generates its unencrypeted representation" {
            # act
            $actual = ConvertTo-PlainText $securePassword

            #assert
            $actual | Should Be $expected
        }
    }

}
