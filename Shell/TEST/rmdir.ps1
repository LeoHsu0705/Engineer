#定義年月日參數，判斷檔案名稱
$year = (get-date).Year
$mon = (get-date).Month
$day = (get-date).Day
#定義刪除的路徑
$path = "D:\DelTest"
$floder = Get-ChildItem $path
$floderyear = "$path\$year"
$flodermon = "$floderyear\$mon"
$floderday = "$flodermon\$day"
#定義要刪除的天數，轉換成時間差
$del = 25
$delday = (get-date).Day - $del

foreach ($fileday in $floderday)
{
    echo "$fileday"
#    if ($delday -le $del)
#    {
#        Get-ChildItem $flodermon | Where-Object { $delday -le $del } | Remove-Item -Force -Recurse
#    }
}
