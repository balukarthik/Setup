# alias.ps1 - shell aliases and small helper functions.

# Alias for sync-one.ps1 (assumes sync-one.ps1 is in $HOME\bin)
Set-Alias s "$HOME\bin\sync-one.ps1"

# Newest installed vim, if any. Scoped to the two Program Files roots rather
# than a "C:\Program Files*" wildcard, and tolerant of vim not being installed
# yet on a fresh machine.
$VimExe = @(
    "$env:ProgramFiles\Vim\vim*\vim.exe"
    "${env:ProgramFiles(x86)}\Vim\vim*\vim.exe"
) | ForEach-Object { Get-Item $_ -ErrorAction SilentlyContinue } |
    Sort-Object { $_.Directory.Name } -Descending |
    Select-Object -First 1

if ($VimExe) {
    Set-Alias vim $VimExe.FullName
    Set-Alias vi  $VimExe.FullName
}

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
