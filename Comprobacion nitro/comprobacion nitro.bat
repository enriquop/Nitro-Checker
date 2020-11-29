@echo off
REM CREATED BY: Enriquop
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------   
cls
title Comprobacion Nitro
:start
cls
color 7
ECHO.
type "%~dp0logo.bat"
echo -
ECHO 1. Comprobacion nitro Program Files (x86)
ECHO 2. Comprobacion nitro Program Files
ECHO 3. Borrar nitro
echo 4. Borrar carpetas restantes
echo -
set /p choice= Selecciona una opcion: 
rem if not '%choice%'=='' set choice=%choice:~0;1% ( don`t use this command, because it takes only first digit in the case you type more digits. After that for example choice 23455666 is choice 2 and you get "bye"
if '%choice%'=='' ECHO "%choice%" is not valid please try again
if '%choice%'=='1' goto hello
if '%choice%'=='2' goto bye
if '%choice%'=='3' goto test
if '%choice%'=='4' goto test2

ECHO.
goto start
:hello
cls
If EXIST "C:\Program Files (x86)\Nitro" (
    color 4
    type "error.bat"
    ECHO Nitro en directorio x86 esta instalado
) ELSE (
    color a
    type "success.bat"
    echo Directorio de nitro Program Files x86 no existe
)
pause
color 7
goto start
:bye
cls
If EXIST "C:\Program Files\Nitro" (
    color 4
    type "%~dp0error.bat"
    ECHO Nitro en directorio Program Files esta instalado
) ELSE (
    color a
    type "%~dp0success.bat"
    ECHO Nitro en directorio Program Files no esta instalado
)
pause
color 7
goto start

:test
wmic product where vendor="Nitro" call uninstall
pause
goto start

:test2
If EXIST "C:\Program Files\Nitro" (
    cls
    type "%~dp0error.bat"
    ECHO Borrando carpeta nitro...
    timeout 5 > nul
    @RD /S /Q "C:\Program Files\Nitro"
    cls
    type "%~dp0success.bat"
    echo -
    echo La carpeta Nitro se a borrado correctamente!!!
    echo -
    pause
    goto start
    
) ELSE (
    cls
    color a
    type "%~dp0success.bat"
    ECHO la carpeta nitro no esta en el directorio
    pause
    goto start
)
pause
color 7

echo Se han borrado las carpetas restantes
pause
goto start
:end
pause
exit


REM Created BY: Thedoc/Enriquop
