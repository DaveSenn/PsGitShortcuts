# Comment help: http://blogs.technet.com/b/heyscriptingguy/archive/2010/01/07/hey-scripting-guy-january-7-2010.aspx

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
function Up() {
    param([Parameter(Mandatory=$True)][string]$msg )
        
    CommitAll $msg
    git push
}

<#
    .SYNOPSIS 
        Prints the number of commits by each author.
    .Description
        Uses git shortlog feature to print out the number of commits per author.
        Command used: 
            If $allBranches set to false:
                git shortlog -s -n
            If $allBranches set to true:
                git shortlog -s -n --all
    .PARAMETER allBranches
        A value determining whether the commits of all branches ($True) or only of the current branch ($False) should outputted counted.
    .EXAMPLE
        CommitCount
        Print commit count of current branch only.
    .EXAMPLE
        CommitCount $true
        CommitCount -allBranches $true
        Print commit count of all branches.
#>
function CommitCount() {
    param([bool]$allBranches = $false)
    
    if($allBranches) {
        git shortlog -s -n --all
    }
    else {
        git shortlog -s -n
    }
}

<#
    .SYNOPSIS 
        Synchronizes the current branch with another branch.
    .Description
        Synchronizes the current branch with another branch.
        If a commit message is provided, this command will also commit
        all local changes.
        
        1)  Commit everything if $msg is specified.
        2)  Check for remote changes.
        3)  Pull changes.
        4)  Checkout other branch.
        5)  Check for remote changes.
        6)  Pull changes.
        7)  Merge with current branch.
        8)  Push.
        9)  Checkout current branch.
        10) Merge with target branch.
        11) Push.
    .PARAMETER msg
        The commit message.
    .PARAMETER targetBranch
        The target branch.
    .EXAMPLE
        SyncBranches master
        SyncBranches -targetBranch master
        Synchronizes the current branch with master.
    .EXAMPLE
        SyncBranches master "My Message"
        SyncBranches -targetBranch master -msg "My Message"
        Commits all changes and synchronizes the current branch with master.
#>
function SyncBranches() {
    param(
        [Parameter(Mandatory=$true)][string]$targetBranch,
        [Parameter(Mandatory=$False)][string]$msg)
    
    $currentBranch = git name-rev --name-only HEAD
    if($msg) {
        CommitAll $msg
    }
    
    $contunue = TryMergeRemoteBranch
    if($contunue -eq $False) {
        return;
    }
    
    git checkout $targetBranch
    $contunue = TryMergeRemoteBranch
    if($contunue -eq $False) {
        return;
    }
    
    git merge $currentBranch --no-ff
    git push
    git checkout $currentBranch
    git merge $targetBranch --no-ff
    git push
}

<#
    .SYNOPSIS 
        Tries to merge the local branch with the matching remote branch.
        Returns $True if the merge was successfully; otherwise, $False.
    .Description
        Tries to merge the local branch with the matching remote branch.
        Returns $True if the merge was successfully; otherwise, $False.
    .EXAMPLE
        TryMergeRemoteBranch
        Tries to merge the branch.
#>
function TryMergeRemoteBranch() {
    git remote update
    $result = git status -uno
    if($result -And $result.Length -gt 1) {
        if($result[1].Contains("Your branch is up-to-date")) {
            return $True
        }
    }
    
    Write-Host "Pending merge detected" -ForegroundColor Yellow -BackgroundColor Black
    git pull
    
    $conflicts = git ls-files -u
    if($conflicts.Length -ne 0) {
        Write-Host "Conflicts detected!" -ForegroundColor Red -BackgroundColor Black
        return $False
    }
    
    return $True
}

<#
    .SYNOPSIS 
        Commits everything to the local repository.
    .Description
        1) Add ALL files.
        2) Commits the changes.
    .PARAMETER msg
        The commit message.
    .EXAMPLE
        CommitAll "My Message"
        Commits all changes using the given commit message.
#>
function CommitAll() {
    param(
        [Parameter(Mandatory=$true)][string]$msg )
        
    git add -A
    git commit -m $msg
}

<#
    .SYNOPSIS 
        Prints the PS git shortcuts help.
    .Description
        Prints a basic help text.
    .EXAMPLE
        PsGitHelp
        Prints the help text.
#>
function PsGitHelp() { 
    $projects = @(
        @{ Name = "Up"; Text = "Add, Commit, Push."; }
        @{ Name = "CommitCount"; Text = "Print number of commits."; }
        @{ Name = "SyncBranches"; Text = "Sync the current branch with another branch."; }
    )
    
    $maxLength = 0;
    ForEach($x in $projects) {
        if($x.Name.Length -gt $maxLength) {
            $maxLength = $x.Name.Length
        }
    }
    
    $maxLength += 2
    ForEach($x in $projects) {
        Write-Host $x.Name.PadRight($maxLength, ' ') "("$x.Text ")";
    }
    Write-Host "Use 'Get-Help [FunctionName]' to get more detailed help for a function."
}

# Export all functions
Export-ModuleMember -Function Up, CommitCount, SyncBranches, PsGitHelp