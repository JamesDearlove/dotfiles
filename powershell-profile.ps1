# Oh My POSH
Set-PoshPrompt -Theme agnoster

# Shows navigable menu of all options when hitting Tab
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Previous function up completion
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

# Exits shell on CTRL+D
Set-PSReadlineKeyHandler -Key ctrl+d -Function DeleteCharOrExit 

# Quickly change Windows Power plan
function Set-PowerPlan {
    param(
        [Parameter(Mandatory)]
        [ValidateSet('Saver', 'Balanced', 'Performance')]
        [string]$Plan
    )

    Switch ($Plan)
    {
        'Saver' { powercfg.exe /setactive a1841308-3541-4fab-bc81-f71556f20b4a }
        'Balanced' { powercfg.exe /setactive 381b4222-f694-41f0-9685-ff5bb260df2e }
        'Performance' { powercfg.exe /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c }
    }
}

# MacOS open command alias
New-Alias open ii
