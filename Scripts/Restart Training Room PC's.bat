@Echo off

cls
echo **********************************************************************
echo.
echo. Restart Training Room Computers Remotely
echo.
echo **********************************************************************
pause

shutdown /r /m \\WAM400JEN045
shutdown /r /m \\WAM400JEN048
shutdown /r /m \\WW10AM400JEN001
shutdown /r /m \\WW10AM400JEN002
shutdown /r /m \\WW10AM400JEN005
shutdown /r /m \\WW10AM400JEN007
shutdown /r /m \\WW10AM400JEN009
shutdown /r /m \\WW10AM400JEN020
shutdown /r /m \\WW10AM400JEN023
shutdown /r /m \\WW10AM400JEN025
shutdown /r /m \\WW10AM400JEN028
shutdown /r /m \\WW10AM400JEN031
shutdown /r /m \\WW10AM400JEN038
shutdown /r /m \\WW10AM400JEN039
shutdown /r /m \\WW10AM400JEN040
shutdown /r /m \\WW10AM400JEN041

IF %ERRORLEVEL% == 0 GOTO :SUCCESS
IF %ERRORLEVEL% ==1 GOTO :FAILEDRESTART

:SUCCESS
ECHO
ECHO
COLOR 0a
ECHO.********************************************
ECHO.
ECHO.COMPUTERS WERE RESTARTED SUCCESSFULLY!
ECHO.
ECHO.********************************************
GOTO :END

:FAILEDRESTART
ECHO.
COLOR 0c
ECHO.************************************
ECHO.
ECHO.MSG FAILED TO RESTART
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