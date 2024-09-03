echo off
set NAS_SERVER=G:\Administrativ\it-lmg\INSTALL2023
set FONT_DIR=C:\Windows\Fonts
set TEMP_DIR=%temp%
set LOGON_SERVER=%logonserver%
set USERNAME=%USERNAME%
set COMPUTERNAME=%COMPUTERNAME%
set HOMEPATH=%HOMEPATH%
set OS=%OS%
runas /user:lappdomain\admin.damotic "cmd /c powercfg.exe /hibernate off"
xcopy %NAS_SERVER%\#lebureau\*.* C:\user\desktop\user /Y /E
w32tm /query /status > hours.log
Echo LOGON_SERVER USERNAME avec COMPUTERNAME HOMEPATH sous:OS > pc.log
pause

COLOR cf
CLS

title DAMOTIC.FR V11 JUILLET/2024 Tél: +33(0)783765036 administrateur Lmg@Olfex$83.com LMGSAPB1H01 4000

:menu
COLOR cf
echo ############################################################################################################
Echo .
echo .		Choix installation: DAMOTIC.FR +33783765036 LMGSAPB1H01 4000 Juillet 2024 V11
Echo 		LOGON_SERVER USERNAME avec COMPUTERNAME HOMEPATH sous:OS
echo ############################################################################################################
echo 	0) Comptabilité
echo 	1) Bureau d'étude
echo 	2) RH
echo 	3) Supply Chain 
echo 	4) Connectique
echo 	5) Atelier
echo 	6) Controle
echo 	7) Industrie
echo 	8) Logistique
echo 	9) Maintenance
echo 	10) Marketing
echo 	11) Projets
echo 	12) Qualité
echo 	13) Commerce
echo 	14) 
echo 	15) 
echo 	16) 
echo 	17) 
echo ############################################################################################################
Echo .
echo .		Pour installer un pc avec toutes les options, faire le 99
Echo .
echo ############################################################################################################
set /p op=Choix : 
if "%op%"=="0" goto atelier
if "%op%"=="1" goto be
if "%op%"=="2" goto commerce
if "%op%"=="3" goto compta
if "%op%"=="4" goto connectique
if "%op%"=="5" goto controle
if "%op%"=="6" goto industrie
if "%op%"=="7" goto logistique
if "%op%"=="8" goto maintenance
if "%op%"=="9" goto marketing
if "%op%"=="10" goto projets
if "%op%"=="11" goto qualite
if "%op%"=="12" goto rh
if "%op%"=="13" goto supply
echo Quelle option:
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
xcopy %NAS_SERVER%\Polices\*.* C:\Windows\Fonts\ /Y /E


Pause
CMD /c "%NAS_SERVER%\#applicationsDIVERS\JavaSetup8u351.exe" REM projets

Pause
CMD /c "%NAS_SERVER%\#applicationsDIVERS\ganttproject-3.1.3100.exe" REM projets
Pause

Pause
CMD /c "%NAS_SERVER%\#applicationsDIVERS\Solid_Edge_Web_Installer_2023.exe" REM be indus


msiexec.exe /i "%NAS_SERVER%\#VPNandSECURITY\E86.50_CheckPointVPN.msi"  REM all

REM be
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
goto menu

REM be






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

CMD /c "%NAS_SERVER%\#SAP\B1_SHF\Client.x64\setup.exe"
Pause
CMD /c "%NAS_SERVER%\#SAP\B1_SHF\HANA_Client_v2_SPS05\hdbsetup.exe"
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

cmd /c %NAS_SERVER%\Polices\C062003T.TTF
cmd /c %NAS_SERVER%\Polices\C062006T.TTF
cmd /c %NAS_SERVER%\Polices\C063003T.TTF
cmd /c %NAS_SERVER%\Polices\C063006T.TTF
cmd /c %NAS_SERVER%\Polices\CorporateSTOT-Bol.otf
cmd /c %NAS_SERVER%\Polices\CorporateSTOT-Reg.otf

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
xcopy %NAS_SERVER%\*.* C:\ITlmg /Y /E
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