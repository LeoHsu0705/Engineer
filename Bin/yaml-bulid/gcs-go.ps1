$file = "gcs-setting.txt"
$num = (type gcs-setting.txt | Select-String -NotMatch "#" | measure-object -line).Lines
$outdir = (Get-ChildItem -Name | Select-String "out" | measure-object -line).Lines

for ( $i = 1 ; $i -le $num ; $i++ )
{
    $stevencode = "$(type $file | Select-String -NotMatch "#" | select -first $i | select -last 1)".split(',')[0]    
    $id = "$("gcs-")" + $stevencode
    $image = "DEV20220608-03"
    Copy-Item ".\gcs-deploy.yaml" -Destination "../../deployment/gcs/$id-deploy.yaml"
    ((Get-Content -Path ../../deployment/gcs/$id-deploy.yaml -Raw) -replace "tmp-deploy","$id") | Set-Content -Path ../../deployment/gcs/$id-deploy.yaml
    ((Get-Content -Path ../../deployment/gcs/$id-deploy.yaml -Raw) -replace "tmp-stevencode","$stevencode") | Set-Content -Path ../../deployment/gcs/$id-deploy.yaml
    ((Get-Content -Path ../../deployment/gcs/$id-deploy.yaml -Raw) -replace "tmp-image","$image") | Set-Content -Path ../../deployment/gcs/$id-deploy.yaml
}
