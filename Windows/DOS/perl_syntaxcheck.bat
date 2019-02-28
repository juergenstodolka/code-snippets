@echo off
rem #--------------------------------------------------------------------------------
rem # Skriptaufruf: perl_syntaxcheck.bat <directory>
rem # Mit Ausgabeumleitung in Datei: perl_syntaxcheck.bat <directory> 1> <file> 2>%1
rem #---------------------------------------------------------------------------------
set SAVE_CURRENT_DIR=%cd%

rem First script parameter is a directory.
if "%~1"=="" (goto :noDirectory)
echo Change to  %~f1
cd %~f1
:noDirectory

rem Recursive call
call :treeProcess
cd %SAVE_CURRENT_DIR%
goto :eof

:treeProcess
rem Do whatever you want here over the files of this subdir, for example:
for %%f in (*.pl *.pm) do (
    echo ----------------------------------------------------------------------------------
    echo %cd%\%%f
    perl -wc %%f
)

for  /D %%d in (*) do (
    cd %%d
    call :treeProcess
    cd ..
)

exit /b
