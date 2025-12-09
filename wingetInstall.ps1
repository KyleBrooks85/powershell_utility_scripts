
$path = @("C:\Users\kbrooks-de\Downloads\DesktopAppInstaller_Dependencies\x64\Microsoft.WindowsAppRuntime.1.8_8000.616.304.0_x64.appx",
"C:\Users\kbrooks-de\Downloads\DesktopAppInstaller_Dependencies\x64\Microsoft.VCLibs.140.00.UWPDesktop_14.0.33728.0_x64.appx",
"C:\Users\kbrooks-de\Downloads\DesktopAppInstaller_Dependencies\x64\Microsoft.VCLibs.140.00_14.0.33519.0_x64.appx",
"C:\Users\kbrooks-de\Downloads\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
)
foreach ($path in $path) {

Add-AppxProvisionedPackage -Online -PackagePath "$path" -skiplicense
}

Start-Sleep -Seconds 10

Remove-AppPackage -Package "Microsoft.DesktopAppInstaller_8wekyb3d8bbwe"