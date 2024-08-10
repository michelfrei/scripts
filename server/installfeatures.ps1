$computers = 1..2 | ForEach-Object { "server0$_" }

function Install-WindowsFeaturesInServers {
    param (
        [String[]] $computers,
        [String] $featureName
    )
    
    $jobScriptBlock = {
        Param(
            [String] $computername,
            [String] $featurename
        )
        Install-WindowsFeature -ComputerName $computername -Name $featurename
    }

    $computers | ForEach-Object {
        Start-Job -Name "JOB_$_" -ScriptBlock $jobScriptBlock -ArgumentList ($_, $featureName)
    }
}


<#
# % = ForEach-Object
get-job
receive-job job1 -keep
#>