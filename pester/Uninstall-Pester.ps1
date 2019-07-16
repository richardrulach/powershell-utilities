#Requires -RunAsAdministrator
$modulePath = "C:\Program Files\WindowsPowerShell\Modules\Pester"

if (-not (Test-Path $modulePath)) {
    "There is no Pester folder in $modulePath, doing nothing."
    break
}

takeown /F $modulePath /A /R
icacls $modulePath /reset
icacls $modulePath /grant Administrators:'F' /inheritance:d /T
Remove-Item -Path $modulePath -Recurse -Force -Confirm:$false