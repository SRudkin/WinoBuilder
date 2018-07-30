
#Save Recovery Key to desktop
(Get-BitLockerVolume -MountPoint C).KeyProtector > $env:UserProfile\Desktop\BitLocker_Recovery_Key.txt

rm -Force C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\recoverykey.bat