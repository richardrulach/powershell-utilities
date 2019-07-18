
# RESET PROJECT
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
Get-Module ProjectTools | Remove-Module -Force
Import-Module $here\ProjectTools.psm1 -Force


Describe 'Error checks on New-Ticket' {

    Context 'Return error messages' {

        # setup folders
        New-Item -Path "$((Get-PSDrive TestDrive).Root)\AS-2000 - Already exists" -ItemType "directory"

        (Get-PSDrive TestDrive).Root

        It 'Throws error when path does not exist' {
            { New-Ticket -Ticket "AS-0001" -Path "$((Get-PSDrive TestDrive).Root)\djsfhjk" } | Should -Throw "Path does not exist"
        } 


        It 'Throws error when ticket folder exists' {
            { New-Ticket -Ticket "AS-2000" -Path "$((Get-PSDrive TestDrive).Root)" } | Should -Throw "Ticket folder already exists - use force to create anyway"
        } 

        It 'Throws error when any ticket folder exists (multiple tickets)' {
            { New-Ticket -Ticket "AS-1999","AS-2000" -Path "$((Get-PSDrive TestDrive).Root)" } | Should -Throw "Ticket folder already exists - use force to create anyway"
        } 

        It 'Returns hash table when ticket folder exists but force is used' {
            New-Ticket -Ticket "AS-2000" -Path "$((Get-PSDrive TestDrive).Root)" -Force | Should -BeOfType  System.Collections.Hashtable
        } 

        It 'Returns hash table for valid input' {
            New-Ticket -Ticket "AS-0001" -Path "$((Get-PSDrive TestDrive).Root)" | Should -BeOfType  System.Collections.Hashtable
        } 

        It 'Returns two hash tables for valid input (multiple tickets)' {
            New-Ticket -Ticket "AS-1996","AS-1997" -Path "$((Get-PSDrive TestDrive).Root)" | Should -BeOfType System.Collections.Hashtable
            New-Ticket -Ticket "AS-1994","AS-1995" -Path "$((Get-PSDrive TestDrive).Root)" | Should -HaveCount 2
        } 



    } 
} -Tag "error"

Describe 'Tests on New-Ticket' {

    Context 'Create all folders' {

        $hs = (New-Ticket -Ticket "AS-0001" -Path "$((Get-PSDrive TestDrive).Root)")


        It 'sql files created' {
            $hs["sql"] | Should -BeExactly "Yes"
        } 


        It 'ssis files created' {
            $hs["ssis"] | Should -BeExactly "Yes"
        } -Pending


        It 'test files created' {
            $hs["test"] | Should -BeExactly "Yes"
        } -Pending

    } 


    Context 'Create sql folder only' {

        $hs = (New-Ticket -Ticket "AS-0001" -Type "sql" -Path "$((Get-PSDrive TestDrive).Root)")

        It 'sql files created' {
            $hs["sql"] | Should -BeExactly "Yes"
        } 


        It 'ssis files NOT created' {
            $hs["ssis"] | Should -BeExactly "No"
        }


        It 'test files NOT created' {
            $hs["test"] | Should -BeExactly "No"
        }

    } 


    Context 'Create ssis folder only' {

        $hs = (New-Ticket -Ticket "AS-0001" -Type "ssis" -Path "$((Get-PSDrive TestDrive).Root)")

        It 'sql files NOT created' {
            $hs["sql"] | Should -BeExactly "No"
        }


        It 'ssis files created' {
            $hs["ssis"] | Should -BeExactly "Yes"
        } -Pending


        It 'test files NOT created' {
            $hs["test"] | Should -BeExactly "No"
        }

    } 



    Context 'Create test folder only' {

        $hs = (New-Ticket -Ticket "AS-0001" -Type "test" -Path "$((Get-PSDrive TestDrive).Root)")

        It 'sql files NOT created' {
            $hs["sql"] | Should -BeExactly "No"
        }


        It 'ssis files NOT created' {
            $hs["ssis"] | Should -BeExactly "No"
        }


        It 'test files created' {
            $hs["test"] | Should -BeExactly "Yes"
        } -Pending

    } 





} -Tag "Create"

