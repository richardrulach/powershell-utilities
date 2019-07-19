
# RESET PROJECT
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
Get-Module ProjectTools | Remove-Module -Force
Import-Module $here\ProjectTools.psm1 -Force

Describe "Tests on Get-DBO" {

    Context "First Test" {
        
        It "Call Get-DBO" {
            Get-DBO | Should -BeNullOrEmpty   
        }

    }

}