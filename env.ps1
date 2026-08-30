# env.ps1 - define and persist the shared environment variables.
#
# Dot-source this (". $HOME\bin\env.ps1"); it sets both PowerShell variables
# in the caller's scope and the matching environment variables.
#
# Persisting to the 'User' scope writes the registry AND broadcasts
# WM_SETTINGCHANGE to every top-level window, which costs ~70ms per variable.
# So only write when the value is actually missing or wrong: a new machine
# pays it once, every later shell pays nothing.

# Single source of truth. Ordered, because later entries derive from earlier.
$EnvVars = [ordered]@{}
$EnvVars.WORK_USER     = 'kbalu'
$EnvVars.HOME_USER     = 'balukarthik'
$EnvVars.WORK_GIT      = "$HOME\work-git"
$EnvVars.WORK_GIT_URL  = 'https://github.qualcomm.com/'
$EnvVars.GITHUB        = "$HOME\github"
$EnvVars.HOME_GIT_URL  = 'https://github.com/'
$EnvVars.HOME_GIT_HOME = "$($EnvVars.GITHUB)\$($EnvVars.HOME_USER)"
$EnvVars.WORK_GIT_HOME = "$($EnvVars.WORK_GIT)\$($EnvVars.WORK_USER)"
$EnvVars.GITHUB_HOME   = $EnvVars.HOME_GIT_HOME
$EnvVars.GITHUB_URL    = $EnvVars.HOME_GIT_URL
$EnvVars.NOTES         = "$($EnvVars.GITHUB_HOME)\Notes"
$EnvVars.SETUP         = "$($EnvVars.GITHUB_HOME)\Setup"

foreach ($Name in $EnvVars.Keys) {
    $Desired = $EnvVars[$Name]

    # Always define the PowerShell variable; this is free.
    Set-Variable -Name $Name -Value $Desired

    # Only touch the environment when it does not already agree.
    if ([Environment]::GetEnvironmentVariable($Name) -ne $Desired) {
        [Environment]::SetEnvironmentVariable($Name, $Desired)
        [Environment]::SetEnvironmentVariable($Name, $Desired, 'User')
        Write-Verbose "Set $Name = $Desired"
    }
}
