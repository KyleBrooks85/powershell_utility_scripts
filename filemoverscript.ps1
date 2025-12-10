Write-Output "File copier and mover script"
$data = @('0=Move a File','1=Moving Specific Files','2=Moving Files older than x Days','3=Get Child item' ,'4=Get Child item Recursively','7=Map Network Drive')


for ($i = 0; $i -lt $data.Length; $i++) {
Write-Output $data[$i]
}

$path = read-host "Enter the source file path:"
$destination = read-host "Enter the destination path:"
$typeOfFile = " "
$options = Read-Host "Enter the option from to choose from"
$dateTimeFrame = Read-Host "Enter days"

switch ($options) {
0 { 

# Move only all the files and type of of files from the given path to the destination
Move-Item -Path "$path\*.*" -Destination "$destination" }
1 { Move-Item -Path "$path*.$typeOfFile" -Destination "$destination" }
2 { $dateTime = (Get-Date).AddDays(-$dateTimeFrame)


# Move all files from the given path and subfolders that are older than 30 days
Get-ChildItem -Path $Path -Recurse -File | Where-Object { $_.LastWriteTime -lt $dateTime } | Move-Item -Destination "$destination"}
3 { Get-ChildItem -Path "$path" -Recurse -File -Filter "*.$typeOfFile"}
4 { Get-ChildItem -Path "$path" -Recurse }
7 {
$driveLetter = Read-Host "Enter the letter you want to assign to the network share (e.g., S):"
$source = Read-Host "Enter the network share path (e.g., \\memvmappshare\c$\Program Files):"
New-PSDrive -Name "$driveLetter" -PSProvider "FileSystem" -Root "$source" -Persist
Write-Host "Network share $source has been mapped to drive $driveLetter`\" -ForegroundColor Green
}
}
$result

