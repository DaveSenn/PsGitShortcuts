# PsGitShortcuts
A collection of git shortcuts for PowerShell

## Commands

### UP
Push everything to the remote repository.
#### Parameters
Name | Type | Mandator | Description
--- | --- | --- | ---
**msg** | `string` | True | The commit message.

```powershell
up "My commit message"
```

### CommitCount
Prints the number of commits by each author.
#### Parameters
Name | Type | Mandator | Description
--- | --- | --- | ---
**allBranches** | `bool` | False | A value determining whether the commits of all branches ($True) or only of the current branch ($False) should outputted counted.

```powershell
CommitCount
CommitCount $True
```

### IgnoreFile
Removes the specified file from the index and adds it to the .gitignore file.
#### Parameters
Name | Type | Mandator | Description
--- | --- | --- | ---
**file** | `string` | True | The file to remove.
**ignoreFile** | `string` | False | The path to the .gitignore file, if not specified the .gitignore file at the current location will be used.

```powershell
IgnoreFile test.txt
IgnoreFile test.txt subfolder\.gitignore
```

### DeleteFileCompletely
Deletes the specified file completely from the repository inc. history.
#### Parameters
Name | Type | Mandator | Description
--- | --- | --- | ---
**file** | `string` | True | The file to delete.

```powershell
DeleteFileCompletely movie.avi
```

### SyncBranches
Synchronizes the current branch with another branch.
#### Parameters
Name | Type | Mandator | Description
--- | --- | --- | ---
**targetBranch** | `string` | True | The target branch.
**msg** | `string` | False | The commit message.

```powershell
SyncBranches master
SyncBranches master "My Message"
```

### PsGitHelp
Prints the PS git shortcuts help.

```powershell
PsGitHelp
```

## Installing 

1. Verify execution of scripts is allowed with `Get-ExecutionPolicy` (should be `RemoteSigned` or `Unrestricted`). If scripts are not enabled, run PowerShell as Administrator and call `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Confirm`.
2. Verify that `git` can be run from PowerShell.
   If the command is not found, you will need to add a git alias or add `%ProgramFiles(x86)%\Git\cmd`
   (or `%ProgramFiles%\Git\cmd` if you're still on 32-bit) to your `PATH` environment variable.
3. Clone the PsGitShortcuts repository to your local machine.
4. From the PsGitShortcuts repository directory, run `.\install.ps1`. 
