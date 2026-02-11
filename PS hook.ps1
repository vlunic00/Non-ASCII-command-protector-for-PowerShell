function On-CommandExecution {
    param($Command)
    
    # Regex for non-ASCII: anything outside the range of 0-127
    if ($Command -match '[^\x00-\x7F]') {
        Write-Host "---" -ForegroundColor Red
        Write-Host "BLOCKING EXECUTION: Non-ASCII characters detected!" -ForegroundColor Yellow
        Write-Host "Offending command: $Command" -ForegroundColor White
        Write-Host "---" -ForegroundColor Red
        return $false
    }
    return $true
}

# This overrides the default handler for the Enter key in PSReadLine
Set-PSReadLineKeyHandler -Key Enter -ScriptBlock {
    $line = ""
    $cursor = 0
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
    
    if (On-CommandExecution -Command $line) {
        [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
    }
}