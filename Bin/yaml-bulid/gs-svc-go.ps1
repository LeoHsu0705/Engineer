$file = "gs-setting.txt"
$num = (type gs-setting.txt | Select-String -NotMatch "#" | measure-object -line).Lines
$outdir = (Get-ChildItem -Name | Select-String "out" | measure-object -line).Lines

for ( $i = 1 ; $i -le $num ; $i++ )
{
    $deskCode = "$(type $file | Select-String -NotMatch "#" | select -first $i | select -last 1)".split(',')[0]
    $id = "$("gs-")" + $deskCode
    Copy-Item ".\gs-svc.yaml" -Destination "../../Service/$id-svc.yaml"
    ((Get-Content -path ../../Service/$id-svc.yaml -Raw) -replace "tmp-id","$id") | Set-Content -Path ../../Service/$id-svc.yaml
    ((Get-Content -path ../../Service/$id-svc.yaml -Raw) -replace "tmp-svc","$id-svc") | Set-Content -Path ../../Service/$id-svc.yaml
}