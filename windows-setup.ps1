# Jimmy's simple Windows setup.
#Requires -RunAsAdministrator

$WinVersion = [System.Environment]::OSVersion.Version

# Force add winget if it's not already available, but only if on default Windows PowerShell
if ( $PSVersionTable.PSVersion.Major -eq 5 )
{
    Write-Output "Making sure winget is available"
    Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe
}

$wingetpkgs = @(
    '9N0DX20HK701' # Terminal (Store edition)
    'Git.Git'
    '7zip.7zip'
    'Mozilla.Firefox'
    'Microsoft.PowerShell'
    'Microsoft.VisualStudioCode'
)

foreach ( $app in $wingetpkgs )
{
    Write-Output "Installing package: $app"
    winget install --id=$app -e -h --silent --accept-package-agreements
}

# .NET 3.5
DISM /Online /Enable-Feature /FeatureName:NetFx3 /All 

# PowerShell profile
# TODO: Either install OhMyPOSH or have a clean version without.
# copy ./powershell_profile.ps1 $PROFILE

# Force layout of taskbar
Write-Output "Now for some agressive customisation measures"
Import-StartLayout -LayoutPath ".\windows\StartLayout.xml" -MountPath $env:SystemDrive\

# Taskbar defaults (Search off, news off)
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Search' -Name 'SearchboxTaskbarMode' -Value 0 -Force
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds' -Name 'ShellFeedsTaskbarViewMode' -Value 2 -Force

# Widgets off, chat off, left aligned for Win 11.
if ($WinVersion.build -ge 22000) {
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'TaskbarDa' -Value 0 -Force
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'TaskbarMn' -Value 0 -Force
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'TaskbarAl' -Value 0 -Force
}

# Show file extensions
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'HideFileExt' -Value 0 -Force
