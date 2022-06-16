[CmdletBinding()]
Param([string]$lists)

$listArr = $lists.split(',');
Write-Host "Total:" $listArr.Count

$file = "gs-setting.txt"
$num = (type gs-setting.txt | Select-String -NotMatch "#" | measure-object -line).Lines
$outdir = (Get-ChildItem -Name | Select-String "out" | measure-object -line).Lines

for ( $i = 1 ; $i -le $num ; $i++ )
{
    $deskCode = "$(type $file | Select-String -NotMatch "#" | select -first $i | select -last 1)".split(',')[0]
    $key = "$(type $file | Select-String -NotMatch "#" | select -first $i | select -last 1)".split(',')[1]
    $image = "UAT20211119-02"
    $id = "$("gs-")" + $deskCode

    if ($id -in $listArr) {
        Write-Host $j, "::", $id, $key
        Copy-Item ".\gs-deploy.yaml" -Destination "../../deployment/gs/$id-deploy.yaml"
        ((Get-Content -Path ../../deployment/gs/$id-deploy.yaml -Raw) -replace "tmp-deploy","$id") | Set-Content -Path ../../deployment/gs/$id-deploy.yaml
        ((Get-Content -Path ../../deployment/gs/$id-deploy.yaml -Raw) -replace "tmp-guid","$key") | Set-Content -Path ../../deployment/gs/$id-deploy.yaml
        ((Get-Content -Path ../../deployment/gs/$id-deploy.yaml -Raw) -replace "tmp-image","$image") | Set-Content -Path ../../deployment/gs/$id-deploy.yaml
        ((Get-Content -Path ../../deployment/gs/$id-deploy.yaml -Raw) -replace "tmp-deskcode","$deskCode") | Set-Content -Path ../../deployment/gs/$id-deploy.yaml
    }
}
