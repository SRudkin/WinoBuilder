echo off
title Firefox windows configuration tool

echo Running powershell script with administrative rights

PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File " "D:\setup\WinoBuilder.ps1" " ' -Verb RunAs} " 

Echo Done! 
