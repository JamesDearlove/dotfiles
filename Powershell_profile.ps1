# Oh My POSH
Set-PoshPrompt -Theme agnoster

# Shows navigable menu of all options when hitting Tab
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Previous function up completion
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

# Exits shell on CTRL+D
Set-PSReadlineKeyHandler -Key ctrl+d -Function DeleteCharOrExit 

# MacOS open command alias
New-Alias open ii
