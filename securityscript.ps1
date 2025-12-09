
#//////////////////////////////////////////////////////////////////////////////////////////////////////////

#This will close any open instances of Chrome and Edge
Get-Process -Name chrome -ErrorAction SilentlyContinue | Stop-Process -ErrorAction SilentlyContinue
Get-Process -Name msedge -ErrorAction SilentlyContinue | Stop-Process -ErrorAction SilentlyContinue
#//////////////////////////////////////////////////////////////////////////////////////////////////////////

#This will remove cookies and cache for Chrome and Edge
# Define the path to the Edge cookies file for the current user
$edgeCookiesPath = "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cookies"


# Clear the Edge cookies file
Remove-Item -Path $edgeCookiesPath -Force -ErrorAction SilentlyContinue

Write-Host "Microsoft Edge cookies cleared successfully."

#deleting Chrome cookies

# Define the path to the Cookies file for the default profile
$cookiesFilePath = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cookies"

# Check if the Cookies file exists and then remove it
if (Test-Path -Path $cookiesFilePath) {
    Remove-Item -Path $cookiesFilePath -Force -ErrorAction SilentlyContinue
    Write-Host "Google Chrome cookies cleared for the default profile."
} else {
    Write-Host "Cookies file not found for the default profile."
}
#//////////////////////////////////////////////////////////////////////////////////////////////////////////
#clearing all site permissions for Edge and Chrome
# Define the path to the Edge permissions file for the current user
$edgePermissionsPath = "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Permissions" 

# Clear the Edge permissions file
Remove-Item -Path $edgePermissionsPath -Recurse -Force -ErrorAction SilentlyContinue

Write-Host "Microsoft Edge permissions cleared successfully."
# Define the path to the Chrome permissions file for the current user
$chromePermissionsPath = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Permissions"

# Clear the Chrome permissions file
Remove-Item -Path $chromePermissionsPath -Recurse -Force -ErrorAction SilentlyContinue

Write-Host "Google Chrome permissions cleared for the default profile." 

#/////////////////////////////////////////////////////////////////////////////////////////////////////////

#clearing cache for Edge and Chrome
# Define the path to the Edge cache directory for the current user
$edgeCachePath = "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cache"

# Clear the Edge cache directory
Remove-Item -Path $edgeCachePath -Recurse -Force -ErrorAction SilentlyContinue

Write-Host "Microsoft Edge cache cleared successfully."

# Define the path to the Chrome cache directory for the current user
$chromeCachePath = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cache"

# Clear the Chrome cache directory
Remove-Item -Path $chromeCachePath -Recurse -Force -ErrorAction SilentlyContinue

Write-Host "Google Chrome cache cleared for the default profile."
#//////////////////////////////////////////////////////////////////////////////////////////////////////////

#clear sessions data for Edge and Chrome
# Define the path to the Edge sessions file for the current user        

$edgeSessionsPath = "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Sessions"

# Clear the Edge sessions file
Remove-Item -Path $edgeSessionsPath -Recurse -Force -ErrorAction Silently

Continue
Write-Host "Microsoft Edge sessions cleared successfully."
# Define the path to the Chrome sessions file for the current user
$chromeSessionsPath = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Sessions"
# Clear the Chrome sessions file
Remove-Item -Path $chromeSessionsPath -Recurse -Force -ErrorAction Silently
Continue
Write-Host "Google Chrome sessions cleared for the default profile."
#//////////////////////////////////////////////////////////////////////////////////////////////////////////

#clear credentials for Edge and Chrome

# Add paths to the current PATH environment variable (session only)
$env:PATH += ";C:\Windows\System32;C:\Windows"

# Get list of stored credentials
$listFile = "$env:TEMP\List.txt"
$tokensFile = "$env:TEMP\Tokens.txt"

cmdkey.exe /list | Out-File -FilePath $listFile -Encoding ASCII

# Extract only lines with "Target"
Select-String -Path $listFile -Pattern "Target" | ForEach-Object { $_.Line } |
    Out-File -FilePath $tokensFile -Encoding ASCII

# Parse and delete credentials
Get-Content $tokensFile | ForEach-Object {
    $parts = $_ -split '\s+'
    if ($parts.Length -ge 2) {
        $target = $parts[1]
        cmdkey.exe /delete:$target
    }
}

# Delete all files from temp folder (forcefully, quietly)
Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue

# Exit with last exit code
exit $LASTEXITCODE
#//////////////////////////////////////////////////////////////////////////////////////////////////////////


Write-Host "Killing Edge"
Write-Host "Killing Chrome..."
Stop-Process -Name "chrome" -Force -ErrorAction SilentlyContinue
Stop-Process -Name "msedge" -Force -ErrorAction SilentlyContinue
Write-Host ""
Write-Host "Taskkill exited with code:" $LASTEXITCODE

Write-Host ""
Write-Host "Removing Chromium cache from all users..."

Get-ChildItem "C:\Users" -Directory | ForEach-Object {
    $chromeCache = Join-Path $_.FullName "AppData\Local\Google\Chrome\User Data\Default\Cache"
    $edgeCache   = Join-Path $_.FullName "AppData\Local\Microsoft\Edge\User Data\Default\Cache"

    if (Test-Path $chromeCache) {
        Remove-Item $chromeCache -Recurse -Force -ErrorAction SilentlyContinue
    }
    if (Test-Path $edgeCache) {
        Remove-Item $edgeCache -Recurse -Force -ErrorAction SilentlyContinue
    }
}

Write-Host ""
Write-Host "Clear cache exited with code:" $LASTEXITCODE

exit 0
