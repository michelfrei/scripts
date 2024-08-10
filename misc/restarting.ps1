$computers = 1..2 | ForEach-Object { "server0$_" }

$computers | ForEach-Object {
    Start-Job -ArgumentList $_ -ScriptBlock {
        Restart-Computer -ComputerName $args[0] -Force
    }
}