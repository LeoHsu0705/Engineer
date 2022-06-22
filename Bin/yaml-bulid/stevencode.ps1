$file = "stevencode-setting.txt"
$num = (type stevencode-setting.txt | Select-String -NotMatch "#" | measure-object -line).Lines
$outdir = (Get-ChildItem -Name | Select-String "out" | measure-object -line).Lines
$game = "gcs"

for ( $i = 1 ; $i -le $num ; $i++ )
{
    $stevencode = "$(type $file | Select-String -NotMatch "#" | select -first $i | select -last 1)".split(',')[0]    
    $id = "$("$game-")" + $stevencode
    $image = "DEV20220621-01"
    Copy-Item ".\$game-deploy.yaml" -Destination "../../deployment/$game/$id-deploy.yaml"
    ((Get-Content -Path ../../deployment/$game/$id-deploy.yaml -Raw) -replace "tmp-deploy","$id") | Set-Content -Path ../../deployment/$game/$id-deploy.yaml
    ((Get-Content -Path ../../deployment/$game/$id-deploy.yaml -Raw) -replace "tmp-stevencode","$stevencode") | Set-Content -Path ../../deployment/$game/$id-deploy.yaml
    ((Get-Content -Path ../../deployment/$game/$id-deploy.yaml -Raw) -replace "tmp-image","$image") | Set-Content -Path ../../deployment/$game/$id-deploy.yaml
}
