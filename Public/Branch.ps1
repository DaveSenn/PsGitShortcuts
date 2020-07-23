<#
.SYNOPSIS 
    Deletes all brunches but master.
    Can be used to get rid of old/merged feature branches
.Description
    Iterates over the branches and deletes everything but master.
.PARAMETER masterName
    The name of the master branch. Default is master.
.EXAMPLE
    PurgeBranches
    PurgeBranches myBranch
#>
Function PurgeBranches() {
    param (
        [string]$masterName = "master"
    )

    # Abort if not in Git repository
    if ( !(IsGitRepo) ) {
        Return
    }

    $allBranches = git branch
    foreach ( $x in $allBranches ) {
        $name = $x.ToString().Trim()
        
        if ( $name -eq $masterName ) {
            continue
        }

        if ( $name.StartsWith( "*" ) ) {
            continue
        }

        git branch -D $name
    }
}

<#
.SYNOPSIS 
    Adds all changes from the specified branch to the current branch.
    You can use this e.g. to add changes from master to your feature branch.
.Description
    - Checks the specifed branch out
    - Pulls changes
    - Checks out the 'current' branch
    - Rebases with the specifed branch
    - Pushes all changes
.PARAMETER masterName
    The name of the branch to sync with. Default is master.
.EXAMPLE
    SyncBranch
    SyncBranch myBranch
#>
Function SyncBranch() {
    param (
        [string]$branch = "master"
    )

    # Abort if not in Git repository
    if ( !(IsGitRepo) ) {
        Return
    }

    # Check same branch
    $startingBranch = GetCurrentBranchName
    if ( $startingBranch -eq $branch ) {
        Write-Host "Cannot sync with same branch - select another target branch" -ForegroundColor Yellow
        return
    }

    # Checkout and update the target branch
    git checkout $branch
    $out = $(git pull) 2>&1
    if ( !$out.Contains( "Already up to date." ) ) {
        Write-Host "Failed to pull branch $branch => abort"
        return
    }

    # Add changes from $branch to current branch
    git checkout $startingBranch
    $out = $(git rebase $branch) 2>&1
    if ( $out.Contains( "CONFLICT" ) -or !$out.Contains( "Successfully" ) ) {
        foreach ( $x in $out ) {
            Write-Host $x
        }
        Write-Host "Rebase $branch failed => abort" -ForegroundColor Yellow
        return
    }
    
    # Update remote
    Up "Sync with $branch"
}