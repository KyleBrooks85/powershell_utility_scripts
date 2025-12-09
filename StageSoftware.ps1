$curDir = Get-Location
$sourcePath = "$curDir\Source"
$sourceCheck = "$curDir\Source\chromeHomepageChange.ps1"
$sourceCheck2 = "$curDir\Source\Run.bat"
$logName = (Get-Date -Format "yyyyMMdd_HHmmss") + "_StageLog" + ".txt"
$logFile = "$curDir\$logName"
$logSuccessName = (Get-Date -Format "yyyyMMdd_HHmmss") + "_StageSuccess" + ".txt"
$logFileSuccess = "$curDir\$logSuccessName"
$computers = Read-Host "Enter the filename of the computers you want to target (ex Targets.txt)"
$computersListPath = "$curDir\$computers"
$destinationPath = "C$\Temp\"
$destinationPathCheck = "C$\Temp\Source\"

$computers = Get-Content -Path $computersListPath

foreach ($computer in $computers) {
    try {
        $remoteDestination = "\\$computer\$destinationPath"
		$remoteDestinationCheck = "\\$computer\$destinationPathCheck"

        if (-not (Test-Path -Path $remoteDestination)) {
            New-Item -Path $remoteDestination -ItemType Directory -Force
			New-Item -Path $remoteDestinationCheck -ItemType Directory -Force
        }

        Copy-Item -Path $sourcePath -Destination $remoteDestination -Recurse -Force
		Copy-Item -Path $sourceCheck -Destination $remoteDestinationCheck -Force
		Copy-Item -Path $sourceCheck2 -Destination $remoteDestinationCheck -Force

        $date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        Add-Content -Path $logFile -Value "$date - Success: $sourcePath copied to $remoteDestination"
		Add-Content -Path $logFile -Value "$date - Success: $sourceCheck copied to $remoteDestinationCheck"
		Add-Content -Path $logFile -Value "$date - Success: $sourceCheck2 copied to $remoteDestinationCheck"
        Add-Content -Path $logFileSuccess -Value "$computer"
        Write-Host "Successfully copied to $computer"
    }
    catch {
        $date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        Add-Content -Path $logFile -Value "$date - Failure: $sourcePath failed to copy to $remoteDestination"
		Add-Content -Path $logFile -Value "$date - Failure: $sourceCheck failed to copy to $remoteDestinationCheck"
		Add-Content -Path $logFile -Value "$date - Failure: $sourceCheck2 failed to copy to $remoteDestinationCheck"
        Write-Host "Failed to copy to $computer"
    }
}