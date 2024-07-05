echo off
runas /user:lappmuller\administrateur "cmd /c powercfg.exe /hibernate off"
xcopy \\192.168.100.94\it-lmg\Source\INSTALL2023\#lebureau\*.* C:\user\desktop\user /Y /E
w32tm /query /status > hours.log
Echo %logonserver% %USERNAME% avec %COMPUTERNAME% %HOMEPATH% sous:%OS% > pc.log
pause

COLOR cf
CLS

title DAMOTIC.FR V9 MARS/2024 Tél: +33(0)783765036 administrateur Lmg@Olfex$83.com LMGSAPB1H01 4000

:menu
COLOR cf
echo ############################################################################################################
Echo .
echo .		Choix installation: DAMOTIC.FR +33783765036 LMGSAPB1H01 4000 Mai 2023 V4
Echo 		%logonserver% %USERNAME% avec %COMPUTERNAME% %HOMEPATH% sous:%OS% 
echo ############################################################################################################
echo 	00) Lire la documentation pour l'installation 
echo 	0) WINDOWS UPDATE OS
echo 	1) Setup, mapping, SMB1, purge temp,NetFx3
echo 	2) Netskope, installation depuis NAS 100.94
echo 	3) FSECURE, installation depuis NAS 100.94
echo 	4) Addons Mai 2023, installation depuis NAS 100.94
echo 	5) VPN, installation depuis NAS 100.94
echo 	6) GPUupdate force injection
echo 	7) Lotus NOTES V9 et Patch, installation depuis NAS 100.94   									REM Ne plus faire 
echo 	8) Solidedge2D, installation depuis NAS 100.94
echo 	9) Office 365, installation depuis NAS 100.94
echo 	10) DESKTOPinfo 
echo 	11) BIGFIX, installation depuis NAS 100.94                                                      REM Ne pas faire 
echo 	12) SAP V10.3, installation depuis NAS 100.94
echo 	13) Imprimantes															                        REM Les minimas sont au dessus
echo 	14) Grant ADDONS/SAP
echo 	15) Reboot reinstal Windows 10
echo 	16) Copie tout le dossier source sur C:\ITlmg
echo 	17) Serial Windows
echo 	96) TOUT sur IP du Poste
echo 	97) REBOOT DIRECTEMENT DANS LE BIOS
echo 	98) Insertion domaine lappmuller.local
echo 	99) INSTALL COMPLETE
echo ############################################################################################################
Echo .
echo .		Pour installer un pc avec toutes les options, faire le 99
Echo .
echo ############################################################################################################
set /p op=Choix : 
if "%op%"=="00" goto documentation
if "%op%"=="0" goto update
if "%op%"=="1" goto setup
if "%op%"=="2" goto NETSKOPE
if "%op%"=="3" goto FSECURE
if "%op%"=="4" goto ADDONS
if "%op%"=="5" goto VPN
if "%op%"=="6" goto GPU
if "%op%"=="7" goto LOTUS
if "%op%"=="8" goto SOLID2D
if "%op%"=="9" goto 365
if "%op%"=="10" goto DESKTOPi
if "%op%"=="11" goto BIGFIX
if "%op%"=="12" goto SAP
if "%op%"=="13" goto prt
if "%op%"=="14" goto grantaddons
if "%op%"=="15" goto initOS
if "%op%"=="16" goto copyall
if "%op%"=="17" goto serialwin
if "%op%"=="96" goto switching
if "%op%"=="97" goto BIOS
if "%op%"=="98" goto ADDdomain
if "%op%"=="99" goto installCOMPLETE
echo Quelle option:
goto menu


:documentation
echo off 
echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\      Documentation    \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ok
Echo .
Echo .
Echo .
echo .              00) Lecture de la documentation
Echo . 
Echo . 
Echo . 
@echo off
explorer https://www.overleaf.com/project/665d8b689844da415cc4ab44
COLOR fc
goto menu

:update
echo off
echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ ok
Echo .
Echo .
echo .		Vous avez lancé 0) WINDOWS UPDATE OS, mise à jour du pc avant de basculer dans le domaine
Echo .
Echo .
echo ============================================================================================================
COLOR fc
wuauclt.exe /updatenow
goto menu

