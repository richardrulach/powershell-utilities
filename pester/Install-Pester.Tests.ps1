Clear-Host

$mod_name = "C:\git\powershell-utilities\pester\Install-Pester.ps1"


Describe 'File exists' {

    It "Install Pester file exists\" {
       $mod_name  | Should Exist 
    }



    It "Has text in the file" {
        $mod_name | Should -FileContentMatch 'PackageManagement'
        
    }


    It "is valid powershell code" {
        $psFile = Get-Content -Path $mod_name `
                                -ErrorAction Stop

        $errors = $null

        $null = [System.Management.Automation.PSParser]::Tokenize($psFile, [ref] $errors)

        $errors.Count | Should Be 0
    }

}

#Get-Content $mod_name 

