# PsGitShortcuts
A collection of git shortcuts for PowerShell

## Commands

### UP
Push everything to the remote repository.
#### Parameters
Name | Type | Description
--- | --- | ---
**msg** | `string` | The commit message

```powershell
up "My commit message"
```

### CommitCount
Prints the number of commits by each author.
#### Parameters
Name | Type | Description
--- | --- | ---
**allBranches** | `bool` | A value determining whether the commits of all branches ($True) or only of the current branch ($False) should outputted counted.

```powershell
CommitCount
CommitCount $True
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