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
[Wallpaper]::SystemParametersInfo(20, 0, $imgPath, 3)
