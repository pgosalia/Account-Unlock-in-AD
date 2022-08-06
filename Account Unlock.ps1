<#
.Account Unlock
This script will prompt for username and unlock the relevant AD account.
PARSH GOSALIA -- August 6th, 2022
#>

$username = Read-Host -Prompt "Enter the username"
Unlock-ADAccount -Identity $username
$date = Get-Date
Write-Host "User '$username' was unlocked on '$date'"
Start-Sleep -s 5