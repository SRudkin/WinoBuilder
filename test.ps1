 Write-Host "Don't Go Yet, We need some Input from you" -ForegroundColor Red

$input = Read-Host "Type the users first initial, users last name - asset tag, I.E srudkin-14297"
 Write-Host "Renaming Computer" -ForegroundColor Black
Rename-Computer -newname $input
#Policy Enguine

Write-Host "Firefox Installation" -ForegroundColor Black
# Silent Install Firefox 
# Download URL: https://download.mozilla.org/?product=firefox-latest&os=win64&lang=en-US

# Path for the workdir
$workdir = "c:\installer\"

# Check if work directory exists if not create it

If (Test-Path -Path $workdir -PathType Container)
{ Write-Host "$workdir already exists" -ForegroundColor Red}
ELSE
{ New-Item -Path $workdir  -ItemType directory }

# Download the installer
Write-Host "Downloading Installer" -ForegroundColor Black
$source = "https://download.mozilla.org/?product=firefox-latest&os=win64&lang=en-US"
$destination = "$workdir\firefox.exe"

# Check if Invoke-Webrequest exists otherwise execute WebClient

if (Get-Command 'Invoke-Webrequest')
{
     Invoke-WebRequest $source -OutFile $destination
}
else
{
    $WebClient = New-Object System.Net.WebClient
    $webclient.DownloadFile($source, $destination)
}

# Start the installation
Write-Host "Starting Installation" -ForegroundColor Black
Start-Process -FilePath "$workdir\firefox.exe" -ArgumentList "/S"

# Wait XX Seconds for the installation to finish
Write-Host "Waiting for installation to finish" -ForegroundColor Black
Start-Sleep -s 35

# Remove the installer
Write-Host "deleting installer" -ForegroundColor Black
rm -Force $workdir\firefox*

Write-Host "adding bookmarks" -ForegroundColor Black
New-Item -Path "C:\Program Files\Mozilla Firefox\distribution"  -ItemType directory
#creating distruition folder
Move-Item D:\setup\policies.json -Destination "C:\Program Files\Mozilla Firefox\distribution"

Write-Host "Setting up bookmarks" -ForegroundColor Black



#Silent Install Viscosity

Write-Host "Begining installation for Viscocity" -ForegroundColor Black
Write-Host "Installating Viscocity" -ForegroundColor Black
Start-Process -FilePath "D:\setup\viscoscity.exe" /silent
# Wait XX Seconds for the installation to finish

Start-Sleep -s 60
Write-Host "Install Vidyo" -ForegroundColor Black
#Silent Install Vidyo 


Write-Host "Downloading Installer" -ForegroundColor Black
#Download URL= https://v.mozilla.com/upload/VidyoDesktopAdminInstaller-win32-TAG_VD_3_6_14_0003.exe
# Path for the workdir
$workdir = "c:\installer\"

# Check if work directory exists if not create it

If (Test-Path -Path $workdir -PathType Container)
{ Write-Host "$workdir already exists" -ForegroundColor Red}
ELSE
{ New-Item -Path $workdir  -ItemType directory }

# Download the installer

$source = "https://v.mozilla.com/upload/VidyoDesktopAdminInstaller-win32-TAG_VD_3_6_14_0003.exe" 
$destination = "$workdir\vidyo.exe"

# Check if Invoke-Webrequest exists otherwise execute WebClient

if (Get-Command 'Invoke-Webrequest')
{
     Invoke-WebRequest $source -OutFile $destination
}
else
{
    $WebClient = New-Object System.Net.WebClient
    $webclient.DownloadFile($source, $destination)
}

# Start the installation
Write-Host "Starting Installation" -ForegroundColor Black
Start-Process -FilePath "$workdir\vidyo.exe" -ArgumentList "/S"
# Wait XX Seconds for the installation to finish

Start-Sleep -s 60

# Remove the installer
Write-Host "deleting installer" -ForegroundColor Black
rm -Force $workdir\vidyo*

#Set Desktop background to Dino

#Create function to set wallpaper 
Write-Host "Setting Desktop Background" -ForegroundColor Black
Function Set-WallPaper($Value)

{

 Set-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name wallpaper -value $value

 rundll32.exe user32.dll, UpdatePerUserSystemParameters

}


set-WallPaper -value D:\setup\dino.png

#install crashplan
Start-Process -FilePath "D:\setup\crashplan.exe" -ArgumentList "/passive"
# Wait XX Seconds for the installation to finish

Start-Sleep -s 60

#Set screen lockout
Set-ItemProperty -Path "hkcu:control panel\desktop" -Name "ScreenSaveActive" -Value 1
#Set Screen saver lockout timer
Set-ItemProperty -Path "hkcu:control panel\desktop" -Name "ScreenSaveTimeOut" -value 1200
#Set Screen saver image
Set-ItemProperty -Path "hkcu:control panel\desktop" -Name "SCRNSAVE.EXE" -Value ""
#Set secure lockout
Set-ItemProperty -Path "hkcu:control panel\desktop" -Name "ScreenSaverIsSecure" -Value 1

	
Enable-Bitlocker -MountPoint c: -UsedSpaceOnly -SkipHardwareTest -RecoveryKeyPath "D:\" -RecoveryKeyProtector

#Save Recovery Key to desktop
(Get-BitLockerVolume -MountPoint C).KeyProtector > $env:UserProfile\Desktop\BitLocker_Recovery_Key.txt


