# Set the target directory
$directoryPath = "C:\"

# Get all files in the directory and subdirectories
Get-ChildItem -Path $directoryPath -Recurse -File -Force | ForEach-Object {
    # Unblock every file below
    Unblock-File -Path $_.FullName
    Write-Host "Unblocked file:" $_.FullName
}

#unblock all scripts in the specified directory and its subdirectories

