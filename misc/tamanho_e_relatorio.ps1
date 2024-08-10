param($export)

$nome = @{
    Label="Nome";
    Expression={ $_.Name }
}
$tamanho = @{
    Label="Tamanho MB";
    Expression={ "{0:N2}MB" -f ($_.Length / 1MB)}
}
$params = $nome, $tamanho

$resultado = 
    Get-ChildItem -Recurse -File | 
    Where-Object Name -like "*.pdf*" | 
    Select-Object $params


if($export -eq "HTML"){
    $estilos = Get-Content C:\Users\Real\Documents\style.css
    $styletag = "<style> $estilos </style>"
    $titulo = "Relatorio"
    $bodi = "<h1> Relatorio geral </h1>"
    
    $resultado | 
    ConvertTo-Html -Head $styletag -Title $titulo -Body $bodi | 
    Out-File C:\temp\relatorio.html
} elseif ($export -eq "JSON") {
    $resultado | ConvertTo-Json | Out-File C:\temp\relatorio.json
} elseif ($export -eq "CSV") {
    $resultado | ConvertTo-Csv -NoTypeInformation | Out-File C:\temp\relatorio.csv
} else {
    $resultado
}