
[System.Reflection.Assembly]::LoadWithPartialName('presentationframework') |Out-Null
[System.Reflection.Assembly]::LoadFrom("assembly\System.Windows.Interactivity.dll") | Out-Null
[System.Reflection.Assembly]::LoadFrom("assembly\MaterialDesignThemes.Wpf.dll") | Out-Null
[System.Reflection.Assembly]::LoadFrom("assembly\MaterialDesignColors.dll") | Out-Null
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null

function LoadXml ($global:filename)
{
    $XamlLoader=(New-Object System.Xml.XmlDocument)
    $XamlLoader.Load($filename)
    return $XamlLoader
}

$XamlMainWindow=LoadXml("MonInterface.xaml")
$Reader=(New-Object System.Xml.XmlNodeReader $XamlMainWindow)
$Form=[Windows.Markup.XamlReader]::Load($Reader)
$Show = $Form.findname("Show")
$Dialog = $Form.findname("Dialog1")
$Check_ME =  $Form.findname("Check_Me")
$Close = $Form.findname("Close_ME")

$Show.add_Click({

$Dialog.IsOpen = $True


})

$Close.add_Click({

    if ($Check_ME.IsChecked -eq $true)
    {
        [System.Windows.Forms.MessageBox]::Show("You close the Dialog with the CheckBox Checked")
        
        $Check_ME.IsChecked = $False
    }
    else
    {
        [System.Windows.Forms.MessageBox]::Show("You close the Dialog without the CheckBox Checked")

    }


    $Dialog.IsOpen = $False
})
    

$Form.ShowDialog() | Out-Null

