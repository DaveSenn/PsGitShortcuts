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
    Get-Command -Module PsGitShortcuts 
    | Where-Object { $_.Name -ne "IsGitRepo" -and $_.Name -ne "GetCurrentBranchName" } 
    | Sort-Object -Property Name 
    | Foreach-Object { Write-Host $_.Name }
}
