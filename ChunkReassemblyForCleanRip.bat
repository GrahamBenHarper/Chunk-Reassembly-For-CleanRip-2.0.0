@echo off
title Chunk Reassembly for CleanRip 2.0.0 ISO Files
setlocal enabledelayedexpansion

echo                                                                           Exit^^
echo.
echo ===============================================================================
echo This is a Wii game reassembly tool build by Graham Harper. Use this to
echo reassemble your ISO chunks after they're ripped echo by echo CleanRip
echo version 2.0.0 by emu_kidid. echo This will reassemble up to 16 chunks.
echo 				VERSION 1.01
echo ===============================================================================
echo If you like this program, please let me and your friends know. If you'd like to
echo modify this, please give original credit to me when you use it.
echo ===============================================================================
echo.
echo.

:: Prompt the user for a file name
set /p GAMENAME=Wii game file to reassemble (don't include .part0.iso): 

:: Search for the file, and then count the part.iso files to determine how many chunks there are
echo Searching for %GAMENAME%.part0.iso . . .
if exist %GAMENAME%.part0.iso (set CHUNKCOUNT=1) else (goto filenotfound)
if exist %GAMENAME%.part1.iso (set CHUNKCOUNT=2) else (goto noassemblyrequired)
for /L %%i in (2,1,15) do (if exist %GAMENAME%.part%%i.iso (set /A CHUNKCOUNT=%%i+1) else (goto finish))



:: If the file is located, chunks have been counted, and they're ready to combine
:finish
echo.
echo.
echo This will reassemble %CHUNKCOUNT% chunks and name the final product %GAMENAME%_Complete.iso
echo Exit now to cancel.
:: Give the user a chance to exit out if he/she decides not to reassemble the file or if the incorrect number of chunks are found
pause
echo.
echo.
:: Start concatenating all of the file names together in a loop so that the copy command can be used
set "COPYLIST=%GAMENAME%.part0.iso"
for /L %%i in (1,1,%CHUNKCOUNT%) do (set "COPYLIST=!COPYLIST! + %GAMENAME%.part%%i.iso")
echo Please wait while the file is built. This may take a minute.
:: No need for error checking since the files obviously exist and the user wishes to combine them
copy /B %COPYLIST% %GAMENAME%_Complete.iso
echo.
echo.
echo All done^^!
echo Please make sure to quality check your reassembled ISO file before deleting chunks
pause
exit



:: If the file name .part0.iso isn't found in the directory on the first lookup
:filenotfound
echo.
echo.
echo The specified Wii game could not be found in your current directory.
echo Please make sure your ISO chunks are in the same folder as this batch file.
pause
exit



:: If all that is found is file name .part0.iso and no other chunks are found
:noassemblyrequired
echo.
echo.
echo Only 1 chunk detected^^! Please check if there are chunks missing.
pause
exit