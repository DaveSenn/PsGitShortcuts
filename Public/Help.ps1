<#
.SYNOPSIS 
    Prints some information about PsGitShortcuts
.Description
    Prints some information about PsGitShortcuts
.EXAMPLE
    PsGitHelp
#>
Function PsGitHelp() {
    Write-Host "PsGitShortcuts Help:"
    Get-Command -Module PsGitShortcuts | Foreach-Object { Get-Help $_.Name; Write-Host "------------------------------------------" }

    Write-Host "Available commands:"
    Get-Command -Module PsGitShortcuts | Foreach-Object { Write-Host $_.Name }
}
