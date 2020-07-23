<#
.SYNOPSIS 
    Push everything to the remote repository.
.Description
    1) Add ALL files.
    2) Commits the changes.
    3) Pushes the commit to the configured remote repository.
.PARAMETER msg
    The commit message.
.EXAMPLE
    Up "My Message"
    Pushes all changes to the server using the given commit message.
#>
Function Up() {
    param (
        [Parameter(Mandatory=$true)]
        [string]$msg,
        [switch]$force = $false
    )
    # Abort if not in Git repository
    if ( !(IsGitRepo) ) {
        Return
    }
        
    # Commit
    CommitAll $msg

    # Push
    $cmd = "push"
    if ( $force ) {
        $cmd += " -f"
    }
    $out = $(git $cmd) 2>&1

    # Auto set-upstream
    if ( $out.Length -ge 4 ) {
        $message = $out[1].Exception.Message
        if ( $message.Contains( "To push the current branch and set the remote as upstream" ) ) {
            $message = $out[3].Exception.Message
            $setUpstreamCommand = $message.SubString( $message.IndexOf( "git push --set-" ) ) -Replace "`n","" -Replace "`r",""
            Invoke-Expression -Command $setUpstreamCommand
        }
        else {
            # Print other erors so that the user can see the problem
            foreach( $errorLine in $out ) {
                Write-Host $errorLine
            }
        }
    }
}

<#
.SYNOPSIS 
    Commits all changes to the local repository.
.Description
    1) Add all changes.
    2) Commits the changes.
.PARAMETER msg
    The commit message.
.EXAMPLE
    CommitAll "My Message"
    Commits all changes using the given commit message.
#>
Function CommitAll() {
    param (
        [Parameter(Mandatory=$true)]
        [string]$msg 
    )
    # Abort if not in Git repository
    if ( !(IsGitRepo) ) {
        Return
    }
        
    AddAll

    git commit -m $msg
}

<#
.SYNOPSIS 
    Adds all changes
.Description
    git add -A
.EXAMPLE
    AddAll
    Adds all changes.
#>
Function AddAll() {
    # Abort if not in Git repository
    if ( !(IsGitRepo) ) {
        Return
    }

    git add -A
}