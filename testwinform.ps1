Add-Type -assembly System.Windows.Forms
$main_form = New-Object System.Windows.Forms.Form
$main_form.Text ='GUI for my PowerShell script'
$main_form.Width = 600
$main_form.Height = 400
$main_form.ShowDialog()