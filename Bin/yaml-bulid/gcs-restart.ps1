$file = "gcs-setting.txt"
$num = (type $file | Select-String -NotMatch "#" | measure-object -line).Lines

for ( $i = 1 ; $i -le $num ; $i++ )
{
	$dp = "$(type $file | Select-String -NotMatch "#" | select-object -first $i | select-object -last 1)".split(',')[0]
    $id = $dp
    kubectl rollout restart deployment/$id -n rcg
}