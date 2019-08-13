
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
$Name =  $Form.findname("Name")
$Password= $Form.findname("PasswordBox")
$Close = $Form.findname("Close_ME")

$Show.add_Click({

$Dialog.IsOpen = $True


})

$Close.add_Click({

    $MSG1 = $Name.Text  
    $MSG2 = $Password.password.tostring()

        [System.Windows.Forms.MessageBox]::Show("You name is $MSG1 with the Password $MSG2")
        


    $Dialog.IsOpen = $False
})
    

$Form.ShowDialog() | Out-Null

