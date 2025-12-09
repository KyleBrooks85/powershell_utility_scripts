$entry = Read-Host "Enter 'move' to move files, 'compressor' to compress files from a network share, or 'networkshare' to map a network share:, deletedrive"

switch ($entry) {
"move"{ 
    
    $path = read-host "Enter the source file path:"
$destination = read-host "Enter the destination path:"

# Move only ll the files
Move-Item -Path "$path\*.*" -Destination "$destination" 
Write-Output "Files moved from $path to $destination successfully." -ForegroundColor Green

}
"compressor" { 
    Compress-Archive -Path "$driveLetter\*" -DestinationPath "C:\Backup\ProgramFilesBackup.zip" -Force
Write-Host "Backup completed and saved to C:\Backup\ProgramFilesBackup.zip" -ForegroundColor Green


}
"networkshare" {
    
    # This scrips map network share and compresses the contents into a zip file
$driveLetter = Read-Host "Enter the letter you want to assign to the network share (e.g., S):"
$source = Read-Host "Enter the network share path (e.g., \\memvmappshare\c$\Program Files):"
New-PSDrive -Name "$driveLetter" -PSProvider "FileSystem" -Root "$source" -Persist
Write-Host "Network share $source has been mapped to drive $driveLetter`\" -ForegroundColor Green
 


}
"deletedrive"{
$driveLetter = Read-Host "Enter the drive letter of the network share you want to remove (e.g., S):"
Remove-PSDrive -Name "$driveLetter"  
Write-Output "Network drive $driveLetter has been removed." -ForegroundColor Green

}
default { "not available" } # Optional
}