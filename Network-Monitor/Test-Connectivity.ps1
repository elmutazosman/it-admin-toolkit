
# Network Connectivity Monitor
# Use only on systems you are authorized to test.

$Targets = @(
    "127.0.0.1",
    "8.8.8.8"
)

$Results = foreach ($Target in $Targets) {
    $Online = Test-Connection `
        -ComputerName $Target `
        -Count 2 `
        -Quiet `
        -ErrorAction SilentlyContinue

    [PSCustomObject]@{
        Target    = $Target
        Status    = if ($Online) { "Online" } else { "No Reply" }
        CheckedAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    }
}

$Results | Format-Table -AutoSize

$Results | Export-Csv `
    -Path ".\sample-results.csv" `
    -NoTypeInformation
