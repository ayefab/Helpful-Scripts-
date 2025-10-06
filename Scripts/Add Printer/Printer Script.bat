@echo off 
set /P PrinterName="Enter the name of your printer: "
echo You entered: %PrinterName%

echo 
 rundll32 printui.dll, PrintUIEntry /in /n\\lihprint04\%PrinterName% 
pause

