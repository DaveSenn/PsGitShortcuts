# Get public and private function definition files.
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )
$Public = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )

# Load the files
Foreach ( $import in @( $Private + $Public ) ) {
    Try {
        . $import.fullname
    }
    Catch {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

# Export
$exportModuleMemberParams = @{
    Function = @(
        # Up/Down
        "Up",
        "CommitAll",
        "AddAll",
        # Log
        "CommitCount",
        "GetAuthors",
        "GitTree",
        "GetChangesByAuthor",
        # Config
        "SetUserData",
        "SetGitEditor",
        "SetGitMergeTool",
        "SetGitDiffTool",
        "OpenGitConfig",
        # Branch
        "PurgeBranches",
        "SyncBranch",
        # Help
        "PsGitHelp"
    )
}
Export-ModuleMember @exportModuleMemberParams