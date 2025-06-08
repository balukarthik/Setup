# Alias for sync-one.ps1 (assumes sync-one.sh is in $HOME\bin and executable)
Set-Alias s "$HOME\bin\sync-one.ps1"
Set-Alias vim "C:\Program Files (x86)\Vim\vim91\vim.exe"
Set-Alias vi "C:\Program Files (x86)\Vim\vim91\vim.exe"

# Calculator function (uses PowerShell's Invoke-Expression for math)
function c {
    param([string]$expr)
    try {
        # Evaluate the expression and output the result
        Invoke-Expression $expr
    } catch {
        Write-Host "Invalid expression: $expr"
    }
}
