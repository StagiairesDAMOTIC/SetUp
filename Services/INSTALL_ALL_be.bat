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
CMD /c "%NAS_SERVER%\#applicationsDIVERS\#BIGIFX\BES-10.0.7.52\Client\Client-10.0.7.52.exe"
pause

REM VPN installation
msiexec.exe /i "%NAS_SERVER%\#VPNandSECURITY\E86.50_CheckPointVPN.msi"

REM GPU update
gpupdate /force


REM Office 365 installation
start CMD /K "del /q /f /s %TEMP_DIR%\*"
start CMD /K "del /s /q C:\windows\temp\*"
CMD /c DISM /Online /Enable-Feature /FeatureName:NetFx3 /All
CMD /c DISM /Online /Enable-Feature /All /FeatureName:SMB1Protocol
CMD /c net use o: \\fr-gr-app03\SEFlex\Program\ /user:\lappdomain\admin.damotic
CMD /c net use p: \\fr-gr-fs01\Groups$\ /user:\lappdomain\admin.damotic
CMD /c net use T: \\fr-gr-fs01 /user:\lappdomain\admin.damotic
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
CMD /c "%NAS_SERVER%\#SAP\B1_SHF\Client.x64\setup.exe"
pause
CMD /c "%NAS_SERVER%\#SAP\B1_SHF\HANA_Client_v2_SPS05\hdbsetup.exe"

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

pause
echo off
COLOR fc
echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ ok
Echo .
Echo .
echo .		Vous avez lancé 8) Solid Edge ATTENTION A LA VERSION 								REM mettre un choix en sélection pour better executable
echo . 					1) Solid Edge version 2D gratuite pour tout le monde 
echo . 					2) Solid Edge version 3D sous licence LAPPMULLER
echo . 					3) Solid Edge version Simulation
Echo .
Echo .
set /p se=Choix : 
if "%se%"=="1" goto sedge2d
if "%se%"=="2" goto sedge3d
if "%se%"=="3" goto sedge3s
echo Quelle option:
goto menu

:sedge2d
echo off
COLOR fc
echo ============================================================================================================
echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
echo .		Vous avez lancé 8) Solid Edge version 2D gratuite pour tout le monde 
echo ============================================================================================================
CMD /c "%NAS_SERVER%\#solidEDGE\Solid_Edge_Free2D_2019.exe"
echo off

:sedge3d
echo off
COLOR fc
echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
echo .		Vous avez lancé 8) Solid Edge version 3D sous licence LAPPMULLER
echo ============================================================================================================
CMD /c "%NAS_SERVER%\#solidEDGE\Solid_Edge_DVD_FRENCH_2019.exe"
echo off 

:segde3s
echo off
COLOR fc
echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
echo .		Vous avez lancé 8) Solid Edge version Simulation
echo ============================================================================================================
CMD /c "%NAS_SERVER%\#solidEDGE\Solid_Edge_2023_2210.exe"
echo ////////////////////////////////    FIN.  //////////////////////////////////////////////////////////////////
Echo off
goto menu


:Voici vos Liens de téléchargements, ainsi que votre nouveau fichier licence comme convenu au téléphone.
:DVD 2019 : https://www.dropbox.com/s/kd3vcap5l1l99o7/Solid_Edge_DVD_FRENCH_2019.exe?dl=0
:MP 7 2019 : https://www.dropbox.com/s/983afkkanggxbuf/Solid_Edge_MSI_MP7.exe?dl=0

:Consignes concernant le serveur :
:1 – Désinstaller votre gestionnaire de licence ST9
:2 – Installer le gestionnaire 2019 à l’aide du DVD 
:3 – Ouvrir LMTOOLS.exe afin de bien utiliser le nouveau fichier de licence.

:Consignes pour les postes Clients :

:1 – en cas de personnalisation de Solid Edge, utilisez « l’assistant des paramètres et des préférences » afin de capturer vos paramètres.
:2 – Désinstallez l’ancienne version puis installer la nouvelle
:3 – Installer le dernier maintenance pack.
:4 – Déployez vos préférences si l’étape 1 a été faite.

:Guillaume TURATI
:Ingénieur d’application
:support@digicad.fr
:Tél. : 04 72 81 66 66

Pause
CMD /c "%NAS_SERVER%\#applicationsDIVERS\Solid_Edge_Web_Installer_2023.exe"
echo off
COLOR fc
echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ ok
Echo .
Echo .
echo .		Vous avez lancé 12) Installation SAP										        	                    REM Modif
Echo .
Echo .
echo ============================================================================================================
runas /user:lappmuller\lda "CMD /c DISM /Online /Enable-Feature /FeatureName:NetFx3 /All"
runas /user:lappmuller\lda "CMD /c DISM /Online /Enable-Feature /All /FeatureName:SMB1Protocol"

CMD /c "%NAS_SERVER%\#SAP\B1_SHF\Client.x64\setup.exe"
Pause
CMD /c "%NAS_SERVER%\#SAP\B1_SHF\HANA_Client_v2_SPS05\hdbsetup.exe"
echo ECHO Paramétres SAP LMGSAPB1H01 4000
pause

echo ============================================================================================================
echo . 		Vous avez lancé 12) Installation SAP											                            REM Modif
echo ////////////////////////////////    FIN.  //////////////////////////////////////////////////////////////////
goto menu




:grantaddons
echo off
COLOR fc
echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Echo .
Echo .
echo .		Vous avez lancé 14) Grant lecture all ADDONS/SAP									                        REM Modif
Echo .
Echo .
echo ============================================================================================================
iCACLS "C:\Program Files\sap\SAP Business One\AddOns" /Grant "Tout le monde":F /T 
echo ============================================================================================================
echo . 		Vous avez lancé 14) Grant lecture all ADDONS/SAP									                        REM Modif
echo ////////////////////////////////    FIN.  //////////////////////////////////////////////////////////////////

echo Installation complete!
pause
