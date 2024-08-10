function Add-applicationpool {
    param (
        [String[]] $computername,
        [String] $applicationpoolname
    )
    
    $sessions = $computername | ForEach-Object { New-PSSession -ComputerName $_ }
    $jobs = $sessions | ForEach-Object {
        Invoke-Command -Session $_ -ScriptBlock {
            $appcmdargs = "add apppool /name: $($args[0]) /managedRuntimeVersion:v4.0 /managedPipelineMode:Integrated"
            C:\Windows\System32\inetsrv\appcmd.exe $appcmdargs.Split(' ')
        } -ArgumentList $applicationpoolname -AsJob
    }

    $jobs | Wait-Job | Select-Object @{ Expression={ Receive-Job $_ }; Label="Resultado"}, "Nome" # espera o termino das execucoes das sessoes para desbloquear a shell | printa o resultado no final da execucao
    $jobs | Remove-Job # remove os jobs após finalizados
    $sessions | Remove-PSSession # remove as sessões abertas
} 

<# 
mapeia pasta no powershell 
New-PSDrive -Name server01_inet -Root '\\server01\c$\Windows\System32\' -PSProvider FileSystem

lista drives
Get-PSDrive

PS C:\> cd C:\Windows\System32\inetsrv\
PS C:\Windows\System32\inetsrv> .\appcmd.exe add apppool /name:Servicos /managedRuntimeVersion:v4.0 /managedPipelineMode:Integrated

out-gridview
format-list
Add-applicationpool -ComputerName $computers -applicationpoolname "nova-aplicacao" | fl
#>