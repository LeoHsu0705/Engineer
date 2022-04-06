#定義天數，要刪除多久以前的檔案
#若是要刪除30天前的檔案，$Days就設定30 
$Days = 50
#取今日時間
$Currentlytime = (Get-Date).AddDays(-$Days)
#定義主目錄
$TargetFolder = "C:\inetpub\logs\LogFiles\W3SVC2"
#透過Get-ChildItem抓該資料夾內的檔案列表
Get-Childitem  -Path $TargetFolder -File
foreach ($item in $Dirs) 
{
 #判斷檔案最後修改時間
 #由LastWriteTime抓取檔案最後修改時間
 #利用AddDays對$Currentlytime做時間的運算 
 if($item.LastWriteTime -le $Currentlytime)            #-le 小於或等於
 {
        Remove-Item $item.FullName | out-null  
        write-host "Finish Deleting Dir $item" -ForegroundColor "DarkRed"
    }    
}