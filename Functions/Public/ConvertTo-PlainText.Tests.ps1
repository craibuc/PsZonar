$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here${directorySeparatorChar}$sut"

Describe "ConvertTo-PlainText" {

    Context "A System.SecureString is supplied" {

        # arrange
        $password = 'pa55w0rd'
        $securePassword = ConvertTo-SecureString $password -AsPlainText -Force

        It "Generates its unencrypeted representation" {
            # act
            $actual = ConvertTo-PlainText $securePassword

            #assert
            $actual | Should Be $expected
        }        
    }

}
