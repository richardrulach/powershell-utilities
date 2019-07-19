
# RESET PROJECT
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
Get-Module ProjectTools | Remove-Module -Force
Import-Module $here\ProjectTools.psm1 -Force

Describe "Tests on Get-SPTable" {

    Context "First set of tests" {

        It "Returns Nothing" {
            Get-SPTable | Should -BeNullOrEmpty
        }

    }

}
