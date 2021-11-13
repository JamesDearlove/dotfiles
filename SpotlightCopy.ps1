# Script that copies spotlight images to OneDrive

$backuplocation = "$env:OneDrive\Backgrounds\Windows Spotlight"

pushd $env:localappdata\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets

(Get-ChildItem "*") |
ForEach-Object {
    $img = [System.Drawing.Image]::FromFile($_.FullName);
    $dimensions = "$($img.Width) x $($img.Height)"
    if ($img.width -gt 1280) {
        $location = "$backuplocation\Desktop\" + $_.Name + ".jpg"
        Write-Host("Type: Desktop " + $_.Name)
        cp $_ $location
    }

    if ($img.height -gt 1280) {
        $location = "$backuplocation\Phone\" + $_.Name + ".jpg"
        Write-Host("Type: Phone " + $_.Name)
        cp $_ $location
    } 
}

popd
