@echo off
pushd "%~dp0"
title PC Cleanup Tool - cleans temps, gpupdate /force, runs chkdsk, sfc /scannow and Defrag c: (for mechanical HDDs only)
del /f/s/q *.vbs
del /f/s/q *.txt


REM ------------------------------------
REM	DISPLAY NORTHWELL SCRIPT BANNER
REM ------------------------------------

echo  ======================================================================================================================
echo      TITLE:  PC Cleanup Tool
echo.
echo      DATE:   October 18th, 2019
echo.
echo.     AUTHOR: John Giallanza - Desktop Support Remote East
echo  ======================================================================================================================
echo.
echo.
echo.
echo      NOTE:  YOU MUST COPY THIS DOWN TO THE DESKTOP AND RUN ON THE C DRIVE.
echo.
echo      PLEASE CLOSE THE SCRIPT NOW IF THIS WAS NOT DONE.
echo.
echo.
echo.

pause
cls


::	Checks for C drive
 
echo Checking to see if this is being run from the C drive...
echo.
echo %cd% | findstr /i "c:"
IF NOT %ERRORLEVEL%==0 ( 
	color 0c
	echo You must run this from the C Drive, %username%!!
	echo.
	timeout 10 > nul
	exit
) ELSE (
	echo.
	echo Kudos for following directions, %username%!  proceeding...
	timeout 5 > nul
)



ECHO  Wiping TEMP folder...
erase "%TEMP%\*.*" /f /s /q
for /D %%i in ("%TEMP%\*") do RD /S /Q "%%i"
echo.

ECHO  Wiping TMP folder...
erase "%TMP%\*.*" /f /s /q
for /D %%i in ("%TMP%\*") do RD /S /Q "%%i"
echo.

ECHO  Wiping 'Allusers' TEMP folder...
erase "%ALLUSERSPROFILE%\TEMP\*.*" /f /s /q
for /D %%i in ("%ALLUSERSPROFILE%\TEMP\*") do RD /S /Q "%%i"
echo.

ECHO  Wiping Temporary Internet Files...
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 8
echo.

ECHO Clear non-locked files from what is typically c:\Windows\Temp
erase "%SystemRoot%\TEMP\*.*" /f /s /q
for /D %%i in ("%SystemRoot%\TEMP\*") do RD /S /Q "%%i"

ECHO Clear IE temp folder of extraneous non-locked files
erase "%LOCALAPPDATA%\Microsoft\Windows\Tempor~1\*.*" /f /s /q
for /D %%i in ("%LOCALAPPDATA%\Microsoft\Windows\Tempor~1\*") do RD /S /Q "%%i"

ECHO Clear all non-locked files from .Net caches for all users
for /f "delims=" %%i in ('dir C:\Users\* /b /ad') do RD /S /Q "c:\users\%%i\AppData\Local\Apps\2.0\"

ECHO Clear Appdata\Local\Temp for ALL Users...
FOR /f "tokens=*" %%G in ('dir /ad /b "c:\users"') DO (	
	IF EXIST "C:\Users\%%G\AppData\Local\Temp" (
		DEL /Q /s "C:\Users\%%G\AppData\Local\Temp"
	)
)


ECHO  Updating Group Policy...
echo n | gpupdate /force
echo.


ECHO  Scheduling CHKDSK (Check Disk) to run on reboot...
echo y | chkdsk /f c:
echo.


ECHO  Running System File Checker (SFC /SCANNOW)...
sfc /scannow
echo.


ECHO  Determing if %COMPUTERNAME% has an HDD or SSD...
powershell “get-physicaldisk | format-table -autosize” > "%~dp0drive.txt"
findstr /i "SSD" drive.txt
IF %ERRORLEVEL%==0 (
	echo.
	echo SSD detected, skipping defrag
	goto :CLEANUP
) else (
	echo HDD detected, starting defrag
)


echo 
ECHO  Running defrag of the C drive...
defrag c:
echo.


ECHO  Setting user profile cleanup policy to 90 days...
reg add HKLM\Software\Policies\Microsoft\Windows\System /v CleanupProfiles /t REG_DWORD /d 90


:CLEANUP

REM	LOGIC TO DETERMINE IF RUN VIA PoSH OR RUN LOCALLY

dir | findstr /i "c:\temp\PS_Install"
IF %ERRORLEVEL%==0 (
	del /f/s/q c:\temp\PS_Install
	goto :EOF
) ELSE (
	cls
	title PC Cleanup Completed
	echo PC Cleanup completed.  Press any key and the PC will reboot in 5 minutes.
	pause > nul
	del /f/s/q "%~dp0*.vbs"
	del /f/s/q "%~dp0drive.txt"
	del /f/s/q "PC Cleanup Tool.cmd"
	shutdown -r -t 300
	goto :EOF
)


:EOF