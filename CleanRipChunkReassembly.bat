@echo off
title CleanRip ISO Chunk Reassembly
setlocal enabledelayedexpansion

echo                                                                           Exit^^
echo.
echo ===============================================================================
echo This is a Wii game reassembly tool build by Graham Harper. Use this to
echo reassemble your ISO chunks after they're ripped echo by echo CleanRip
echo version 2.0.0 by emu_kidid. echo This will reassemble up to 16 chunks.
echo 				VERSION 1.0
echo ===============================================================================
echo.
echo.

set /p GAMENAME=Wii game file to reassemble (don't include .part0.iso): 
echo Searching for %GAMENAME%.part0.iso


if exist %GAMENAME%.part0.iso (set CHUNKCOUNT=1) else (goto filenotfound)
if exist %GAMENAME%.part1.iso (set CHUNKCOUNT=2) else (goto noassemblyrequired)
for /L %%i in (2,1,15) do (if exist %GAMENAME%.part%%i.iso (set /A CHUNKCOUNT=%%i+1) else (goto finish))


:finish
echo.
echo.
echo This will reassemble %CHUNKCOUNT% chunks and name the final product %GAMENAME%_Complete.iso
echo Exit now to cancel.
pause
echo.
echo.
set "COPYLIST=%GAMENAME%.part0.iso"
echo Please wait while the file is built. This may take a minute.
for /L %%i in (1,1,%CHUNKCOUNT%) do (set "COPYLIST=!COPYLIST! + %GAMENAME%.part%%i.iso")
copy /B %COPYLIST% %GAMENAME%_Complete.iso
echo.
echo.
echo All done^^!
pause
exit

:filenotfound
echo.
echo.
echo The specified Wii game could not be found in your current directory.
echo Please make sure your ISO chunks are in the same folder as this batch file.
pause
exit

:noassemblyrequired
echo.
echo.
echo Only 1 chunk detected^^! Please check if there are chunks missing.
pause
exit
