[CmdletBinding()]
Param([string]$lists)

$listArr = $lists.split(',');
Write-Host "Total:" $listArr.Count

$file = "gcs-setting.txt"
$num = (type gcs-setting.txt | Select-String -NotMatch "#" | measure-object -line).Lines
$outdir = (Get-ChildItem -Name | Select-String "out" | measure-object -line).Lines
$j = 1;
for ( $i = 1 ; $i -le $num ; $i++ )
{
    $id = "$(type $file | Select-String -NotMatch "#" | select -first $i | select -last 1)".split(',')[0]
    $key = "$(type $file | Select-String -NotMatch "#" | select -first $i | select -last 1)".split(',')[1]
    if ($id -in $listArr) {
        Write-Host $j, "::", $id, $key
        $image = "DEV20220601-01"
        Copy-Item ".\gcs-deploy.yaml" -Destination "../../deployment/gcs/$id-deploy.yaml"
        ((Get-Content -Path ../../deployment/gcs/$id-deploy.yaml -Raw) -replace "tmp-deploy","$id") | Set-Content -Path ../../deployment/gcs/$id-deploy.yaml
        ((Get-Content -Path ../../deployment/gcs/$id-deploy.yaml -Raw) -replace "tmp-guid","$key") | Set-Content -Path ../../deployment/gcs/$id-deploy.yaml
        ((Get-Content -Path ../../deployment/gcs/$id-deploy.yaml -Raw) -replace "tmp-image","$image") | Set-Content -Path ../../deployment/gcs/$id-deploy.yaml
        $j++;
    }
}
