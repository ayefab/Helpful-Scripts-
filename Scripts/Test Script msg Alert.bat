@echo off
set /P userInput="Enter your target PC: "
pause
echo You entered: %userInput%

echo 
REM - PUSHING THE COMMAND THROUGH WITH THE USER'S INPUT
msg * /SERVER:%userInput% /TIME:55 "Hello World" >NUL	
IF %ERRORLEVEL% == 0 GOTO :SUCCESS
IF %ERRORLEVEL% ==1 GOTO :INSTALLFAILED

:SUCCESS
ECHO
ECHO
COLOR 0a
ECHO.********************************************
ECHO.
ECHO.MSG WAS SENT SUCCESSFULLY!
ECHO.
ECHO.********************************************
GOTO :END

:INSTALLFAILED
ECHO.
COLOR 0c
ECHO.************************************
ECHO.
ECHO.MSG FAILED
ECHO.
ECHO.************************************
GOTO :END

:INVALID_OS
ECHO.
COLOR 0c
ECHO.*******************************************************************
ECHO.
ECHO.Error - THE TARGET PC DOESNT EXIST.
ECHO.
ECHO.*******************************************************************
GOTO :END

:END
ECHO.
PAUSE