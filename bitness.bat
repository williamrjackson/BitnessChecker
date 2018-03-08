@echo off
setlocal enabledelayedexpansion

if [%1]==[] goto usage

set argCount=0
for %%x in (%*) do (
   set /A argCount+=1
   set "argVec[!argCount!]=%%~x"
)

for /L %%i in (1,1,%argCount%) do (
	echo.
	echo !argVec[%%i]!:
	%~dp0\dumpbin.exe /headers "!argVec[%%i]!" | findstr /I /C:"machine (x64)" > NUL && (
		echo x64
		exit /B 0
	) || (
		%~dp0\dumpbin.exe /headers "!argVec[%%i]!" | findstr /I /C:"machine (x86)" > NUL && (
			echo x86
			exit /B 1
		) || (
			echo Undetermined
			exit /B 2
		)
	)
)

:usage
echo.
echo Usage: %0 ^<fileToCheck^>
echo.
echo        ErrorLevel 0 = x64
echo        ErrorLevel 1 = x86
echo        ErrorLevel 2 = Undetermined - probably not applicable
exit /B 3