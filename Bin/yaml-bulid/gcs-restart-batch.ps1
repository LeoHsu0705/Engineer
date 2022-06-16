[CmdletBinding()]
Param([string]$lists)

$listArr = $lists.split(',');
Write-Host "Total:" $listArr.Count

$file = "gcs-setting.txt"
$num = (type $file | Select-String -NotMatch "#" | measure-object -line).Lines
$j = 1
for ( $i = 1 ; $i -le $num ; $i++ )
{
	$dp = "$(type $file | Select-String -NotMatch "#" | select-object -first $i | select-object -last 1)".split(',')[0]
    $id = $dp
    if ($id -in $listArr) {
        Write-Host $j":: kubectl rollout restart deployment/"$id" -n rcg"
        kubectl rollout restart deployment/$id -n rcg
        $j++
    }
}