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