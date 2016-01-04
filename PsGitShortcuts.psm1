# Push everything to the remote repository
# 1) Add ALL files
# 2) Commit
# 3) Push
function up(){
	param( [string]$msg )
	git add -A
	git commit -m $msg
	git push
}

# Export all functions
Export-ModuleMember -Function *