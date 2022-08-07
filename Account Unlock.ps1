<#
.Account Unlock
This script will prompt for username and unlock the relevant AD account.
PARSH GOSALIA -- August 7th, 2022
Version 1.2
#>

#Adds .NET framework for textBox
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$choice = Read-Host -Prompt "Would you like to input username or Clock number?"
if(($choice -like "username") -or ($choice -like "Username") -or ($choice -like "u")) {
	$form = New-Object System.Windows.Forms.Form
	$form.Text = 'User Unlock Form'
	$form.Size = New-Object System.Drawing.Size(300,200)
	$form.StartPosition = 'CenterScreen'

	$okButton = New-Object System.Windows.Forms.Button
	$okButton.Location = New-Object System.Drawing.Point(75,120)
	$okButton.Size = New-Object System.Drawing.Size(75,23)
	$okButton.Text = 'Unlock'
	$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
	$form.AcceptButton = $okButton
	$form.Controls.Add($okButton)

	$cancelButton = New-Object System.Windows.Forms.Button
	$cancelButton.Location = New-Object System.Drawing.Point(150,120)
	$cancelButton.Size = New-Object System.Drawing.Size(75,23)
	$cancelButton.Text = 'Cancel'
	$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
	$form.CancelButton = $cancelButton
	$form.Controls.Add($cancelButton)

	$label = New-Object System.Windows.Forms.Label
	$label.Location = New-Object System.Drawing.Point(10,20)
	$label.Size = New-Object System.Drawing.Size(280,20)
	$label.Text = 'Please enter the Username in the space below:'
	$form.Controls.Add($label)

	$textBox = New-Object System.Windows.Forms.TextBox
	$textBox.Location = New-Object System.Drawing.Point(10,40)
	$textBox.Size = New-Object System.Drawing.Size(260,20)
	$form.Controls.Add($textBox)

	$form.Topmost = $true

	$form.Add_Shown({$textBox.Select()})
	$result = $form.ShowDialog()
	if ($result -eq [System.Windows.Forms.DialogResult]::OK)
	{
		$username = $textBox.Text
		Write-Host $username
		Unlock-ADAccount -Identity $username
		$date = Get-Date
		Write-Host "User '$username' was unlocked on '$date'"
		Start-Sleep -s 10
	}
}else {
	$form = New-Object System.Windows.Forms.Form
	$form.Text = 'User Unlock Form'
	$form.Size = New-Object System.Drawing.Size(300,200)
	$form.StartPosition = 'CenterScreen'

	$okButton = New-Object System.Windows.Forms.Button
	$okButton.Location = New-Object System.Drawing.Point(75,120)
	$okButton.Size = New-Object System.Drawing.Size(75,23)
	$okButton.Text = 'Unlock'
	$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
	$form.AcceptButton = $okButton
	$form.Controls.Add($okButton)

	$cancelButton = New-Object System.Windows.Forms.Button
	$cancelButton.Location = New-Object System.Drawing.Point(150,120)
	$cancelButton.Size = New-Object System.Drawing.Size(75,23)
	$cancelButton.Text = 'Cancel'
	$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
	$form.CancelButton = $cancelButton
	$form.Controls.Add($cancelButton)

	$label = New-Object System.Windows.Forms.Label
	$label.Location = New-Object System.Drawing.Point(10,20)
	$label.Size = New-Object System.Drawing.Size(280,20)
	$label.Text = 'Please enter the Clock Number / EmployeeID in the space below:'
	$form.Controls.Add($label)

	$textBox = New-Object System.Windows.Forms.TextBox
	$textBox.Location = New-Object System.Drawing.Point(10,40)
	$textBox.Size = New-Object System.Drawing.Size(260,20)
	$form.Controls.Add($textBox)

	$form.Topmost = $true

	$form.Add_Shown({$textBox.Select()})
	$result = $form.ShowDialog()
	if ($result -eq [System.Windows.Forms.DialogResult]::OK)
	{
		$clock_number = $textBox.Text
		Write-Host $clock_number
		#Get-ADUser -filter "EmployeeID -eq '$clock_number'" -properties SAMAccountname
		$username = Get-ADUser -filter "EmployeeID -eq '$clock_number'" -properties SAMAccountname
		Unlock-ADAccount -Identity $username
		$date = Get-Date
		Write-Host "User '$username' '$clock_number' was unlocked on '$date'"
		Start-Sleep -s 10
	}
}
