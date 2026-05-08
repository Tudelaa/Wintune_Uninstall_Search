<#

.SYNOPSIS

This simple script is designed to search for an application in the registry and return the uninstall string for both 64 bits and 32 bits registry keys. 
The user will be prompted to enter the name of the application they want to search for, and the results will be displayed in a grid view.

. DESCRIPTION

This simple script is designed to search for an application in the registry and return the uninstall string for both 64 bits and 32 bits registry keys. 
The user will be prompted to enter the name of the application they want to search for, and the results will be displayed in a grid view.


Written: Antonio Tudela



.VERSION HISTORY

Version 1.0 - Initial script development

#>

function inputfolder {

                       <#

                        .SYNOPSIS
                        This function is designed to prompt the user to enter the name of the application they want to search for in the registry.
                        .DESCRIPTION
                        This function is designed to prompt the user to enter the name of the application they want to search for in the registry.
                        .PARAMETER NO 
                        #>



Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = "Wintune Uninstall Search"
$form.ClientSize = New-Object System.Drawing.Size(420,160)
$form.StartPosition = 'CenterScreen'
$form.Topmost = $true
$form.FormBorderStyle = 'FixedDialog' # evita resize
$form.MaximizeBox = $false
$form.MinimizeBox = $false

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,10)
$label.AutoSize = $true
$label.MaximumSize = New-Object System.Drawing.Size(400,0) # wrap “bonito” al ancho
$label.Text = "Please enter the name of the application you want to search:"
$form.Controls.Add($label)

$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10,45)
$textBox.Size = New-Object System.Drawing.Size(400,20)
$textBox.Anchor = 'Top,Left,Right'
$form.Controls.Add($textBox)

$okButton = New-Object System.Windows.Forms.Button
$okButton.Text = "OK"
$okButton.Size = New-Object System.Drawing.Size(90,26)
$okButton.Location = New-Object System.Drawing.Point(220,90)
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$okButton.Anchor = 'Bottom,Right'

$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Text = "Cancel"
$cancelButton.Size = New-Object System.Drawing.Size(90,26)
$cancelButton.Location = New-Object System.Drawing.Point(320,90)
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$cancelButton.Anchor = 'Bottom,Right'

$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

$form.Add_Shown({ $textBox.Select() })

$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
                                                            {
                                                                $App = $textBox.Text
                                                                return $App
                                                            } else {
                                                                Write-Host "Operation cancelled by user."
                                                                exit 1
                                                            }
                                                            
}


$Search_App = inputfolder

# registry key 64 bits

$Registry_Value = Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" | Get-ItemProperty | where-Object DisplayName -Match $Search_App

# registry key for apps in 32 bits on 64 bits Windows

$Registry_Value_32 = Get-childItem "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall" | Get-ItemProperty | where-Object DisplayName -Match $Search_App 

$App_Name = ($Registry_Value).DisplayName
$Uninstall_String = ($Registry_Value).UninstallString | select-string -Pattern "{"
$Uninstall_Strin32 = ($Registry_Value_32).UninstallString | select-string -Pattern "{"

if ($null -ne $Uninstall_String) { 
                     

                         $Result = "Application $App_Name detected. Uninstall String $Uninstall_String 64 bits registry. Rememeber use $Uninstall_String /qn to uninstall the application"
                         $Result | Out-GridView -Title "Uninstall Search Result"
                         

                         }


if ($null -ne $Uninstall_Strin32) {

                           $Result = "Application $App_Name detected. Uninstall String $Uninstall_Strin32 32 bits registry. Rememeber use $Uninstall_Strin32 /qn to uninstall the application"
                           $Result | Out-GridView -Title "Uninstall Search Result"
                           
                           }


else { 

      Write-Host "Application $Search_App is not detected"
      exit 1
      }