@echo off
set NAS_SERVER=G:\Administrativ\it-lmg\INSTALL2023
set FONT_DIR=C:\Windows\Fonts
set TEMP_DIR=%temp%
set LOGON_SERVER=%logonserver%
set USERNAME=%USERNAME%
set COMPUTERNAME=%COMPUTERNAME%
set HOMEPATH=%HOMEPATH%
set OS=%OS%

REM Disable hibernation
runas /user:lappdomain\admin.damotic "cmd /c powercfg.exe /hibernate off"

REM Copy desktop files
xcopy "%NAS_SERVER%\#lebureau\*.*" "C:\Users\%USERNAME%\Desktop" /Y /E

REM Log time status
w32tm /query /status > hours.log

REM Log PC details
echo %LOGON_SERVER% %USERNAME% avec %COMPUTERNAME% %HOMEPATH% sous:%OS% > pc.log

REM Windows Update
wuauclt.exe /updatenow

REM Setup, mapping, SMB1, purge temp, NetFx3
CMD /c "%NAS_SERVER%\#antivirusLMG\Fsecure\Client\fscs-15.11.1138.msi"
CMD /c "del /q /f /s %TEMP_DIR%\*"
CMD /c "del /s /q C:\windows\temp\*"
powercfg.exe /hibernate off
powercfg.exe -h off
DISM /Online /Enable-Feature /FeatureName:NetFx3 /All
PowerShell.exe -command "Enable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol -NoRestart"
xcopy "%NAS_SERVER%\Polices\*.*" "%FONT_DIR%\" /Y /E

REM Netskope installation
CMD /c "%NAS_SERVER%\#applicationsDIVERS\NSClient_108.0.0.1555.msi token=BtQ0lqBIn8uBPThsc5Qf host=addon-lappgroup.de.goskope.com mode=peruserconfig /l*v %PUBLIC%\nscinstall.log"

REM F-Secure installation
CMD /c "%NAS_SERVER%\#antivirusLMG\Fsecure\Client\F-SecureNetworkInstaller-AV.exe"
pause
CMD /c "%NAS_SERVER%\#applicationsDIVERS\TeamViewer_Host_Setup.exe"
pause

REM Addons installation
xcopy "%NAS_SERVER%\Polices\*.*" "%FONT_DIR%\" /Y /E"
CMD /c "%NAS_SERVER%\#applicationsDIVERS\ChromeSetup.exe"
pause
CMD /c "%NAS_SERVER%\#applicationsDIVERS\Doko-phone.exe"
pause
CMD /c "%NAS_SERVER%\#applicationsDIVERS\JavaSetup8u351.exe"
pause
CMD /c "%NAS_SERVER%\#applicationsDIVERS\Firefox Setup 112.0.1.exe"
pause
msiexec.exe /i "%NAS_SERVER%\#applicationsDIVERS\vlc-3.0.18-win64.msi"
pause
CMD /c "%NAS_SERVER%\#applicationsDIVERS\Advanced_IP_Scanner_2.5.4594.1.exe"
pause
CMD /c "%NAS_SERVER%\#applicationsDIVERS\7z2201-x64.exe"
pause
CMD /c "%NAS_SERVER%\#applicationsDIVERS\pdfcreator_27579844948158094.exe"
pause
msiexec.exe /i "%NAS_SERVER%\#applicationsDIVERS\Dialog.msi"
pause
CMD /c "%NAS_SERVER%\#applicationsDIVERS\KeePass-2.52-Setup.exe"
pause
CMD /c "%NAS_SERVER%\#applicationsDIVERS\#BIGIFX\BES-10.0.7.52\Client\Client-10.0.7.52.exe"F
pause
CMD /c "%NAS_SERVER%\#applicationsDIVERS\VirtualBox-7.0.8-156879-Win.exe"
pause
CMD /c "%NAS_SERVER%\#applicationsDIVERS\Xmind-for-Windows-x64bit-22.11.3656.exe"
pause

REM VPN installation
msiexec.exe /i "%NAS_SERVER%\#VPNandSECURITY\E86.50_CheckPointVPN.msi"

REM GPU update
gpupdate /force

