# Jimmy's simple Windows setup.
#Requires -RunAsAdministrator

$WinVersion = [System.Environment]::OSVersion.Version

# Force add winget if it's not already available, but only if on default Windows PowerShell
# Winget should now be available on 24H2+
# if ( $PSVersionTable.PSVersion.Major -eq 5 )
# {
#     Write-Output "Making sure winget is available"
#     Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe
# }

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
# Probably not needed by default
# DISM /Online /Enable-Feature /FeatureName:NetFx3 /All 

# PowerShell profile
# TODO: Either install OhMyPOSH or have a clean version without.
# copy ./powershell_profile.ps1 $PROFILE

# Force layout of taskbar
#Write-Output "Now for some agressive customisation measures"
#Import-StartLayout -LayoutPath ".\windows\StartLayout.xml" -MountPath $env:SystemDrive\

# Dev Mode - Requires Admin
# Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock\AllowDevelopmentWithoutDevLicense' -Name 'AllowDevelopmentWithoutDevLicense' -Value 1 -Force

# Dark Mode
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize' -Name 'AppsUseLightTheme' -Value 0 -Force
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize' -Name 'SystemUsesLightTheme' -Value 0 -Force

# Taskbar defaults (Search off, news off)
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Search' -Name 'SearchboxTaskbarMode' -Value 0 -Force
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds' -Name 'ShellFeedsTaskbarViewMode' -Value 2 -Force

# Widgets off, left aligned for Win 11.
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'TaskbarDa' -Value 0 -Force
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'TaskbarAl' -Value 0 -Force

# Show file extensions and hidden files
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'HideFileExt' -Value 0 -Force
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Hidden' -Value 1 -Force
