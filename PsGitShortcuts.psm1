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
	.EXAMPLE
		Up "My Message" origin/master
		Up -msg "My Message" -remote origin/master
		Pushes all changes to the server using the given commit message.
#>
function Up() {
	param(
		[Parameter(Mandatory=$true)][string]$msg )
		
	git add -A
	git commit -m $msg
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
	)
	
	$maxLength = 0;
	ForEach($x in $projects) {
		if($x.Name.Length -gt $maxLength) {
			$maxLength = $x.Name.Length
		}
	}
	
	$maxLength += 10
	ForEach($x in $projects) {
		Write-Host $x.Name.PadRight($maxLength, ' ') "("$x.Text "";
	}
}

# Export all functions
Export-ModuleMember -Function *