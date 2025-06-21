[Environment]::SetEnvironmentVariable('WORK_USER', 'kbalu')
[Environment]::SetEnvironmentVariable('WORK_USER', 'kbalu', 'User')
$WORK_USER = [Environment]::GetEnvironmentVariable('WORK_USER')

[Environment]::SetEnvironmentVariable('HOME_USER', 'balukarthik')
[Environment]::SetEnvironmentVariable('HOME_USER', 'balukarthik', 'User')
$HOME_USER = [Environment]::GetEnvironmentVariable('HOME_USER')

[Environment]::SetEnvironmentVariable('WORK_GIT', "$HOME\work-git")
[Environment]::SetEnvironmentVariable('WORK_GIT', "$HOME\work-git", 'User')
$WORK_GIT = [Environment]::GetEnvironmentVariable('WORK_GIT')

[Environment]::SetEnvironmentVariable('WORK_GIT_URL', "https://github.qualcomm.com/")
[Environment]::SetEnvironmentVariable('WORK_GIT_URL', "https://github.qualcomm.com/", 'User')
$WORK_GIT_URL = [Environment]::GetEnvironmentVariable('WORK_GIT_URL')

[Environment]::SetEnvironmentVariable('GITHUB', "$HOME\github")
[Environment]::SetEnvironmentVariable('GITHUB', "$HOME\github", 'User')
$GITHUB = [Environment]::GetEnvironmentVariable('GITHUB')

[Environment]::SetEnvironmentVariable('HOME_GIT_URL', "https://github.com/")
[Environment]::SetEnvironmentVariable('HOME_GIT_URL', "https://github.com/", 'User')
$HOME_GIT_URL = [Environment]::GetEnvironmentVariable('HOME_GIT_URL')

[Environment]::SetEnvironmentVariable('HOME_GIT_HOME', "$GITHUB\$HOME_USER")
[Environment]::SetEnvironmentVariable('HOME_GIT_HOME', "$GITHUB\$HOME_USER", 'User')
$HOME_GIT_HOME = [Environment]::GetEnvironmentVariable('HOME_GIT_HOME')

[Environment]::SetEnvironmentVariable('WORK_GIT_HOME', "$WORK_GIT\$WORK_USER")
[Environment]::SetEnvironmentVariable('WORK_GIT_HOME', "$WORK_GIT\$WORK_USER", 'User')
$WORK_GIT_HOME = [Environment]::GetEnvironmentVariable('WORK_GIT_HOME')

[Environment]::SetEnvironmentVariable('GITHUB_HOME', "$HOME_GIT_HOME")
[Environment]::SetEnvironmentVariable('GITHUB_HOME', "$HOME_GIT_HOME", 'User')
$GITHUB_HOME = [Environment]::GetEnvironmentVariable('GITHUB_HOME')

[Environment]::SetEnvironmentVariable('GITHUB_URL', "$HOME_GIT_URL")
[Environment]::SetEnvironmentVariable('GITHUB_URL', "$HOME_GIT_URL", 'User')
$GITHUB_URL = [Environment]::GetEnvironmentVariable('GITHUB_URL')

[Environment]::SetEnvironmentVariable('NOTES', "$GITHUB_HOME\Notes")
[Environment]::SetEnvironmentVariable('NOTES', "$GITHUB_HOME\Notes", 'User')
$NOTES = [Environment]::GetEnvironmentVariable('NOTES')

[Environment]::SetEnvironmentVariable('SETUP', "$GITHUB_HOME\Setup")
[Environment]::SetEnvironmentVariable('SETUP', "$GITHUB_HOME\Setup", 'User')
$SETUP = [Environment]::GetEnvironmentVariable('SETUP')