:setup
echo off
COLOR fc
Echo on
echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ ok
Echo .
Echo .
echo .		Vous avez lancé 1) Setup, mapping, SMB1, purge temp,NetFx3
Echo .
Echo .
echo =================================    FIN.  =================================================================

CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#antivirusLMG\Fsecure\Client\fscs-15.11.1138.msi"
Pause

CMD /K "del /q /f /s %temp%\*"
CMD /K "del /s /q C:\windows\temp\*
powercfg.exe /hibernate off
powercfg.exe -h off

pause
DISM /Online /Enable-Feature /FeatureName:NetFx3 /All

PowerShell.exe -command "Enable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol -NoRestart"

xcopy \\192.168.100.94\it-lmg\Source\INSTALL2023\Polices\*.* C:\Windows\Fonts\ /Y /E

echo ============================================================================================================
Echo .
Echo .
echo .		Vous avez lancé 1) Setup, mapping, SMB1, purge temp,NetFx3
Echo .
Echo .
echo ////////////////////////////////    FIN.  //////////////////////////////////////////////////////////////////
echo off
goto menu

:NETSKOPE
echo off
COLOR fc
echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ ok
Echo .
Echo .
echo .		Vous avez lancé 2) Netskope, installation depuis NAS 100.94
Echo .			
Echo .		1- Copier le dossier sur le C: du PC
Echo .		2- Puis lancer la commande
Echo .		msiexec /I NSClient_96.1.1.1019.msi installmode=IDP mode=peruserconfig tenant=lappgroup domain=de.goskope.com
Echo .		Pour les serveurs ou les machines non Windows ou toutes les machines qui ne peuvent pas gérer l'authentification proxy,
Echo .		vous pouvez continuer à utiliser les mêmes anciens IP et port proxy comme toujours : 10.20.30.40:8081
Echo .		The login is for the Active Directory user - the same user that is required, for example, for Microsoft Teams and other Office 365 applications.
Echo .		This is only required once during enrollment.
Echo .		The disadvantage of the 10.20.30.40 proxy is that it is
Echo .		a) not available outside the corporate network - it always requires a VPN connection to Stuttgart
Echo .		b) also, when user don't use proxy authentication, it is very difficult to track down any issues that might be happening
Echo .		c) finally, without user authentication, it is almost impossible to get accurate reports about traffic volume etc.
Echo .
echo ============================================================================================================

CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\NSClient_108.0.0.1555.msi token=BtQ0lqBIn8uBPThsc5Qf host=addon-lappgroup.de.goskope.com mode=peruserconfig /l*v %PUBLIC%\nscinstall.log"

echo ============================================================================================================
Echo .
Echo .
echo .		Vous avez lancé 2) Netskope, installation depuis NAS 100.94
Echo .
Echo .
echo ////////////////////////////////    FIN.  //////////////////////////////////////////////////////////////////
goto menu

:FSECURE
echo off
COLOR fc
echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ ok
Echo .
Echo .
echo .		Vous avez lancé 3) FSECURE, installation depuis NAS 100.94                                  REM mettre dans la doc ce que c'est fsécure en détails
Echo .
Echo .
echo ============================================================================================================
CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#antivirusLMG\Fsecure\Client\F-SecureNetworkInstaller-AV.exe"
pause
CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\TeamViewer_Host_Setup.exe"
pause
echo ============================================================================================================
REM echo Vous avez lancé 10															                    REM Why 10 ?
echo .       Vous avez lancé 3) FSECURE, instalaltion depuis NAS 100.94									REM Modif
echo ////////////////////////////////    FIN.  //////////////////////////////////////////////////////////////////
goto menu

:ADDONS
echo off
COLOR fc
echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ ok
Echo .
Echo .
echo .		Vous avez lancé 4) Addons Mai 2023, installation depuis NAS 100.94
Echo .
Echo .
echo ============================================================================================================
Echo on
xcopy \\192.168.100.94\it-lmg\Source\INSTALL2023\Polices\*.* C:\Windows\Fonts\ /Y /E

