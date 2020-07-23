<#
.SYNOPSIS 
    Prints the number of commits by each author.
.Description
    Uses git shortlog feature to print out the number of commits per author.
.PARAMETER allBranches
    A value determining whether the commits of all branches ($True) or only of the current branch ($False) should be counted.
.EXAMPLE
    CommitCount
    Print commit count of current branch only.
.EXAMPLE
    CommitCount $True
    CommitCount -allBranches $True
    Print commit count of all branches.
#>
Function CommitCount() {
    param(
        [bool]$allBranches = $False
    )
    
    # Abort if not in Git repository
    if ( !(IsGitRepo) ) {
        Return
    }
    
    if ( $allBranches ) {
        git shortlog -s -n --all
    }
    else {
        git shortlog -s -n
    }
}

<#
.SYNOPSIS 
    Gets the name of each author.
.Description
    Uses git log to get the names of all authors.
.EXAMPLE
    GetAuthors
    Gets the authors.
#>
Function GetAuthors() {
    # Abort if not in Git repository
    if ( !(IsGitRepo) ) {
        Return
    }

    return git log --format='%aN' | Sort-Object -Unique
}

<#
.SYNOPSIS 
    Prints a visual tree of the repository history.
.Description
    Uses git log to print a commit history.
.EXAMPLE
    GitTree
    Prints a commit tree.
#>
Function GitTree() {
	git log --graph --abbrev-commit --decorate --format=format:'%C(bold Magenta)%h%C(reset) - %s%C(reset) - %C(bold cyan)%an%C(reset) %C(bold green)(%ar)%C(reset) %C(dim white) %C(bold yellow)%d%C(reset)'
}

<#
.SYNOPSIS 
    Gets the number of changes per author.
.Description
    Uses git log to callculate the number of changes per author.
.PARAMETER author
    The name of the author to get the stats of.
.PARAMETER allBranches
    A value determining whether the commits of all branches ($True) or only of the current branch ($False) should be counted.
.EXAMPLE
    GetChangesByAuthor
    Gets the number of changes of all authors (current branch).
.EXAMPLE
    GetChangesByAuthor "athor name" $True
    Gets the number of changes of the user with the given name (all branches).
#>
function GetChangesByAuthor() {
    param (
        [Parameter(Mandatory=$False) ][string] $author,
        [Parameter(Mandatory=$False) ][bool] $allBranches = $false
    )
    
    if ( !$author ) {
        $authors = GetAuthors
    } else {
        $authors = [array] $author;
    }
    $result = @()
    
    foreach ( $authorName in $authors ) {
        if ( $allBranches ) {
            $log = git log --author="$authorName" --pretty=tformat: --numstat --all
        }
        else {
            $log = git log --author="$authorName" --pretty=tformat: --numstat
        }

		if( !$log ) {
			continue;
		}
		
        $lines = $log.Split( "`r`n", [System.StringSplitOptions]::RemoveEmptyEntries )
        
        $add = 0
        $delete = 0
        
        foreach ( $line in $lines ) {
            $values = $line.Split()
            try {
                $add +=  [Convert]::ToInt32( $values[0], 10 )
                $delete +=  [Convert]::ToInt32( $values[1], 10 )
            }
            catch {	
            }			
        }
        
        $result += (New-Object PSObject -Property @{ 'Add' = $add; 'Delete' = $delete; 'All' = $add + $delete; 'Author' = $authorName; })
    }
    
    return $result | Sort-Object All -Descending
}
