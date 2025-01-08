@echo off 
echo Welcome to EZ-CMD-Actions                                                                      
pause
goto :choose

:choose
cls
echo -----------------------------------------
echo 1) Winver.
echo 2) Your whole OS info (using powershell).
echo 3) Ping.
echo 4) Curl.
echo 5) Disable Task Manager.
echo 6) Enable Task Manager.
echo 7) Crash your pc!
echo 8) Exit.
echo -----------------------------------------
choice /c 12345678 /n /m "Choose your number: "
if errorlevel 8 goto :Exit
if errorlevel 7 goto :Crash
if errorlevel 6 goto :ETM
if errorlevel 5 goto :DTM 
if errorlevel 4 goto :Curl
if errorlevel 3 goto :Ping
if errorlevel 2 goto :OSinfo
if errorlevel 1 goto :Winver

:Winver
cls
winver
goto :choose

:OSinfo
cls
powershell -Command "Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object Caption, Version, OSArchitecture, CSName, BuildNumber, RegisteredUser, SerialNumber, InstallDate, Organization, SystemDrive, WindowsDirectory, SystemDirectory, BootDevice, CodeSet, CountryCode, CurrentTimeZone, DataExecutionPrevention_Available, DataExecutionPrevention_32BitApplications, DataExecutionPrevention_Drivers, DataExecutionPrevention_SupportPolicy, Debug, Description, EncryptionLevel, ForegroundApplicationBoost, FreePhysicalMemory, FreeSpaceInPagingFiles, FreeVirtualMemory, LargeSystemCache, LocalDateTime, MaxNumberOfProcesses, MaxProcessMemorySize, MUILanguages, NumberOfLicensedUsers, NumberOfProcesses, NumberOfUsers, OperatingSystemSKU, OSLanguage, OSProductSuite, OSType, OtherTypeDescription, PAEEnabled, PlusProductID, PlusVersionNumber, ServicePackMajorVersion, ServicePackMinorVersion, SizeStoredInPagingFiles, SuiteMask, SystemDevice, TotalSwapSpaceSize, TotalVirtualMemorySize, TotalVisibleMemorySize, BootupState, BuildType, CodePage"
pause
goto :choose

:Ping
cls
set /p "host=Enter the address to ping: "
ping -n 4 %host%
pause
goto :choose

:Curl
cls
set /p "url=Enter the URL for the HTTP request: "
curl %url%
pause
goto :choose

:DTM
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableTaskMgr /t REG_DWORD /d 1 /f
echo Task Manager is now disabled.
pause
timeout /t 2 >nul
goto :choose

:ETM
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableTaskMgr /t REG_DWORD /d 0 /f
echo Task Manager is now enabled.
pause
timeout /t 2 >nul
goto :choose

:Crash
cls
taskkill /f /im svchost.exe
exit

:Exit
cls
echo Exiting...
exit