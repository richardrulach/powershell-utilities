<#
.SYNOPSIS
Creates the necessary folder scaffolding for a new ticket.

.DESCRIPTION
This function creates a new directory in the name of the ticket and description (if provided).
Within the new directory three subdirectories are created:
    \code\scripts
    \code\ssis
    \tests

Each directory corresponds to the Types provided in the arguments.
If all is provided as the Type then all three directories are created

.PARAMETER Ticket
A string that identifies the ticket you are working on.
Ideally this will be the JIRA number - for instance AS-1234

.PARAMETER Description
A string that provides extra information on the ticket.  This is appended to the ticket number as the top level directory name.

.PARAMETER Type
There are four alternatives for Type
    sql   - creates a sql server scripts solution with three sub projects: investigation, solution and tests
    ssis  - creates an ssis project
    tests - folder to contain all test scripts 
    all (default) - generates all three options - sql, ssis, tests.

.PARAMETER Path
The root directory for creating the project folders and files.
If it doesn't exist then the switch Force is required to create it.  Otherwise a path not found error is thrown.

.PARAMETER Rebuild
Switch that indicates the files in the root folder should be merged into the appropriate folder and/or project.

.PARAMETER Force
Switch that creates the Path directory if it doesn't exist
#>

function New-Ticket {

    [CmdLetBinding(PositionalBinding=$false)]
    param (
        
          [Parameter(Mandatory=$true,Position=0)]
          [String[]] $Ticket
        , [String]   $Description
        , [String]   $Type = 'all'
        , [String]   $Path = "c:\DEV"
        , [switch]   $Rebuild
        , [switch]   $Force

    )

    BEGIN {}

    PROCESS{


        # VALIDATION
        if (-not [System.IO.Directory]::Exists($Path)){ throw "Path does not exist" }

        foreach ($ticketNumber in $Ticket){
            if ((gci "$($Path)\$($ticketNumber)*").Count -gt 0 -and $Force -eq $false) { 
                throw "Ticket folder already exists - use force to create anyway"
            }
        } 


        # MAIN TICKET LOOP
        foreach ($ticketNumber in $Ticket){

            $output = @{}
            $output["sql"] = "No"
            $output["ssis"] = "No"
            $output["test"] = "No"
            $output["errorMessage"] = ""
            $output["Path"] = $Path
    
            if ($type.ToLower() -eq 'sql' -or $type -eq 'all'){
                
                $ticketFolder = $ticketNumber
                if ($description.Length -gt 0){ 
                    $ticketFolder += " - $($Description)"
                }

                $newPath = "$($Path)\$($ticketFolder)\CODE\SQL"
                New-Item -Path $newPath -ItemType "directory" -Force | Out-Null        

                New-Item -Path "$($newPath)\Investigation" -ItemType "directory" -Force | Out-Null        
                New-Item -Path "$($newPath)\Investigation\01. Investigation.sql" -ItemType "file" -Force | Out-Null        
                New-Item -Path "$($newPath)\Investigation\Investigation.ssmssqlproj" -ItemType "file" -Force | Out-Null        

                New-Item -Path "$($newPath)\Solution" -ItemType "directory" -Force | Out-Null        
                New-Item -Path "$($newPath)\Solution\Solution.ssmssqlproj" -ItemType "file" -Force | Out-Null        

                New-Item -Path "$($newPath)\Tests" -ItemType "directory" -Force | Out-Null        
                New-Item -Path "$($newPath)\Tests\Tests.ssmssqlproj" -ItemType "file" -Force | Out-Null        


                New-Item -Path "$($newPath)\$($ticketNumber)_Project.ssmssln" -ItemType "file" -Force | Out-Null        

                $guid_solution_file = [guid]::NewGuid().ToString().ToUpper()
                $guid_investigation = [guid]::NewGuid().ToString().ToUpper()
                $guid_solution = [guid]::NewGuid().ToString().ToUpper()
                $guid_tests = [guid]::NewGuid().ToString().ToUpper()

$main_solution = @"
Microsoft Visual Studio Solution File, Format Version 11.00
# SQL Server Management Studio Solution File, Format Version 12.00
Project("{$($guid_solution_file)}") = "Investigation", "Investigation\Investigation.ssmssqlproj", "{$($guid_investigation)}"
EndProject
Project("{$($guid_solution_file)}") = "Solution", "Solution\Solution.ssmssqlproj", "{$($guid_solution)}"
EndProject
Project("{$($guid_solution_file)}") = "Tests", "Tests\Tests.ssmssqlproj", "{$($guid_tests)}"
EndProject
Global
	GlobalSection(SolutionConfigurationPlatforms) = preSolution
		Default|Default = Default|Default
	EndGlobalSection
	GlobalSection(ProjectConfigurationPlatforms) = postSolution
		{$($guid_investigation)}.Default|Default.ActiveCfg = Default
		{$($guid_solution)}.Default|Default.ActiveCfg = Default
		{$($guid_tests)}.Default|Default.ActiveCfg = Default
	EndGlobalSection
	GlobalSection(SolutionProperties) = preSolution
		HideSolutionNode = FALSE
	EndGlobalSection
EndGlobal
"@

                $main_solution | Out-File -Append -FilePath "$($newPath)\$($ticketNumber)_Project.ssmssln"

$investigation_project = @"
<?xml version="1.0"?>
<SqlWorkbenchSqlProject xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" Name="Investigation">
  <Items>
    <LogicalFolder Name="Connections" Type="2" Sorted="true">
      <Items>
      </Items>
    </LogicalFolder>
    <LogicalFolder Name="Queries" Type="0" Sorted="true">
      <Items>
		<FileNode Name="01. Investigation.sql">
          <FullPath>01. Investigation.sql</FullPath>
        </FileNode>
      </Items>
    </LogicalFolder>
    <LogicalFolder Name="Miscellaneous" Type="3" Sorted="true">
      <Items />
    </LogicalFolder>
  </Items>
</SqlWorkbenchSqlProject>
"@

                $investigation_project | Out-File -Append -FilePath "$($newPath)\Investigation\Investigation.ssmssqlproj"

$solution_project = @"
<?xml version="1.0"?>
<SqlWorkbenchSqlProject xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" Name="Solution">
  <Items>
    <LogicalFolder Name="Connections" Type="2" Sorted="true">
      <Items>
      </Items>
    </LogicalFolder>
    <LogicalFolder Name="Queries" Type="0" Sorted="true">
      <Items>
      </Items>
    </LogicalFolder>
    <LogicalFolder Name="Miscellaneous" Type="3" Sorted="true">
      <Items />
    </LogicalFolder>
  </Items>
</SqlWorkbenchSqlProject>
"@
                $solution_project | Out-File -Append -FilePath "$($newPath)\Solution\Solution.ssmssqlproj"

$tests_project = @"
<?xml version="1.0"?>
<SqlWorkbenchSqlProject xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" Name="Tests">
  <Items>
    <LogicalFolder Name="Connections" Type="2" Sorted="true">
      <Items>
      </Items>
    </LogicalFolder>
    <LogicalFolder Name="Queries" Type="0" Sorted="true">
      <Items>
      </Items>
    </LogicalFolder>
    <LogicalFolder Name="Miscellaneous" Type="3" Sorted="true">
      <Items />
    </LogicalFolder>
  </Items>
</SqlWorkbenchSqlProject>
"@

                $tests_project | Out-File -Append -FilePath "$($newPath)\Tests\Tests.ssmssqlproj"

                $output["sql"] = "Yes"


            }

            Write-Output $output    

        }
    }

    END {}

}

