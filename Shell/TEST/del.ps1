# set folder path(路徑)
$dump_path = "D:\WebServer\www\RubyGameLog\ServerAPI"
 
# set minimum age of files and folders(設置保留幾日內的資料量)
$max_days = "-30"
 
# get the current date(取得當前日期)
$curr_date = Get-Date
 
# determine how far back we go based on current date(根據當前日期加上設定的保留天數，來決定要追朔多久前的資料)
$del_date = $curr_date.AddDays($max_days)
 
# delete the files and folders(Get-ChildItem取得路徑下所有子目錄、Where-Object條件過濾創建日期小於給定值，則執行刪除)
Get-ChildItem $dump_path   | Where-Object { $_.CreationTime -lt $del_date }  | Remove-Item -Recurse