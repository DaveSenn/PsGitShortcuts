$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$modulePath = $projectPath = [System.IO.Path]::Combine($scriptPath, 'PsGitShortcuts.psm1') 

# Load module from current directory
Import-Module $modulePath