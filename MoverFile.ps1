Write-Output "File copier and mover script"

$path = readhost "Enter the source file path:"
$destination = read-host "Enter the destination path:"

# Move only all the files
Move-Item -Path "$path\*.*" -Destination "$destination"