Pause
CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\ChromeSetup.exe"
Pause
CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\Doko-phone.exe"
Pause
CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\TeamViewer_Host_Setup.exe"
Pause
CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\JavaSetup8u351.exe"
Pause
CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\Firefox Setup 112.0.1.exe"
Pause
msiexec.exe /i "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\vlc-3.0.18-win64.msi"
Pause
CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\Advanced_IP_Scanner_2.5.4594.1.exe"
Pause
CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\7z2201-x64.exe"
Pause
CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\pdfcreator_27579844948158094.exe"
Pause
msiexec.exe /i "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\Dialog.msi"
Pause
CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\ganttproject-3.1.3100.exe"
Pause
CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\KeePass-2.52-Setup.exe"
Pause
CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\#BIGIFX\BES-10.0.7.52\Client\Client-10.0.7.52.exe"
Pause
CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\Creative_Cloud_Set-Up.exe.exe"
Pause
CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\rufus-3.14.exe"
Pause
CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\Solid_Edge_Web_Installer_2023.exe"
Pause
CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\VirtualBox-7.0.8-156879-Win.exe"
Pause
CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\Xmind-for-Windows-x64bit-22.11.3656.exe"

xcopy \\192.168.100.94\it-lmg\Source\INSTALL2023\Polices\*.* C:\Windows\Fonts\ /Y /E

echo ============================================================================================================
Echo .
Echo .
echo .		Vous avez lancé 4) Addons Mai 2023, installation depuis NAS 100.94
Echo .
Echo .
echo ////////////////////////////////    FIN.  //////////////////////////////////////////////////////////////////
Echo off
goto menu

:VPN
echo off
COLOR fc
echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ ?
Echo .
Echo .
echo .		Vous avez lancé 5) VPN, installation depuis NAS 100.94
Echo .
Echo .
echo ============================================================================================================
CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#antivirusLMG\Fsecure\Client\F-SecureNetworkInstaller-AV.exe"
pause
CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\TeamViewer_Host_Setup.exe"
pause
msiexec.exe /i "\\192.168.100.94\it-lmg\Source\INSTALL2023\#VPNansSECURITY\E86.50_CheckPointVPN.msi"
echo ============================================================================================================
Echo .
Echo .
echo .		Vous avez lancé 5) VPN, installation depuis NAS 100.94
Echo .
Echo .
echo ////////////////////////////////    FIN.  //////////////////////////////////////////////////////////////////
goto menu



:GPU
echo off
echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ ok
Echo .
Echo .
echo .		Vous avez lancé 6) GPUupdate force injection
Echo .
Echo .
echo ////////////////////////////////    FIN.  //////////////////////////////////////////////////////////////////
COLOR fc
gpupdate /force
goto menu



:LOTUS
echo off
COLOR fc
echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ ok
Echo .
Echo .
echo .		Vous avez lancé 7 Lotus NOTES V9 et Patch, installation depuis NAS 100.94
Echo .
Echo .
echo ============================================================================================================
echo on
CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#lotusNOTES\NOTES_CLIENT_9.0.1_WIN_FR.exe"
pause
CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#lotusNOTES\notes901FP7_win.exe"
Echo off																                                    REM Mettre ending 
goto menu



:SOLID2D
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
CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#solidEDGE\Solid_Edge_Free2D_2019.exe"
echo off

:sedge3d
echo off
COLOR fc
echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
echo .		Vous avez lancé 8) Solid Edge version 3D sous licence LAPPMULLER
echo ============================================================================================================
CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#solidEDGE\Solid_Edge_DVD_FRENCH_2019.exe"
echo off 

:segde3s
echo off
COLOR fc
echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
echo .		Vous avez lancé 8) Solid Edge version Simulation
echo ============================================================================================================
CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#solidEDGE\Solid_Edge_2023_2210.exe"
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
goto menu

:365
echo off
COLOR fc
echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ ok
Echo .
Echo .
echo .		Vous avez lancé 9) Office 365, installation depuis NAS 100.94
Echo .
Echo .
echo ============================================================================================================

start CMD /K "del /q /f /s %temp%\*"
start CMD /K "del /s /q C:\windows\temp\*"

