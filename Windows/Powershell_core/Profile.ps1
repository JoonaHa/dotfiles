
#region conda initialize
# !! Contents within this block are managed by 'conda init' !!
(& "C:\tools\miniconda3\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | Invoke-Expression
#endregion

if ($host.Name -eq 'ConsoleHost')
{
    Import-Module PSReadLine
}

Import-Module PSFzf
# replace 'Ctrl+t' and 'Ctrl+r' with your preferred bindings:
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'