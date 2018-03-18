if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
Write-Host "Running disk cleanup"
Cleanmgr.exe /VERYLOWDISK
Write-Host "When disk clean up is complete. Press any key to continue ..."
$host.UI.RawUI.ReadKey()
Write-Host "Running SFC scan"
sfc /scannow
Write-Host "Updating Windows"
wuauclt /detectnow /updatenow
Write-Host "Performing GPO Update"
gpupdate /force /boot
Write-Host "Restarting computer in 5s"
Start-Sleep -s 5
shutdown /r /f
