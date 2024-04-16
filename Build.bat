@echo off

:: Required paths for this project
set "inputfolder=SeaMonkey"
set "outputexe=%inputfolder%-SFX64.exe"

:: Optional path to ResourceHacker.exe, this path will be checked first but standard paths will be checked if not found
set "ResourceHackerPath=D:\example\Resource Hacker\ResourceHacker.exe"

:main
echo.
echo.
echo Steps:
echo 1. Debloat %inputfolder%
echo 2. Pack %inputfolder% to %inputfolder%.7z
echo 3. Create %outputexe% using SFX
echo 4. Add icon and fix manifest (requires Resource Hacker)
echo.  
echo F. Do steps 1,2,3,4 automatically
echo.  
choice /C 1234F /N /M "Build Option:"
goto buildinput%errorlevel%

:buildinput1
cls
call :debloat
goto main
:buildinput2
cls
call :pack
goto main
:buildinput3
cls
call :makesfx
goto main
:buildinput4
cls
call :resourcehack
goto main
:buildinput5
cls
call :debloat
call :pack
call :makesfx
call :resourcehack
goto done


:debloat
echo.
cd %inputfolder% || exit /b
rmdir /s /q defaults
rmdir /s /q extensions
rmdir /s /q fonts
rmdir /s /q isp
rmdir /s /q uninstall
rmdir /s /q TempProfile
del /q updater.exe
del /q crashreporter.exe
del /q minidump-analyzer.exe
del /q d3dcompiler_47.dll
del /q install.log
del /q blocklist.xml
del /q omni.ja.tmp* >nul
..\7za64.exe -tzip d omni.ja defaults/blocklists
..\7za64.exe -tzip d omni.ja chrome/comm/content/communicator/places
..\7za64.exe -tzip d omni.ja chrome/devtools
..\7za64.exe -tzip d omni.ja hyphenation
..\7za64.exe -tzip d omni.ja modules/addons
..\7za64.exe -tzip d omni.ja modules/commonjs
..\7za64.exe -tzip d omni.ja chrome/toolkit/content/global/license.html
..\7za64.exe -tzip d omni.ja chrome/toolkit/content/global/bindings/autocomplete.xml
del /q omni.ja.tmp* >nul
cd ..
echo.
xcopy /-y TempProfile\ %inputfolder%\TempProfile\
echo.
echo Debloat done and profile added, please check the output for errors before continuing.
echo.  
exit /B 0


:pack
echo.
del /q %inputfolder%.7z
7za64.exe a -mx=9 %inputfolder%.7z %inputfolder% run.bat
del /q exe.txt
echo.
echo Packing done, please check the output for errors before continuing.
echo.  
exit /B 0


:packfast
echo.
del /q %inputfolder%.7z
7za64.exe a -mx=1 %inputfolder%.7z %inputfolder% run.bat
del /q exe.txt
echo.
echo Packing done, please check the output for errors before continuing.
echo.  
exit /B 0


:makesfx
echo. 
del /q %outputexe%
copy /Y /b 7zS264.sfx + %inputfolder%.7z %outputexe%
echo.
echo SFX step done, please check the output for errors before continuing.
echo. 
exit /B 0


:resourcehack
echo.
set "RH1=Resource Hacker\ResourceHacker.exe"
set "RH2=%ProgramFiles(x86)%\Resource Hacker\ResourceHacker.exe"
set "RH3=%ProgramFiles%\Resource Hacker\ResourceHacker.exe"

echo.
echo Looking for Resource Hacker.exe in the following order...
echo   %ResourceHackerPath%
echo   %RH1%
echo   %RH2%
echo   %RH3%
echo.
if exist "%ResourceHackerPath%" ( 
    set "rhpath=%ResourceHackerPath%"
    goto runrh
)
if exist "%RH1%" ( 
    set "rhpath=%RH1%"
    goto runrh
)
if exist "%RH2%" ( 
    set "rhpath=%RH2%"
    goto runrh
)
if exist "%RH3%" (
    set "rhpath=%RH3%"
    goto runrh
)
echo ResourceHacker.exe not found. 
pause
exit

:runrh
echo Found: %rhpath%
REM "%rhpath%" -script ResourceHackerScript.txt
"%rhpath%" -open "%outputexe%" -save "%outputexe%" -action addoverwrite -resource icon.ico -mask ICONGROUP,MAINICON,0 -log CONSOLE
"%rhpath%" -open "%outputexe%" -save "%outputexe%" -action addoverwrite -resource Manifest.txt -mask Manifest,1, -log CONSOLE
echo.
echo Icon and manifest updated, please check the output for errors before continuing.
echo. 
exit /B 0


:done
echo.
pause
exit