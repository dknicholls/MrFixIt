if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
Write-Host "Running disk cleanup"
Cleanmgr.exe /VERYLOWDISK
Write-Host "When disk clean up is complete. Press any key to continue ..."
$host.UI.RawUI.ReadKey()
Write-Host "Running SFC scan"
sfc /scannow
Write-Host "Performing GPO Update"
gpupdate /force /boot
Write-Host "Restarting computer in 10s"
Start-Sleep -s 10
shutdown /r /f
