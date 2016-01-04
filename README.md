# PsGitShortcuts
A collection of git shortcuts for PowerShell

## Commands

### UP

#### Parameters
Name | Type | Description
--- | --- | ---
**msg** | `string` | The commit message

1. Adds **ALL** files
2. Commits the changes with the given message
3. Pushes the commit to the configured remote repository

```powershell
up "My commit message"
```

## Installing 

1. Verify execution of scripts is allowed with `Get-ExecutionPolicy` (should be `RemoteSigned` or `Unrestricted`). If scripts are not enabled, run PowerShell as Administrator and call `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Confirm`.
2. Verify that `git` can be run from PowerShell.
   If the command is not found, you will need to add a git alias or add `%ProgramFiles(x86)%\Git\cmd`
   (or `%ProgramFiles%\Git\cmd` if you're still on 32-bit) to your `PATH` environment variable.
3. Clone the PsGitShortcuts repository to your local machine.
4. From the PsGitShortcuts repository directory, run `.\install.ps1`.