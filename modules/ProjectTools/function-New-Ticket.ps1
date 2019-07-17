

function New-Ticket {

    param (
        
          [Parameter(Mandatory=$true)]
          [String[]] $Ticket
        , [String]   $Description
        , [String]   $Type = 'all'
        , [String]   $Path = "c:\DEV"
        , [switch]   $Rebuild
        , [switch]   $Force

    )

    BEGIN {}

    PROCESS{


        #region VALIDATION
        if (-not [System.IO.Directory]::Exists($Path)){ throw "Path does not exist" }

        foreach ($ticketNumber in $Ticket){
            if ((gci "$($Path)\$($ticketNumber)*").Count -gt 0 -and $Force -eq $false) { 
                throw "Ticket folder already exists - use force to create anyway"
            }
        } 
        #endregion VALIDATION


        #region MAIN TICKET LOOP
        foreach ($ticketNumber in $Ticket){

            $output = @{}
            $output["sql"] = "No"
            $output["ssis"] = "No"
            $output["test"] = "No"
            $output["errorMessage"] = ""
            $output["Path"] = $Path
    
            if ($type.ToLower() -eq 'sql' -or $type -eq 'all'){
                
            

            }

            Write-Output $output    

        }
    }

    END {}

}

