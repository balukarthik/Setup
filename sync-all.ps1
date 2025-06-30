$githubHome = $env:GITHUB_HOME

Get-ChildItem -Path $githubHome -Directory | ForEach-Object {
    Set-Location $_.FullName
    & "$PSScriptRoot\sync-one.ps1"
}
Set-Location $PSScriptRoot
