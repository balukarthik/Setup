# Set variables
# $HOME = [Environment]::GetFolderPath("UserProfile")
$SETUP_DIR = "$HOME\github\balukarthik\Setup"
$GITHUB_HOME = "$HOME\github\"
$BinDir = "$HOME\bin"

# Create bin directory if it doesn't exist
if (!(Test-Path $BinDir)) {
    New-Item -ItemType Directory -Path $BinDir | Out-Null
}

# Copy setup.ps1 to bin directory
Copy-Item "$SETUP_DIR\setup.ps1" "$BinDir\setup.ps1" -Force

# Copy env.ps1 and alias.ps1 to bin directory and dot-source them
Copy-Item "$SETUP_DIR\env.ps1" "$BinDir\env.ps1" -Force
. "$BinDir\env.ps1"

Copy-Item "$SETUP_DIR\alias.ps1" "$BinDir\alias.ps1" -Force
. "$BinDir\alias.ps1"

# Copy binary files from Setup\bin to $HOME\bin
if (Test-Path "$SETUP_DIR\bin") {
    Copy-Item "$SETUP_DIR\bin\*" $BinDir -Recurse -Force
}

# Copy vim config files (if present)
if (Test-Path "$SETUP_DIR\_vimrc") {
    Copy-Item "$SETUP_DIR\_vimrc" "$HOME\_vimrc" -Force
}
if (Test-Path "$SETUP_DIR\vimfiles") {
    Copy-Item "$SETUP_DIR\vimfiles" "$HOME\vimfiles" -Recurse -Force
}

# Add env.ps1 and alias.ps1 sourcing to PowerShell profile
$profilePath = $PROFILE
if (!(Get-Content $profilePath | Select-String -SimpleMatch ". `$HOME\bin\env.ps1")) {
    Add-Content $profilePath ". `$HOME\bin\env.ps1"
}
if (!(Get-Content $profilePath | Select-String -SimpleMatch ". `$HOME\bin\alias.ps1")) {
    Add-Content $profilePath ". `$HOME\bin\alias.ps1"
}

# Remember git credentials
git config --global credential.helper store

# Clone all repos
git clone https://github.com/balukarthik/Scripts "$GITHUB_HOME\Scripts"
git clone https://github.com/balukarthik/Notes   "$GITHUB_HOME\Notes"
git clone https://github.com/balukarthik/Lists   "$GITHUB_HOME\Lists"

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

# Run cron.ps1 and sync-all.ps1 if they exist
if (Test-Path "$GITHUB_HOME\Scripts\cron.ps1") {
    & "$GITHUB_HOME\Scripts\cron.ps1"
}
if (Test-Path "$GITHUB_HOME\Scripts\sync-all.ps1") {
    & "$GITHUB_HOME\Scripts\sync-all.ps1"
}

Write-Host "Setup Complete"
