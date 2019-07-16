
Clear-Host

$SourceFolder = "$(Split-Path $MyInvocation.MyCommand.Path -Parent)\..\modules\ProjectTools\"

Invoke-Pester $SourceFolder -Verbose

