 <#
.SYNOPSIS 
    Configures the git user data.
.Description
    Sets the user name and the user email globally or local.
.PARAMETER name
    The user name.
.PARAMETER email
    The user email address.
.PARAMETER global
    A value determining whether the configuration gets applied globally or not.
.EXAMPLE
    SetUserData "User Name"
    Sets the user name globally.
    
    SetUserData "User Name" "mail@gmail.com"
    Sets the user name and email globally.
    
    SetUserData "User Name" "mail@gmail.com" $false
    Sets the user name and email localy.
#>
Function SetUserData() {
    param (
        [Parameter(Mandatory=$False)] [string] $name = $null,
        [Parameter(Mandatory=$False)] [string] $email = $null,
        [Parameter(Mandatory=$False)] [bool] $global = $true
    )

    # user name
    if ( $name ) {
        if ( $global ) {
            git config --global user.name $name
        }
        else {
            git config user.name $name --replace-all
        }
    }

    # email address
    if ( $email ) {
        if ( $global ) {
            git config --global user.email $email
        }
        else {
            git config user.email $email --replace-all
        }
    }
}

<#
.SYNOPSIS 
   Configures the git editor.
.Description
   Configures the git editor.
.PARAMETER Editor
   The editor to use.
.EXAMPLE
    SetGitEditor npp
    Sets notepad++ as git editor

    SetGitEditor vscode
    Sets VS Code as git editor
#>
Function SetGitEditor() {
   param (
       [ValidateSet( "npp", "vscode" )]
       [Parameter(Mandatory=$True)] [string] $Editor
   )

   $cmd = ""
   if ( $Editor -eq "npp" ) {
       $cmd = "'C:\Program Files (x86)\Notepad++\notepad++.exe' -multiInst -notabbar -nosession -noPlugin"
   }
   else {
       $cmd = "code --wait --new-window"
   }

   git config --global core.editor $cmd
}

<#
.SYNOPSIS 
   Configures the git merge tool.
.Description
   Configures the git merge tool.
.PARAMETER Tool
   The tool to use.
.EXAMPLE
    SetGitMergeTool winmerge
    Sets winmerge as git merge tool

    SetGitMergeTool vscode
    Sets VS Code as git merge tool
#>
Function SetGitMergeTool() {
    param (
        [ValidateSet( "winmerge", "vscode" )]
        [Parameter(Mandatory=$True)] [string] $Tool
    )

    $tool = ""
    $cmd = ""

    if ( $Tool -eq "winmerge" ) {
        $tool = "winmerge"
        $cmd = "'C:\Program Files (x86)\WinMerge\WinMergeU.exe' '$LOCAL' '$REMOTE'"
    }
    else {
        $tool = "code"
        $cmd = "code --wait --new-window --diff $LOCAL $REMOTE"
    }
 
    git config --global merge.tool $tool
    git config --global mergetool.winmerge.cmd $cmd
}

<#
.SYNOPSIS 
   Configures the git diff tool.
.Description
   Configures the git diff tool.
.PARAMETER Tool
   The diff to use.
.EXAMPLE
    SetGitDiffTool winmerge
    Sets winmerge as git diff tool

    SetGitDiffTool vscode
    Sets VS Code as git diff tool
#>
Function SetGitDiffTool() {
    param (
        [ValidateSet( "winmerge", "vscode" )]
        [Parameter(Mandatory=$True)] [string] $Tool
    )

    $tool = ""
    $cmd = ""

    if ( $Tool -eq "winmerge" ) {
        $tool = "winmerge"
        $cmd = "'C:\Program Files (x86)\WinMerge\WinMergeU.exe' '$LOCAL' '$REMOTE'"
    }
    else {
        $tool = "code"
        $cmd = "code --wait --new-window --diff $LOCAL $REMOTE"
    }
 
    git config --global diff.tool $tool
    git config --global difftool.winmerge.cmd $cmd
}

<#
.SYNOPSIS 
   Opens the git configuration.
.Description
   Opens the git configuration.
.PARAMETER global
    A value determining whether the global configuration or the local should be opened.
.EXAMPLE
    OpenGitConfig
    Opens the global Git configuration

    OpenGitConfig $false
    Opens the local Git configuration
#>
Function OpenGitConfig() {
   param (
        [Parameter(Mandatory=$False)] [bool] $global = $true
   )

    if ( $global ) {
        git config --global -e
    }
    else {
        git config -e
    }
}