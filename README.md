# PsGitShortcuts
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A collection of git shortcuts for PowerShell.

PsGitShortcuts is compatible with .NET Framework based Powershell 5.X versions and Powershell (Core) 7.

## Commands

Name | Description
--- | ---
**PsGitHelp** | Prints some information about PsGitShortcuts
**AddAll** | Adds all changes.
**CommitAll** | Commits all changes to the local repository.
**CommitCount** | Prints the number of commits by each author.
**GetAuthors** | Gets the name of each author.
**GetChangesByAuthor** | Gets the number of changes per author.
**GitTree** | Prints a visual tree of the repository history.
**OpenGitConfig** | Opens the git configuration.
**PurgeBranches** | Deletes all brunches but master. Can be used to get rid of old/merged feature branches
**SetGitDiffTool** | Configures the git diff tool.
**SetGitEditor** | Configures the git editor.
**SetGitMergeTool** | Configures the git merge tool.
**SetUserData** | Configures the git user data.
**SyncBranch** | Adds all changes from the specified branch to the current branch. You can use this e.g. to add changes from master to your feature branch.
**Up** | Push everything to the remote repository.

## Help / Documentation
Each function within the PsGitShortcuts module comes with a documentation (in powershell style/syntax)

You can run the following command to get the help of all functions.
```powershell
PsGitHelp
```

Or you can use `Get-Help` to get the documentation of a single function
```powershell
Get-Help Up -Full
```

## Installing 

The **recommended** (and easiest) way is to install PsGitShortcuts from the [PowerShell Gallery](https://www.powershellgallery.com/packages/PsGitShortcuts)
```powershell
Install-Module -Name PsGitShortcuts
```

But you can also clone the repository and add it to your PowerShell profile.

The following variable will contain the location of your PowerShell profile.
```powershell
$PROFILE
```
Add PsGitShortcuts to your profile like this:
```powershell
Import-Module C:\Repos\PsGitShortcuts.psm1
```

## Contribute
If you have an idea for a new feature or if you have found a bug please open an issue and i will take a look at it.
You can also open a PR but maybe it's better to first open a issue.

### Contributors

[![](https://contributors-img.web.app/image?repo=DaveSenn/PsGitShortcuts)](https://github.com/DaveSenn/PsGitShortcuts/graphs/contributors)
