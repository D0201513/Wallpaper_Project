param (
  [string]$ImagePath = "C:\Users\Public\Pictures\wallpaper.png"
)

$code = @"
using System;
using System.Runtime.InteropServices;
public class Wallpaper {
  [DllImport("user32.dll", SetLastError = true)]
  public static extern bool SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@
Add-Type $code

$imgPath = "C:\Users\Public\Pictures\wallpaper.png"
$result = [Wallpaper]::SystemParametersInfo(20, 0, $imgPath, 3)

if (-not $result) {
  Write-Error "Failed to set wallpaper. Error code: $([Runtime.InteropServices.Marshal]::GetLastWin32Error())"
} else {
  Write-Host "Wallpaper set successfully."
}
