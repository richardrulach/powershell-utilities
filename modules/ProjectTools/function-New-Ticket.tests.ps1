
# RESET PROJECT
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
Get-Module ProjectTools | Remove-Module -Force
Import-Module $here\ProjectTools.psm1 -Force


Describe 'Error checks on New-Ticket' {

    Context 'Return error messages' {

        It 'Throws error when path does not exist' {
            { New-Ticket -Ticket "AS-0001" -Path "c:\devdjsfhjk" } | Should -Throw "Path does not exist"
        } 

        It 'Throws error when ticket folder exists' {
            { New-Ticket -Ticket "AS-2000" -Path "c:\dev" } | Should -Throw "Ticket folder already exists - use force to create anyway"
        } 

        It 'Throws error when any ticket folder exists (multiple tickets)' {
            { New-Ticket -Ticket "AS-1999","AS-2000" -Path "c:\dev" } | Should -Throw "Ticket folder already exists - use force to create anyway"
        } 

        It 'Returns hash table when ticket folder exists but force is used' {
            New-Ticket -Ticket "AS-2000" -Path "c:\dev" -Force | Should -BeOfType  System.Collections.Hashtable
        } 

        It 'Returns hash table for valid input' {
            New-Ticket -Ticket "AS-0001" -Path "c:\dev" | Should -BeOfType  System.Collections.Hashtable
        } 

        It 'Returns two hash tables for valid input (multiple tickets)' {
            New-Ticket -Ticket "AS-1999","AS-1998" -Path "c:\dev" | Should -BeOfType System.Collections.Hashtable
            New-Ticket -Ticket "AS-1999","AS-1998" -Path "c:\dev" | Should -HaveCount 2
        } 



    } 
} -Tag "error"

Describe 'Tests on New-Ticket' {

    Context 'Create all folders' {

        $hs = (New-Ticket -Ticket "AS-0001")


        It 'Should confirm sql files were created' {
            $hs["sql"] | Should -BeExactly "Yes"
        } 


        It 'Should confirm ssis files were created' {
            $hs["ssis"] | Should -BeExactly "Yes"
        } -Pending


        It 'Should confirm test files were created' {
            $hs["test"] | Should -BeExactly "Yes"
        } -Pending

    } 


    Context 'Create sql folder only' {

        $hs = (New-Ticket -Ticket "AS-0001" -Type "sql")

        It 'Should confirm sql files were created' {
            $hs["sql"] | Should -BeExactly "Yes"
        } -Pending


        It 'Should confirm ssis files were NOT created' {
            $hs["ssis"] | Should -BeExactly "No"
        }


        It 'Should confirm test files were NOT created' {
            $hs["test"] | Should -BeExactly "No"
        }

    } 


    Context 'Create ssis folder only' {

        $hs = (New-Ticket -Ticket "AS-0001" -Type "sql")

        It 'Should confirm sql files were NOT created' {
            $hs["sql"] | Should -BeExactly "No"
        }


        It 'Should confirm ssis files were created' {
            $hs["ssis"] | Should -BeExactly "Yes"
        } -Pending


        It 'Should confirm test files were NOT created' {
            $hs["test"] | Should -BeExactly "No"
        }

    } 



    Context 'Create test folder only' {

        $hs = (New-Ticket -Ticket "AS-0001" -Type "sql")

        It 'Should confirm sql files were NOT created' {
            $hs["sql"] | Should -BeExactly "No"
        }


        It 'Should confirm ssis files were NOT created' {
            $hs["ssis"] | Should -BeExactly "No"
        }


        It 'Should confirm test files were created' {
            $hs["test"] | Should -BeExactly "Yes"
        } -Pending

    } 





} -Tag "Create"

