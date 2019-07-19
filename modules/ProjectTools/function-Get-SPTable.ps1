<#
.SYNOPSIS
Generates the SQL code to create a temp table or variable that will hold the contents of a stored procedure

.DESCRIPTION

.PARAMETER Server

.PARAMETER Schema

.PARAMETER Proc

.PARAMETER Params

.PARAMETER Credential

.PARAMETER TableVar

#>

function Get-SPTable {

    [CmdletBinding()]
    param(
          [Parameter(Mandatory=$true,Position=0)]
          [String]      $Server
        , [String]      $Schema
        , [String]      $Proc
        , [String]      $Params
        , [Credential]  $Credential
        , [Switch]      $TableVar

    )


    BEGIN {}

    PROCESS {}

    END {}


}

