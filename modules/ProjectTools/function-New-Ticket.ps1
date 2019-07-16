

function New-Ticket {

    param (
        
          [Parameter(Mandatory=$true)]
          [String[]] $Ticket
        , [String]   $Description
        , [String]   $Type
        , [switch]   $Rebuild
        , [String]   $Path = "c:\DEV"

    )

    BEGIN {}

    PROCESS{
        $output = @{}
        $output["sql"] = "No"
        $output["ssis"] = "No"
        $output["test"] = "No"
    
        try {

        } catch {

        } finally {
            Write-Output $output    
        }

    }

    END {}

}