REM Lotus Notes installation
CMD /c "%NAS_SERVER%\#lotusNOTES\NOTES_CLIENT_9.0.1_WIN_FR.exe"
pause
CMD /c "%NAS_SERVER%\#lotusNOTES\notes901FP7_win.exe"

REM Office 365 installation
start CMD /K "del /q /f /s %TEMP_DIR%\*"
start CMD /K "del /s /q C:\windows\temp\*"
CMD /c DISM /Online /Enable-Feature /FeatureName:NetFx3 /All
CMD /c DISM /Online /Enable-Feature /All /FeatureName:SMB1Protocol
CMD /c net use o: \\fr-gr-app03\SEFlex\Program\ /user:\lappdomain\admin.damotic
CMD /c net use p: \\fr-gr-fs01\Groups$\ /user:\lappdomain\admin.damotic
CMD /c net use T: \\fr-gr-fs01 /user:\lappdomain\admin.damotic
CMD /c "%NAS_SERVER%\#antivirusLMG\Fsecure\Client\F-SecureNetworkInstaller-AV.exe"
c:
cd\
md O365-for-Admins
xcopy "%NAS_SERVER%\#Office\O365-for-Admins\*.*" "C:\O365-for-Admins\" /Y /E
xcopy "%NAS_SERVER%\Polices\*.*" "%FONT_DIR%\" /Y /E
CMD /c "C:\O365-for-Admins\Install-Office-365-Languages-French-Englisch\Install-O365-Fr-EN.xml"

REM Desktop info installation
c:
CD \
MD DESKTOP
xcopy "%NAS_SERVER%\#applicationsDIVERS\DESKTOP\*.*" C:\DESKTOP /Y /E

REM BIGFIX installation
CMD /c "%NAS_SERVER%\#BIGIFX\BES-10.0.7.52\Client\Client-10.0.7.52.exe"

REM SAP installation
runas /user:lappmuller\lda "CMD /c DISM /Online /Enable-Feature /FeatureName:NetFx3 /All"
runas /user:lappmuller\lda "CMD /c DISM /Online /Enable-Feature /All /FeatureName:SMB1Protocol"
CMD /c "NAS_SERVER\#SAP\B1_SHF\Client.x64\setup.exe"
pause
CMD /c "NAS_SERVER\#SAP\B1_SHF\HANA_Client_v2_SPS05\hdbsetup.exe"

REM Printer setup
cscript C:\Windows\SysWOW64\Printing_Admin_Scripts\fr-FR\prnport.vbs -a -r IP_192.168.100.210 -h 192.168.1.210 -o raw -n 9100
cscript C:\Windows\SysWOW64\Printing_Admin_Scripts\fr-FR\prnport.vbs -a -r IP_192.168.100.215 -h 192.168.1.215 -o raw -n 9100
cscript C:\Windows\SysWOW64\Printing_Admin_Scripts\fr-FR\prnport.vbs -a -r IP_192.168.100.216 -h 192.168.1.216 -o raw -n 9100
cscript C:\Windows\SysWOW64\Printing_Admin_Scripts\fr-FR\prnport.vbs -a -r IP_192.168.100.219 -h 192.168.1.216 -o raw -n 9100
cscript C:\Windows\SysWOW64\Printing_Admin_Scripts\fr-FR\prnport.vbs -a -r IP_192.168.100.222 -h 192.168.1.216 -o raw -n 9100

REM Grant ADDONS/SAP
iCACLS "C:\Program Files\sap\SAP Business One\AddOns" /Grant "Tout le monde":F /T 

REM Reboot to reinstall Windows 10
shutdown /r /o /f /t 00

REM Copy all source files to C:\ITlmg
c:
cd \
MD ITlmg
xcopy "%NAS_SERVER%\#lebureau\*.*" "C:\user\desktop\user" /Y /E

REM Serial Windows
START /wait CMD /c clef_win
pause

REM IP Analysis
PING www.google.com
PATHPING www.google.com
TRACERT www.google.com
IPCONFIG /all
NSLOOKUP www.google.com
NETSTAT 
ROUTE PRINT
pause

REM Reboot directly into BIOS
shutdown /r /fw /f /t 0

REM Join domain
Add-Computer -DomainName lappmuller.local -Credential (Get-Credential) -OUPath "OU=Computers,DC=lappmuller,DC=local" -Restart

echo Installation complete!
pause
