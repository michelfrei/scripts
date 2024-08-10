function Get-FileSHA1 {
    param (
        [Parameter(
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = "FullName",
            Mandatory = $true
        )]
        [String] $filepath
    )

    begin {
        $sha1 = New-Object System.Security.Cryptography.SHA1Managed
        $prettyhashsb = New-Object System.Text.StringBuilder
    }

    process {
        $filecontent = Get-Content $filepath
        $filebytes = [System.Text.Encoding]::UTF8.GetBytes($filecontent)
        
        $hash = $sha1.ComputeHash($filebytes)
        
        foreach($byte in $hash){
            $hexanotation = $byte.ToString("X2")
            $prettyhashsb.Append($hexanotation) > $null
        }

        $prettyhashsb.ToString()
        $prettyhashsb.Clear() > $null
    }

    end {
        $sha1.Dispose()
    }
}
function Get-FileSHA256 () {
    param (
        [Parameter(
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = "FullName",
            Mandatory = $true
        )]
        [String] $filepath
    )

    begin {
        $sha1 = New-Object System.Security.Cryptography.SHA256Managed
        $prettyhashsb = New-Object System.Text.StringBuilder
    }

    process {
        $filecontent = Get-Content $filepath
        $filebytes = [System.Text.Encoding]::UTF8.GetBytes($filecontent)
        
        $hash = $sha1.ComputeHash($filebytes)
        
        foreach($byte in $hash){
            $hexanotation = $byte.ToString("X2")
            $prettyhashsb.Append($hexanotation) > $null
        }
    
        $prettyhashsb.ToString()
        $prettyhashsb.Clear() > $null
    }

    end {
        $sha1.Dispose()
    }
}
function Get-FileSHA384 () {

}
function Get-FileSHA512 () {

}

<#
$file = "D:\shared\script.ps1"
$hashSHA1 = Get-FileSHA1 $file

Write-Host "O hash do arquivo eh: $hashSHA1" -BackgroundColor Black -ForegroundColor Blue

#$prettyhashsb.ToString() -BackgroundColor White -ForegroundColor Blue
#>