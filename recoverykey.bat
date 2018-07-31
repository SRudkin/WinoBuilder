echo off
title Firefox windows configuration tool

echo Running powershell script with administrative rights

PowerShell -NoProfile -NoExit -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File " "D:\setup\copykey.ps1" " ' -Verb RunAs} " 

Echo Done! 
