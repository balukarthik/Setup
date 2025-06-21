# Set variables
#

# Get the path to the current script's directory
$scriptDirectory = $PSScriptRoot

# Construct the full path to ScriptB.ps1
$scriptToRun = Join-Path -Path $scriptDirectory -ChildPath "env.ps1"

# Execute ScriptB.ps1 using the call operator
& $scriptToRun

$BinDir = "$HOME\bin"

# Create bin directory if it doesn't exist
if (!(Test-Path $BinDir)) {
    New-Item -ItemType Directory -Path $BinDir | Out-Null
}

$SETUP = $Env:SETUP

# Copy setup.ps1 to bin directory
Copy-Item "$SETUP\setup.ps1" "$BinDir\setup.ps1" -Force

# Copy env.ps1 and alias.ps1 to bin directory and dot-source them
Copy-Item "$SETUP\env.ps1" "$BinDir\env.ps1" -Force
. "$BinDir\env.ps1"

Copy-Item "$SETUP\alias.ps1" "$BinDir\alias.ps1" -Force
. "$BinDir\alias.ps1"

# Copy binary files from Setup\bin to $HOME\bin
if (Test-Path "$SETUP\bin") {
    Copy-Item "$SETUP\bin\*" $BinDir -Recurse -Force
}

# Copy vim config files (if present)
if (Test-Path "$SETUP\_vimrc") {
    Copy-Item "$SETUP\_vimrc" "$HOME\_vimrc" -Force
}
if (Test-Path "$SETUP\vimfiles") {
    Copy-Item "$SETUP\vimfiles" "$HOME\" -Recurse -Force
}

# Add env.ps1 and alias.ps1 sourcing to PowerShell profile
$profilePath = $PROFILE

# Ensure the PowerShell profile file exists
if (!(Test-Path $profilePath)) {
    New-Item -ItemType File -Path $profilePath -Force | Out-Null
}

if (!(Get-Content $profilePath | Select-String -SimpleMatch ". `$HOME\bin\env.ps1")) {
    Add-Content $profilePath ". `$HOME\bin\env.ps1"
}
if (!(Get-Content $profilePath | Select-String -SimpleMatch ". `$HOME\bin\alias.ps1")) {
    Add-Content $profilePath ". `$HOME\bin\alias.ps1"
}

# Remember git credentials
git config --global credential.helper store

# Clone all repos
$githubUrl = $Env:GITHUB_URL

git clone $githubUrl/$WORK_USER/Scripts "$GITHUB_HOME\Scripts"
git clone $githubUrl/$WORK_USER/Notes   "$GITHUB_HOME\Notes"
git clone $githubUrl/$WORK_USER/Lists   "$GITHUB_HOME\Lists"

# Copy scripts to $HOME\bin and make them executable (Windows: .ps1 or .bat)
if (Test-Path "$GITHUB_HOME\Scripts") {
    Copy-Item "$GITHUB_HOME\Scripts\*.ps1" $BinDir -Force -ErrorAction SilentlyContinue
    Copy-Item "$GITHUB_HOME\Scripts\*.bat" $BinDir -Force -ErrorAction SilentlyContinue
}

# Add $HOME\bin to PATH if not already present
$envPath = [Environment]::GetEnvironmentVariable("PATH", "User")
if (-not ($envPath -like "*$BinDir*")) {
    [Environment]::SetEnvironmentVariable("PATH", "$envPath;$BinDir", "User")
}

# Run cron.ps1 and pass sync-all.ps1 as an argument if they exist
if ((Test-Path "$GITHUB_HOME\Scripts\cron.ps1") -and (Test-Path "$GITHUB_HOME\Scripts\sync-all.ps1")) {
    & "$GITHUB_HOME\Scripts\cron.ps1" "$GITHUB_HOME\Scripts\sync-all.ps1"
}


Write-Host "Setup Complete"


