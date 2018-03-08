@echo off
setlocal enabledelayedexpansion

if [%1]==[] goto usage

%~dp0\dumpbin.exe /headers "%1" | findstr /I /C:"machine (x64)" > NUL && (
	echo x64
	exit /B 0
) || (
	%~dp0\dumpbin.exe /headers "%1" | findstr /I /C:"machine (x86)" > NUL && (
		echo x86
		exit /B 1
	) || (
		echo Undetermined - most likely architecture agnostic
		exit /B 2
	)
)

:usage
echo.
echo Usage: %0 ^<fileToCheck^>
echo.
echo        ErrorLevel 0 = x64
echo        ErrorLevel 1 = x86
echo        ErrorLevel 2 = Undetermined - most likely architecture agnostic
exit /B 3