$imgPath = "C:\Users\Public\Pictures\wallpaper.png"

$code = @"
using System;
using System.Runtime.InteropServices;

public static class NativeMethods {
    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@

Add-Type -TypeDefinition $code
[NativeMethods]::SystemParametersInfo(20, 0, $imgPath, 3)

$taskName = "SetWallpaperTask"
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-WindowStyle Hidden -Command `"Add-Type -TypeDefinition '$code'; [NativeMethods]::SystemParametersInfo(20, 0, '$imgPath', 3)`""
$principal = New-ScheduledTaskPrincipal -UserId "$env:USERNAME" -LogonType Interactive -RunLevel Highest
$task = New-ScheduledTask -Action $action -Principal $principal
Register-ScheduledTask -TaskName $taskName -InputObject $task -Force
Start-ScheduledTask -TaskName $taskName
Start-Sleep -Seconds 5
Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
