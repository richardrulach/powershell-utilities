
$path = "C:\git\powershell-utilities\pester"

Set-Location $path

Import-Module Pester

Invoke-Pester "$path\Install-Pester.Tests.ps1"

$PSScriptRoot