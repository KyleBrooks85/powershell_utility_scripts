$AppsList = "Microsoft.Bing" , "Microsoft.BingFinance" , "Microsoft.BingMaps" , "Microsoft.BingNews"`
            , "Microsoft.BingSports" , "Microsoft.BingTravel" , "Microsoft.BingWeather" , "Microsoft.Camera"`
            , "microsoft.microsoftskydrive" , "Microsoft.Reader" , "microsoft.windowscommunicationsapps"`
            , "microsoft.windowsphotos" , "Microsoft.XboxLIVEGames" , "Microsoft.ZuneMusic"`
            , "Microsoft.ZuneVideo" , "Microsoft.Media.PlayReadyClient" , "Microsoft.MicrosoftOfficeHub" , "Microsoft.Office.OneNote"

ForEach ($App in $AppsList)
{
    $PackageFullName = (Get-AppxPackage $App).PackageFullName
    if ((Get-AppxPackage $App).PackageFullName)
    {
        Write-Host "Removing Package: $App"
        remove-AppxProvisionedPackage -online -packagename $PackageFullName
        remove-AppxPackage -package $PackageFullName
    }
    else
    {
        Write-Host "Unable to find package: $App"
    }
}

Get-AppxPackage *officehub* | Remove-AppxPackage
#testing