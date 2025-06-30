function Set-EnvironmentVariableIfDifferent {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$VariableName,

        [Parameter(Mandatory=$true)]
        [string]$DesiredValue
    )

    # Get the current value of the environment variable (if it exists)
    $CurrentValue = Get-ChildItem Env:$VariableName -ErrorAction SilentlyContinue

    Invoke-Expression "Set-Variable -Name $VariableName -Value $DesiredValue"
    # Check if the variable exists AND its value is not the desired value
    if ($CurrentValue -ne $null -and $CurrentValue.Value -ne $DesiredValue) {
        # Set the environment variable to the desired value using the specified scope
        [Environment]::SetEnvironmentVariable($VariableName, $DesiredValue)
        [Environment]::SetEnvironmentVariable($VariableName, $DesiredValue, "User")
        Write-Host "Environment variable '$VariableName' updated to '$DesiredValue'."
    } elseif ($CurrentValue -eq $null) {
        [Environment]::SetEnvironmentVariable($VariableName, $DesiredValue)
        [Environment]::SetEnvironmentVariable($VariableName, $DesiredValue, "User")
        # If the variable doesn't exist, create it with the desired value using the specified scope
        Write-Host "Environment variable '$VariableName' created with value '$DesiredValue'."
    } else {
        # If the variable exists and its value is already the desired value, do nothing
        Write-Host "Environment variable '$VariableName' already has the desired value '$DesiredValue'."
    }
}

Set-EnvironmentVariableIfDifferent -VariableName "WORK_USER" -DesiredValue "kbalu"
Invoke-Expression "Set-Variable -Name 'WORK_USER' -Value 'kbalu'"

Set-EnvironmentVariableIfDifferent -VariableName "HOME_USER" -DesiredValue "balukarthik"
Invoke-Expression "Set-Variable -Name 'HOME_USER' -Value 'balukarthik'"

Set-EnvironmentVariableIfDifferent -VariableName "WORK_GIT" -DesiredValue "$HOME\work-git"
Invoke-Expression "Set-Variable -Name 'WORK_GIT' -Value '$HOME\work-git'"

Set-EnvironmentVariableIfDifferent -VariableName "WORK_GIT_URL" -DesiredValue "https://github.qualcomm.com/"
Invoke-Expression "Set-Variable -Name 'WORK_GIT_URL' -Value 'https://github.qualcomm.com/'"

Set-EnvironmentVariableIfDifferent -VariableName "GITHUB" -DesiredValue "$HOME\github"
Invoke-Expression "Set-Variable -Name 'GITHUB' -Value '$HOME\github'"

Set-EnvironmentVariableIfDifferent -VariableName "HOME_GIT_URL" -DesiredValue "https://github.com/"
Invoke-Expression "Set-Variable -Name 'HOME_GIT_URL' -Value 'https://github.com'"

Set-EnvironmentVariableIfDifferent -VariableName "HOME_GIT_HOME" -DesiredValue "$GITHUB\$HOME_USER"
Invoke-Expression "Set-Variable -Name 'HOME_GIT_HOME' -Value '$GITHUB\$HOME_USER'"

Set-EnvironmentVariableIfDifferent -VariableName "WORK_GIT_HOME" -DesiredValue "$WORK_GIT\$WORK_USER"
Invoke-Expression "Set-Variable -Name 'WORK_GIT_HOME' -Value '$WORK_GIT\$WORK_USER'"

Set-EnvironmentVariableIfDifferent -VariableName "GITHUB_HOME" -DesiredValue "$HOME_GIT_HOME"
Invoke-Expression "Set-Variable -Name 'GITHUB_HOME' -Value '$HOME_GIT_HOME'"

Set-EnvironmentVariableIfDifferent -VariableName "GITHUB_URL" -DesiredValue "$HOME_GIT_URL"
Invoke-Expression "Set-Variable -Name 'GITHUB_URL' -Value '$HOME_GIT_URL'"

Set-EnvironmentVariableIfDifferent -VariableName "NOTES" -DesiredValue "$GITHUB_HOME\Notes"
Invoke-Expression "Set-Variable -Name 'NOTES' -Value '$GITHUB_HOME\Notes'"

Set-EnvironmentVariableIfDifferent -VariableName "SETUP" -DesiredValue "$GITHUB_HOME\Setup"
Invoke-Expression "Set-Variable -Name 'SETUP' -Value '$GITHUB_HOME\Setup'"