CMD /c DISM /Online /Enable-Feature /FeatureName:NetFx3 /All
CMD /c DISM /Online /Enable-Feature /All /FeatureName:SMB1Protocol

CMD /c net use o: \\LMGAPPS01\SEFlex\Program\ /user:\lappmuller\administrateur%Lmg@Olfex$83.com
CMD /c net use p: \\lmgfile01\data\ /user:\lappmuller\administrateur%Lmg@Olfex$83.com
CMD /c net use T: \\lmgfile01 /user:\lappmuller\administrateur%Lmg@Olfex$83.com

CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#antivirusLMG\Fsecure\Client\F-SecureNetworkInstaller-AV.exe"
CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\TeamViewer_Host_Setup.exe"

c:
cd\
md O365-for-Admins

xcopy \\192.168.100.94\it-lmg\Source\INSTALL2023\#Office\O365-for-Admins\*.* c:\O365-for-Admins\ /Y /E
xcopy \\192.168.100.94\it-lmg\Source\INSTALL2023\Polices\*.* C:\Windows\Fonts\ /Y /E

echo xcopy \\192.168.100.94\it-lmg\Source\INSTALL2023\#lebureau\*.* C:\Users\%user%\Desktop /Y /E

CMD /c "C:\O365-for-Admins\Install-Office-365-Languages-French-Englisch\Install-O365-Fr-EN.xml"

echo ============================================================================================================
Echo .
Echo .
echo .		Vous avez lancé 9) Office 365, installation depuis NAS 100.94
Echo .
Echo .
echo ////////////////////////////////    FIN.  //////////////////////////////////////////////////////////////////
goto menu



:DESKTOPi
echo off
COLOR fc
echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Echo .
Echo .
echo .		Vous avez lancé 9) DESKTOP info 											REM Modif 
Echo .
Echo .
echo ============================================================================================================
c:
CD \
MD DESKTOP
xcopy \\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\DESKTOP\*.* C:\DESKTOP /Y /E
echo ============================================================================================================
Echo .
Echo .
echo .		Vous avez lancé 9) DESKTOP info												REM Modif 
Echo .
Echo .
echo ////////////////////////////////    FIN.  //////////////////////////////////////////////////////////////////
goto menu



:BIGFIX
echo off
COLOR fc
echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Echo .
Echo .
echo .		Vous avez lancé 11) BIGFIX, installation depuis NAS 100.94								REM Modif
Echo .
Echo .
echo ============================================================================================================
CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#BIGIFX\BES-10.0.7.52\Client\Client-10.0.7.52.exe"
echo ============================================================================================================
echo .		Vous avez lancé 11)  BIGFIX, installation depuis NAS 100.94								REM Modif
echo ////////////////////////////////    FIN.  //////////////////////////////////////////////////////////////////
goto menu



:SAP
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

CMD /c "\\192.168.100.145\B1_SHF\Client.x64\setup.exe"
Pause
CMD /c "\\192.168.100.145\B1_SHF\HANA_Client_v2_SPS05\hdbsetup.exe"
echo ECHO Paramétres SAP LMGSAPB1H01 4000
pause

echo ============================================================================================================
echo . 		Vous avez lancé 12) Installation SAP											                            REM Modif
echo ////////////////////////////////    FIN.  //////////////////////////////////////////////////////////////////
goto menu



:prt
echo off
COLOR fc
echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Echo .
Echo .
echo .		Vous avez lancé 13) Imprimantes 											                                REM Modif
Echo .
Echo .
echo ============================================================================================================

cscript C:\Windows\SysWOW64\Printing_Admin_Scripts\fr-FR\prnport.vbs -a -r IP_192.168.100.210 -h 192.168.1.210 -o raw -n 9100
cscript C:\Windows\SysWOW64\Printing_Admin_Scripts\fr-FR\prnport.vbs -a -r IP_192.168.100.215 -h 192.168.1.215 -o raw -n 9100
cscript C:\Windows\SysWOW64\Printing_Admin_Scripts\fr-FR\prnport.vbs -a -r IP_192.168.100.216 -h 192.168.1.216 -o raw -n 9100
cscript C:\Windows\SysWOW64\Printing_Admin_Scripts\fr-FR\prnport.vbs -a -r IP_192.168.100.219 -h 192.168.1.216 -o raw -n 9100
cscript C:\Windows\SysWOW64\Printing_Admin_Scripts\fr-FR\prnport.vbs -a -r IP_192.168.100.222 -h 192.168.1.216 -o raw -n 9100

