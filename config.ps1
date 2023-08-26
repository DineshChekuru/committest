Add-PoshGitToProfile -AllHosts -Force

git clone "https://github.com/DineshChekuru/committest.git" -b "dinesh"

cd .\committest

$commitid = "0b75cfa2838dfe97776823207d824c897d9a0ca3"

$log_files = New-Object -TypeName "System.Collections.ArrayList"
$log_files = git log --pretty=oneline

foreach($commit in $log_files) 
{
$commit = $commit.split(" ")
if($commit -match $commitid)
{
Write-Host "File Modified " $commit[2]

$filename = $commit[2]
$devfilepath = ".\dev\$filename"
$prodfilepath = ".\prod\$filename"

$content = Get-Content -Path $devfilepath

$filecheck = Get-ChildItem -Path $prodfilepath

if(!$filecheck)
{
New-Item -Path $prodfilepath
}

Set-Content $prodfilepath $content

}
}
