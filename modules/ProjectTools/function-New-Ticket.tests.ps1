
# RESET PROJECT
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
Get-Module ProjectTools | Remove-Module -Force
Import-Module $here\ProjectTools.psm1 -Force


Describe 'Tests on New-Ticket' {

    Context 'Create all folders' {

        $hs = (New-Ticket -Ticket "AS-0001")

        It 'Should confirm sql files were created' {
            $hs["sql"] | Should -BeExactly "Yes"
        }


        It 'Should confirm ssis files were created' {
            $hs["ssis"] | Should -BeExactly "Yes"
        }


        It 'Should confirm test files were created' {
            $hs["test"] | Should -BeExactly "Yes"
        }

    }


    Context 'Create sql folder only' {

        $hs = (New-Ticket -Ticket "AS-0001" -Type "sql")

        It 'Should confirm sql files were created' {
            $hs["sql"] | Should -BeExactly "Yes"
        }


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
        }


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
        }

    }





}

