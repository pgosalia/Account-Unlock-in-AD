<#
.Account Unlock
This script will prompt for username and unlock the relevant AD account.
PARSH GOSALIA -- August 6th, 2022
Version 1.1
#>

$choice = Read-Host -Prompt "Would you like to input username or Clock number?"
if(($choice -like "username") -or ($choice -like "Username") -or ($choice -like "u")) {
	$username = Read-Host -Prompt "Enter the username"
	Unlock-ADAccount -Identity $username
	$date = Get-Date
	Write-Host "User '$username' was unlocked on '$date'"
	Start-Sleep -s 7
}else {
	$clock_number = Read-Host -Prompt "Please enter the Clock number"
	Get-ADUser -filter "EmployeeID -eq '$clock_number'" -properties SAMAccountname
	Get-ADUser -filter "EmployeeID -eq '$clock_number'" -properties *
	$username = Get-ADUser -filter "EmployeeID -eq '$clock_number'" -properties SAMAccountname
	Unlock-ADAccount -Identity $username
}
