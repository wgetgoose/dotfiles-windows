Invoke-Expression (&starship init powershell)

#Install-Module PSReadLine -Repository PSGallery -Scope CurrentUser -Force
Import-Module PSReadLine
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -EditMode Emacs

#Install-Module -Name Terminal-Icons -Force
#Import-Module Terminal-Icons

function upall {
    gsudo winget upgrade --all
}

# I hate findstring, to BusyBox grep we go
# Set-Alias grep findstr

#Set-Alias ll ls

# BusyBox rm instead of Windows native
#Set-Alias rm rm.exe

# Tab-Complete / Autocomplete for winget: https://github.com/microsoft/winget-cli/blob/master/doc/Completion.md
Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
        [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
        $Local:word = $wordToComplete.Replace('"', '""')
        $Local:ast = $commandAst.ToString().Replace('"', '""')
        winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
}