if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
Write-Host "Running disk cleanup"
Cleanmgr.exe /VERYLOWDISK
Write-Host "When disk clean up is complete. Press any key to continue ..."
$host.UI.RawUI.ReadKey()
Write-Host "Running SFC scan"
sfc /scannow
Write-Host "Performing GPO Update"
gpupdate /force
Write-Host "Updating Windows"
$ScriptDir = Split-Path $script:MyInvocation.MyCommand.Path
robocopy $ScriptDir C:\WINDOWS\system32\
Write-Host "Updating Windows"
cscript.exe .\ZTIWindowsUpdate.wsf 
Write-Host "Restarting computer in 5s"
Start-Sleep -s 5
shutdown /r /f
