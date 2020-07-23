<#
.SYNOPSIS 
    Checks if the current location is a Git repository or not.
#>
Function IsGitRepo {  
    $out = $(git rev-parse) 2>&1
    $isRepo = $out.Length -eq 0

    if ( !$isRepo ) {
        Write-Host "Not a Git repository" -ForegroundColor Yellow
    }

    Return $isRepo
}

<#
.SYNOPSIS 
    Gets the name of the currently checked out branch.
#>
Function GetCurrentBranchName() {
    $branchName = &git rev-parse --abbrev-ref HEAD 
    return $branchName
}