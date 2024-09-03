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
echo 	1) Atelier
echo 	2) Bureau d'étude
echo 	3) Commerce
echo 	4) Comptabilité 
echo 	5) Connectique
echo 	6) Controle
echo 	7) Industrie
echo 	8) Logistique
echo 	9) Maintenance
echo 	10) Marketing
echo 	11) Projets
echo 	12) Qualité
echo 	13) Ressources Humaines
echo 	14) Supply Chain

echo ############################################################################################################
Echo .
echo .		Choisissez le service pour faire l'installation de cet ordinateur
Echo .
echo ############################################################################################################
set /p op=Choix : 
if "%op%"=="1" CALL Service/INSTALL_ALL_atelier.bat
if "%op%"=="2" CALL Service/INSTALL_ALL_be.bat
if "%op%"=="3" CALL Service/INSTALL_ALL_commerce.bat
if "%op%"=="4" CALL Service/INSTALL_ALL_compta.bat
if "%op%"=="5" CALL Service/INSTALL_ALL_connectique.bat
if "%op%"=="6" CALL Service/INSTALL_ALL_controle.bat
if "%op%"=="7" CALL Service/INSTALL_ALL_industrie.bat
if "%op%"=="8" CALL Service/INSTALL_ALL_logistique.bat
if "%op%"=="9" CALL Service/INSTALL_ALL_maintenance.bat
if "%op%"=="10" CALL Service/INSTALL_ALL_marketing.bat
if "%op%"=="11" CALL Service/INSTALL_ALL_projets.bat
if "%op%"=="12" CALL Service/INSTALL_ALL_qualite.bat
if "%op%"=="13" CALL Service/INSTALL_ALL_rh.bat
if "%op%"=="14" CALL Service/INSTALL_ALL_supply.bat
echo Quelle option:
goto menu





:exit
@exit