
[System.Reflection.Assembly]::LoadWithPartialName('presentationframework') |Out-Null
[System.Reflection.Assembly]::LoadFrom("assembly\System.Windows.Interactivity.dll")|Out-Null
[System.Reflection.Assembly]::LoadFrom("assembly\MaterialDesignThemes.Wpf.dll")|Out-Null
[System.Reflection.Assembly]::LoadFrom("assembly\MaterialDesignColors.dll")|Out-Null


function LoadXml ($global:filename)
{
    $XamlLoader=(New-Object System.Xml.XmlDocument)
    $XamlLoader.Load($filename)
    return $XamlLoader
}

$XamlMainWindow=LoadXml("MonInterface.xaml")
$Reader=(New-Object System.Xml.XmlNodeReader $XamlMainWindow)
$Form=[Windows.Markup.XamlReader]::Load($Reader)

$XamlMainWindow.SelectNodes("//*[@Name]") | %{
    try {Set-Variable -Name "$("WPF_"+$_.Name)" -Value $Form.FindName($_.Name) -ErrorAction Stop}
    catch{throw}
    }
 
Function Get-FormVariables{
if ($global:ReadmeDisplay -ne $true){Write-host "If you need to reference this display again, run Get-FormVariables" -ForegroundColor Yellow;$global:ReadmeDisplay=$true}
write-host "Found the following interactable elements from our form" -ForegroundColor Cyan
get-variable *WPF* | select -Property Name,Value |ft
}
  #Get-FormVariables


$WPF_Show.add_Click({

$WPF_F1.IsOpen = $True

})

$WPF_Close2.add_Click({

    $WPF_F1.IsOpen = $False
    $WPF_NewOS.Text = $null
  
})



$WPF_Close1.add_Click({

    
    $Text = $WPF_NewOS.Text
    if (!($Text.length -eq "0"))
    {    
        $WPF_OSlist.Items.Add($Text)
        $WPF_NewOS.Text = $null
    }

})
       

$Form.ShowDialog() | Out-Null

