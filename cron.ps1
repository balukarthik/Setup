param(
    [string]$ScriptPath
)

# Set up Task Scheduler variables
$TaskName = "MyHourlyTask"
$Action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-File `"$ScriptPath`""
$Trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).AddMinutes(1) -RepetitionInterval (New-TimeSpan -Hours 1) -RepetitionDuration (New-TimeSpan -Days 3650)

# Check if the task already exists
$task = Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue

if ($task) {
    Write-Host "Task '$TaskName' already exists."
} else {
    Register-ScheduledTask -TaskName $TaskName -Action $Action -Trigger $Trigger -Description "Runs $ScriptPath every hour"
    Write-Host "Task '$TaskName' created to run $ScriptPath every hour."
}