cmd /c \\192.168.100.94\it-lmg\Source\INSTALL2023\Polices\C062003T.TTF
cmd /c \\192.168.100.94\it-lmg\Source\INSTALL2023\Polices\C062006T.TTF
cmd /c \\192.168.100.94\it-lmg\Source\INSTALL2023\Polices\C063003T.TTF
cmd /c \\192.168.100.94\it-lmg\Source\INSTALL2023\Polices\C063006T.TTF
cmd /c \\192.168.100.94\it-lmg\Source\INSTALL2023\Polices\CorporateSTOT-Bol.otf
cmd /c \\192.168.100.94\it-lmg\Source\INSTALL2023\Polices\CorporateSTOT-Reg.otf

echo ============================================================================================================
echo . 		Vous avez lancé 13) Imprimantes 											                                REM Modif
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
goto menu



:initOS
echo off
COLOR fc
echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Echo .
Echo .
echo .	Vous avez lancé 15) Reboot reinstal Windows 10											                        REM Modif
Echo .
Echo .
echo ////////////////////////////////    FIN.  //////////////////////////////////////////////////////////////////
shutdown /r /o /f /t 00
goto menu



:copyall
echo off
COLOR fc
echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Echo .
Echo .
echo .		Vous avez lancé 16) Copie tout le dossier source sur C:\ITlmg				                                REM Modif
Echo .
Echo .
echo ////////////////////////////////    FIN.  //////////////////////////////////////////////////////////////////
c:
cd \
MD ITlmg
xcopy \\192.168.100.94\it-lmg\Source\INSTALL2023\*.* C:\ITlmg /Y /E
goto menu



:serialwin
echo off
COLOR fc
echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Echo .
Echo .
echo .		Vous avez lancé 17) Serial Windows
Echo .
Echo .
echo ////////////////////////////////    FIN.  //////////////////////////////////////////////////////////////////
START /wait CMD /c clef_win
pause
goto menu

:teamviewer
::Quick HOST
::https://get.teamviewer.com/proteo
::Version Host Mac
::https://get.teamviewer.com/6j6hueb
::Full PC
::https://get.teamviewer.com/6db6ts3
goto menu

:switching
echo off
echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Echo .
Echo . 	96) Analyses IP sur Poste
Echo .
echo ============================================================================================================
Echo on
PING www.google.com
PATHPING www.google.com
TRACERT www.google.com
IPCONFIG /all
NSLOOKUP www.google.com
NETSTAT 
ROUTE PRINT
Pause
echo off
echo ============================================================================================================
Echo .
Echo .	fin 96)  Analyses IP													                                        REM Modif
Echo .
echo ////////////////////////////////    FIN.  //////////////////////////////////////////////////////////////////
goto menu



:BIOS
echo off
echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Echo .
Echo . 	97) REBOOT DIRECTEMENT DANS LE BIOS
Echo .
echo ============================================================================================================
echo on
shutdown /r /fw /f /t 0
goto menu



:ADDdomain
echo off
echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Echo .
Echo . Insertion domaine lappmuller.local
Echo . computer-name : nom de l’ordinateur à  joindre au domaine
Echo . /domain : nom du domaine Active Directory
Echo . /ud : Compte du domaine autorisé à joindre un ordinateur
Echo . /pd : * permet la saisie du mot de passe ou entrer le mot de passe en clair.
Echo . /OU : il est possible d’indiquer l’OU
Echo . /reboot : redémarrage du poste après la jonction
Echo .
echo ////////////////////////////////    FIN.  //////////////////////////////////////////////////////////////////
Add-Computer lappmuller administrateur@Lmg@Olfex$83.com
Pause
goto menu




:exit
@exit