#param($diretorio)
$diretorio = "D:\misc2\pcaps\"
$ErrorActionPreference = "Stop"

. .\curso2-sha.ps1

$arquivos = Get-ChildItem $diretorio -File

foreach ($arquivo in $arquivos.FullName) {
    $hashitem = Get-FileSHA1 $arquivo
    Write-Host "$arquivo        || $hashitem"
}