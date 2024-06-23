	@echo off

	:: Désactivation de l'hibernation
	runas /user:lappmuller\administrateur "cmd /c powercfg.exe /hibernate off"

	:: Copie de fichiers
	xcopy \\192.168.100.94\it-lmg\Source\INSTALL2023\#lebureau\*.* C:\user\desktop\user /Y /E

	:: Sauvegarde du statut de w32tm
	w32tm /query /status > hours.log

	:: Log des informations de l'ordinateur
	Echo %logonserver% %USERNAME% avec %COMPUTERNAME% %HOMEPATH% sous:%OS% > pc.log

	pause

	:: Couleur et effacement de l'écran
	COLOR cf
	CLS

	:: Titre de la fenêtre
	title DAMOTIC.FR V9 MARS/2024 Tél: +33(0)783765036 administrateur Lmg@Olfex$83.com LMGSAPB1H01 4000

	:menu
	COLOR cf
	echo ############################################################################################################
	echo .
	echo .        Choix installation: DAMOTIC.FR +33783765036 LMGSAPB1H01 4000 Mai 2023 V4
	echo          %logonserver% %USERNAME% avec %COMPUTERNAME% %HOMEPATH% sous:%OS% 
	echo ############################################################################################################
	echo    00) Lire la documentation pour l'installation 
	echo    0) WINDOWS UPDATE OS
	echo    1) Setup, mapping, SMB1, purge temp, NetFx3
	echo    2) Netskope, installation depuis NAS 100.94
	echo    3) FSECURE, installation depuis NAS 100.94
	echo    4) Addons Mai 2023, installation depuis NAS 100.94
	echo    5) VPN, installation depuis NAS 100.94
	echo    6) GPUupdate force injection
	echo    7) Lotus NOTES V9 et Patch, installation depuis NAS 100.94
	echo    8) Solidedge2D, installation depuis NAS 100.94
	echo    9) Office 365, installation depuis NAS 100.94
	echo    10) DESKTOPinfo 
	echo    11) BIGFIX, installation depuis NAS 100.94
	echo    12) SAP V10.3, installation depuis NAS 100.94
	echo    13) Imprimantes
	echo    14) Grant ADDONS/SAP
	echo    15) Reboot reinstal Windows 10
	echo    16) Copie tout le dossier source sur C:\ITlmg
	echo    17) Serial Windows
	echo    96) TOUT sur IP du Poste
	echo    97) REBOOT DIRECTEMENT DANS LE BIOS
	echo    98) Insertion domaine lappmuller.local
	echo    99) INSTALL COMPLETE
	echo ############################################################################################################
	echo .
	echo .        Pour installer un pc avec toutes les options, faire le 99
	echo .
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
	@echo off 
	echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\      Documentation    \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ok
	echo .
	echo .
	echo .
	echo .              00) Lecture de la documentation
	echo . 
	echo . 
	echo . 
	explorer https://www.overleaf.com/project/665d8b689844da415cc4ab44
	COLOR fc
	goto menu

	:update
	@echo off
	echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ ok
	echo .
	echo .
	echo .        Vous avez lancé 0) WINDOWS UPDATE OS, mise à jour du pc avant de basculer dans le domaine
	echo .
	echo .
	echo ============================================================================================================
	COLOR fc
	wuauclt.exe /updatenow
	goto menu

	:setup
	@echo off
	COLOR fc
	echo on
	echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ ok
	echo .
	echo .
	echo .        Vous avez lancé 1) Setup, mapping, SMB1, purge temp, NetFx3
	echo .
	echo .
	echo =================================    FIN.  =================================================================

	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#antivirusLMG\Fsecure\Client\fscs-15.11.1138.msi"
	pause

	CMD /c "del /q /f /s %temp%\*"
	CMD /c "del /s /q C:\windows\temp\*"
	powercfg.exe /hibernate off
	powercfg.exe -h off

	pause
	DISM /Online /Enable-Feature /FeatureName:NetFx3 /All

	PowerShell.exe -command "Enable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol -NoRestart"

	xcopy \\192.168.100.94\it-lmg\Source\INSTALL2023\Polices\*.* C:\Windows\Fonts\ /Y /E

	echo ============================================================================================================
	echo .
	echo .
	echo .        Vous avez lancé 1) Setup, mapping, SMB1, purge temp, NetFx3
	echo .
	echo .
	echo ////////////////////////////////    FIN.  //////////////////////////////////////////////////////////////////
	@echo off
	goto menu

	:NETSKOPE
	@echo off
	COLOR fc
	echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ ok
	echo .
	echo .
	echo .        Vous avez lancé 2) Netskope, installation depuis NAS 100.94
	echo .            
	echo .        1- Copier le dossier sur le C: du PC
	echo .        2- Puis lancer la commande
	echo .        msiexec /I NSClient_96.1.1.1019.msi installmode=IDP mode=peruserconfig tenant=lappgroup domain=de.goskope.com
	echo .        Pour les serveurs ou les machines non Windows ou toutes les machines qui ne peuvent pas gérer l'authentification proxy,
	echo .        vous pouvez continuer à utiliser les mêmes anciens IP et port proxy comme toujours : 10.20.30.40:8081
	echo .        The login is for the Active Directory user - the same user that is required, for example, for Microsoft Teams and other Office 365 applications.
	echo .        This is only required once during enrollment.
	echo .        The disadvantage of the 10.20.30.40 proxy is that it is
	echo .        a) not available outside the corporate network - it always requires a VPN connection to Stuttgart
	echo .        b) also, when user don't use proxy authentication, it is very difficult to track down any issues that might be happening
	echo .        c) finally, without user authentication, it is almost impossible to get accurate reports about traffic volume etc.
	echo .
	echo ============================================================================================================

	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\NSClient_108.0.0.1555.msi token=BtQ0lqBIn8uBPThsc5Qf host=addon-lappgroup.de.goskope.com mode=peruserconfig /l*v %PUBLIC%\nscinstall.log"

	echo ============================================================================================================
	echo .
	echo .
	echo .        Vous avez lancé 2) Netskope, installation depuis NAS 100.94
	echo .
	echo .
	echo ////////////////////////////////    FIN.  //////////////////////////////////////////////////////////////////
	goto menu

	:FSECURE
	@echo off
	COLOR fc
	echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ ok
	echo .
	echo .
	echo .        Vous avez lancé 3) FSECURE, installation depuis NAS 100.94
	echo .
	echo .
	echo ============================================================================================================
	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#antivirusLMG\Fsecure\Client\F-SecureNetworkInstaller-AV.exe"
	pause
	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL202

	3\#applicationsDIVERS\TeamViewer_Host_Setup.exe"
	pause
	echo ============================================================================================================
	echo .       Vous avez lancé 3) FSECURE, installation depuis NAS 100.94
	echo ////////////////////////////////    FIN.  //////////////////////////////////////////////////////////////////
	goto menu

	:ADDONS
	@echo off
	COLOR fc
	echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ ok
	echo .
	echo .
	echo .        Vous avez lancé 4) Addons Mai 2023, installation depuis NAS 100.94
	echo .
	echo .
	echo ============================================================================================================
	echo on
	xcopy \\192.168.100.94\it-lmg\Source\INSTALL2023\Polices\*.* C:\Windows\Fonts\ /Y /E
	pause
	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\ChromeSetup.exe"
	pause
	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\Doko-phone.exe"
	pause
	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\TeamViewer_Host_Setup.exe"
	pause
	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\JavaSetup8u351.exe"
	pause
	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\Firefox Setup 112.0.1.exe"
	pause
	msiexec.exe /i "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\vlc-3.0.18-win64.msi"
	pause
	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\Advanced_IP_Scanner_2.5.4594.1.exe"
	pause
	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\7z2201-x64.exe"
	pause
	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\pdfcreator_27579844948158094.exe"
	pause
	msiexec.exe /i "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\Dialog.msi"
	pause
	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\ganttproject-3.1.3100.exe"
	pause
	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\KeePass-2.52-Setup.exe"
	pause
	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\#BIGIFX\BES-10.0.7.52\Client\Client-10.0.7.52.exe"
	pause
	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\Creative_Cloud_Set-Up.exe.exe"
	pause
	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\rufus-3.14.exe"
	pause
	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\Solid_Edge_Web_Installer_2023.exe"
	pause
	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\VirtualBox-7.0.8-156879-Win.exe"
	pause
	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\Xmind-for-Windows-x64bit-22.11.3656.exe"
	pause
	xcopy \\192.168.100.94\it-lmg\Source\INSTALL2023\Polices\*.* C:\Windows\Fonts\ /Y /E

	echo ============================================================================================================
	echo .
	echo .
	echo .        Vous avez lancé 4) Addons Mai 2023, installation depuis NAS 100.94
	echo .
	echo .
	echo ////////////////////////////////    FIN.  //////////////////////////////////////////////////////////////////
	@echo off
	goto menu

	:VPN
	@echo off
	COLOR fc
	echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	echo .
	echo .
	echo .        Vous avez lancé 5) VPN, installation depuis NAS 100.94
	echo .
	echo .
	echo ============================================================================================================
	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#antivirusLMG\Fsecure\Client\F-SecureNetworkInstaller-AV.exe"
	pause
	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\TeamViewer_Host_Setup.exe"
	pause
	msiexec.exe /i "\\192.168.100.94\it-lmg\Source\INSTALL2023\#VPNandSECURITY\E86.50_CheckPointVPN.msi"
	echo ============================================================================================================
	echo .
	echo .
	echo .        Vous avez lancé 5) VPN, installation depuis NAS 100.94
	echo .
	echo .
	echo ////////////////////////////////    FIN.  //////////////////////////////////////////////////////////////////
	goto menu

	:GPU
	@echo off
	echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ ok
	echo .
	echo .
	echo .        Vous avez lancé 6) GPUupdate force injection
	echo .
	echo .
	echo ////////////////////////////////    FIN.  //////////////////////////////////////////////////////////////////
	COLOR fc
	gpupdate /force
	goto menu

	:LOTUS
	@echo off
	COLOR fc
	echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ ok
	echo .
	echo .
	echo .        Vous avez lancé 7 Lotus NOTES V9 et Patch, installation depuis NAS 100.94
	echo .
	echo .
	echo ============================================================================================================
	echo on
	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#lotusNOTES\NOTES_CLIENT_9.0.1_WIN_FR.exe"
	pause
	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#lotusNOTES\notes901FP7_win.exe"
	@echo off
	goto menu

	:SOLID2D
	@echo off
	COLOR fc
	echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ ok
	echo .
	echo .
	echo .        Vous avez lancé 8) Solid Edge ATTENTION A LA VERSION
	echo .                    1) Solid Edge version 2D gratuite pour tout le monde 
	echo .                    2) Solid Edge version 3D sous licence LAPPMULLER
	echo .                    3) Solid Edge version Simulation
	echo .
	echo .
	set /p se=Choix : 
	if "%se%"=="1" goto sedge2d
	if "%se%"=="2" goto sedge3d
	if "%se%"=="3" goto sedge3s
	echo Quelle option:
	goto menu

	:sedge2d
	@echo off
	COLOR fc
	echo ============================================================================================================
	echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	echo .        Vous avez lancé 8) Solid Edge version 2D gratuite pour tout le monde 
	echo ============================================================================================================
	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#solidEDGE\Solid_Edge_Free2D_2019.exe"
	@echo off
	goto menu

	:sedge3d
	@echo off
	COLOR fc
	echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	echo .        Vous avez lancé 8) Solid Edge version 3D sous licence LAPPMULLER
	echo ============================================================================================================
	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#solidEDGE\Solid_Edge_DVD_FRENCH_2019.exe"
	@echo off
	goto menu

	:sedge3s
	@echo off
	COLOR fc
	echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	echo .        Vous avez lancé 8) Solid Edge version Simulation
	echo ============================================================================================================
	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#solidEDGE\Solid_Edge_2023_2210.exe"
	echo ////////////////////////////////    FIN.  //////////////////////////////////////////////////////////////////
	@echo off
	goto menu

	:365
	@echo off
	COLOR fc
	echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

	\\\\\\\\\\\\\\\\\\\ ok
	echo .
	echo .
	echo .        Vous avez lancé 9) Office 365, installation depuis NAS 100.94
	echo .
	echo .
	echo ============================================================================================================

	start CMD /c "del /q /f /s %temp%\*"
	start CMD /c "del /s /q C:\windows\temp\*"

	CMD /c DISM /Online /Enable-Feature /FeatureName:NetFx3 /All
	CMD /c DISM /Online /Enable-Feature /All /FeatureName:SMB1Protocol

	CMD /c net use o: \\LMGAPPS01\SEFlex\Program\ /user:lappmuller\administrateur Lmg@Olfex$83.com
	CMD /c net use p: \\lmgfile01\data\ /user:lappmuller\administrateur Lmg@Olfex$83.com
	CMD /c net use T: \\lmgfile01 /user:lappmuller\administrateur Lmg@Olfex$83.com

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
	echo .
	echo .
	echo .        Vous avez lancé 9) Office 365, installation depuis NAS 100.94
	echo .
	echo .
	echo ////////////////////////////////    FIN.  //////////////////////////////////////////////////////////////////
	goto menu

	:DESKTOPi
	@echo off
	COLOR fc
	echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	echo .
	echo .
	echo .        Vous avez lancé 10) DESKTOP info
	echo .
	echo .
	echo ============================================================================================================
	c:
	CD \
	MD DESKTOP
	xcopy \\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\DESKTOP\*.* C:\DESKTOP /Y /E
	echo ============================================================================================================
	echo .
	echo .
	echo .        Vous avez lancé 10) DESKTOP info
	echo .
	echo .
	echo ////////////////////////////////    FIN.  //////////////////////////////////////////////////////////////////
	goto menu
	echo.

	:BIGFIX
	@echo off
	COLOR fc
	echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	echo .
	echo .
	echo .        Vous avez lancé 11) BIGFIX, installation depuis NAS 100.94
	echo .
	echo .
	echo ============================================================================================================
	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#BIGIFX\BES-10.0.7.52\Client\Client-10.0.7.52.exe"
	echo ============================================================================================================
	echo .        Vous avez lancé 11)  BIGFIX, installation depuis NAS 100.94
	echo ////////////////////////////////    FIN.  //////////////////////////////////////////////////////////////////
	goto menu

	:SAP
	@echo off
	COLOR fc
	echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ ok
	echo .
	echo .
	echo .        Vous avez lancé 12) Installation SAP
	echo .
	echo .
	echo ============================================================================================================
	runas /user:lappmuller\lda "CMD /c DISM /Online /Enable-Feature /FeatureName:NetFx3 /All"
	runas /user:lappmuller\lda "CMD /c DISM /Online /Enable-Feature /All /FeatureName:SMB1Protocol"

	CMD /c "\\192.168.100.145\B1_SHF\Client.x64\setup.exe"
	pause
	CMD /c "\\192.168.100.145\B1_SHF\HANA_Client_v2_SPS05\hdbsetup.exe"
	echo ECHO Paramétres SAP LMGSAPB1H01 4000
	pause

	echo ============================================================================================================
	echo .        Vous avez lancé 12) Installation SAP
	echo ////////////////////////////////    FIN.  //////////////////////////////////////////////////////////////////
	goto menu

	:prt
	@echo off
	COLOR fc
	echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	echo .
	echo .
	echo .        Vous avez lancé 13) Imprimantes
	echo .
	echo .
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
	echo .        Vous avez lancé 13) Imprimantes
	echo ////////////////////////////////    FIN.  //////////////////////////////////////////////////////////////////
	goto menu

	:grantaddons
	@echo off
	COLOR fc
	echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	echo .
	echo .
	echo .        Vous avez lancé 14) Grant lecture all ADDONS/SAP
	echo .
	echo .
	echo ============================================================================================================
	iCACLS "C:\Program Files\sap\SAP Business One\AddOns" /Grant "Tout le monde":F /T 
	echo ============================================================================================================
	echo .        Vous avez lancé 14) Grant lecture all ADDONS/SAP
	echo ////////////////////////////////    FIN.  //////////////////////////////////////////////////////////////////
	goto menu

	:initOS
	@echo off
	COLOR fc
	echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	echo .
	echo .
	echo .    Vous avez lancé 15) Reboot reinstal Windows 10
	echo .
	echo .
	echo ////////////////////////////////    FIN.  //////////////////////////////////////////////////////////////////
	shutdown /r /o /f /t 00
	goto menu

	:copyall
	@echo off
	COLOR fc
	echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	echo .
	echo .
	echo .        Vous avez lancé 16) Copie tout le dossier source sur C:\ITlmg
	echo .
	echo .
	echo ////////////////////////////////    FIN.  //////////////////////////////////////////////////////////////////
	c:
	cd \
	MD ITlmg
	xcopy \\192.168.100.94\it-lmg\Source\INSTALL2023\*.* C:\ITlmg /Y /E
	goto menu

	:serialwin
	@echo off
	COLOR fc
	echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	echo .


	echo .
	echo .        Vous avez lancé 17) Serial Windows
	echo .
	echo .
	echo ////////////////////////////////    FIN.  //////////////////////////////////////////////////////////////////
	START /wait CMD /c clef_win
	pause
	goto menu

	:switching
	@echo off
	echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	echo .
	echo .    96) Analyses IP sur Poste
	echo .
	echo ============================================================================================================
	echo on
	PING www.google.com
	PATHPING www.google.com
	TRACERT www.google.com
	IPCONFIG /all
	NSLOOKUP www.google.com
	NETSTAT 
	ROUTE PRINT
	pause
	echo off
	echo ============================================================================================================
	echo .
	echo .    fin 96)  Analyses IP
	echo .
	echo ////////////////////////////////    FIN.  //////////////////////////////////////////////////////////////////
	goto menu

	:BIOS
	@echo off
	echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	echo .
	echo .    97) REBOOT DIRECTEMENT DANS LE BIOS
	echo .
	echo ============================================================================================================
	echo on
	shutdown /r /fw /f /t 0
	goto menu

	:ADDdomain
	@echo off
	echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	echo .
	echo . Insertion domaine lappmuller.local
	echo . computer-name : nom de l’ordinateur à joindre au domaine
	echo . /domain : nom du domaine Active Directory
	echo . /ud : Compte du domaine autorisé à joindre un ordinateur
	echo . /pd : * permet la saisie du mot de passe ou entrer le mot de passe en clair.
	echo . /OU : il est possible d’indiquer l’OU
	echo . /reboot : redémarrage du poste après la jonction
	echo .
	echo ////////////////////////////////    FIN.  //////////////////////////////////////////////////////////////////
	Add-Computer lappmuller administrateur@Lmg@Olfex$83.com
	pause
	goto menu

	:installCOMPLETE
	@echo off
	COLOR fc
	echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	echo .
	echo .        99) Installation de toutes les applications LAPPMULLER.LOCAL Et LAPPDOMAIN
	echo .
	echo ============================================================================================================

	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#antivirusLMG\Fsecure\Client\fscs-15.11.1138.msi"
	pause

	CMD /c "del /q /f /s %temp%\*"
	CMD /c "del /s /q C:\windows\temp\*"

	CMD /c DISM /Online /Enable-Feature /FeatureName:NetFx3 /All
	CMD /c DISM /Online /Enable-Feature /All /FeatureName:SMB1Protocol

	net use o: \\LMGAPPS01\SEFlex\Program\ /user:lappmuller\administrateur Lmg@Olfex$83.com
	net use p: \\lmgfile01\ /user:lappmuller\administrateur Lmg@Olfex$83.com
	net use T: \\lmgfile01 /user:lappmuller\administrateur Lmg@Olfex$83.com

	cmd /c \\192.168.100.94\it-lmg\Source\INSTALL2023\Polices\C062003T.TTF
	cmd /c \\192.168.100.94\it-lmg\Source\INSTALL2023\Polices\C062006T.TTF
	cmd /c \\192.168.100.94\it-lmg\Source\INSTALL2023\Polices\C063003T.TTF
	cmd /c \\192.168.100.94\it-lmg\Source\INSTALL2023\Polices\C063006T.TTF
	cmd /c \\192.168.100.94\it-lmg\Source\INSTALL2023\Polices\CorporateSTOT-Bol.otf
	cmd /c \\192.168.100.94\it-lmg\Source\INSTALL2023\Polices\CorporateSTOT-Reg.otf

	xcopy \\192.168.100.94\it-lmg\Source\INSTALL2023\Polices\*.* C:\Windows\Fonts\ /Y /E
	xcopy \\192.168.100.94\it-lmg\Source\INSTALL2023\lebureau\*.* C:\Users\%user%\Desktop\liensutiles /Y /E
	pause

	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\NSClient_96.1.1.1019.msi token=BtQ0lqBIn8uBPThsc5Qf host=addon-lappgroup.de.goskope.com mode=peruserconfig /l*v %PUBLIC%\nscinstall.log"

	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\#Office\O365-for-Admins\Install_Files\setup.exe" /configure "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\#Office\O365-for-Admins\Install_Files\Install-O365-Fr-EN.xml"
	xcopy \\192.168.100.94\it-lmg\Source\Polices\*.* C:\Windows\Fonts\ /Y /E
	xcopy \\192.168.100.94\it-lmg\Source\lebureau\*.* C:\Users\%user%\Desktop /Y /E

	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\ChromeSetup.exe"
	pause

	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\TeamViewer_Setup_x64.exe"
	pause

	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\JavaSetup8u351.exe"
	pause

	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\Firefox Setup 112.0.1.exe"
	pause

	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\vlc-3.0.18-win64.msi"
	pause

	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\Advanced_IP_Scanner_2.5.4594.1.exe"
	pause

	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\pdfcreator_27579844948158094.exe"
	pause
	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\Dialog.msi"
	pause
	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\ganttproject-3.1.3100.exe"
	pause
	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\KeePass-2.52-Setup.exe"
	pause
	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\#BIGIFX\BES-10.0.7.52\Client\Client-10.0.7.52.exe"
	pause
	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\readerdc64_fr_l_cra_mdr_install.exe"
	pause
	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\rufus-3.14.exe"
	pause
	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\Solid_Edge_Web_Installer_2023.exe"
	pause
	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\VirtualBox-7.0.8-156879-Win.exe"
	pause
	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\Xmind-for-Windows-x64bit-22.11.3656.exe"

	xcopy \\192.168.100.94\it-lmg\Source\INSTALL2023\Polices\*.* C:\Windows\Fonts\ /Y /E
	xcopy \\192.168.100.94\it-lmg\Source\INSTALL2023\lebureau\*.* C:\Users\%user%\Desktop\liensutiles /Y /E

	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#VPN

	andSECURITY\E86.50_CheckPointVPN.msi"

	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#lotusNOTES\NOTES_CLIENT_9.0.1_WIN_FR.exe"
	pause
	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#lotusNOTES\notes901FP7_win.exe"
	pause
	CMD /c "\\192.168.100.94\Source\INSTALL2023\#applicationsDIVERS\2.2.Solid Edge\Guides Solid Edge 2019\Solid_Edge_MSI_MP10.exe"
	pause
	c:
	CD \
	MD DESKTOP
	xcopy \\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\DESKTOP\*.* C:\DESKTOP /Y /E
	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#antivirusLMG\Fsecure\Client\fscs-15.11.1138.msi"
	CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\Source\INSTALL2023\#BIGIFX\BES-10.0.7.52\Client\Client-10.0.7.52.exe"

	CMD /c "\\lmgsapB1H01\B1_SHF\Client.x64\setup.exe"
	pause
	CMD /c "\\lmgsapB1H01\B1_SHF\HANA_Client_v2_SPS05\hdbsetup.exe"

	xcopy \\192.168.100.94\it-lmg\Source\Polices\*.* C:\Windows\Fonts\ /Y /E
	xcopy \\192.168.100.94\it-lmg\Source\lebureau\*.* C:\Users\%user%\Desktop /Y /E
	cscript C:\Windows\SysWOW64\Printing_Admin_Scripts\fr-FR\prnport.vbs -a -r IP_192.168.100.210 -h 192.168.1.210 -o raw -n 9100
	cscript C:\Windows\SysWOW64\Printing_Admin_Scripts\fr-FR\prnport.vbs -a -r IP_192.168.100.215 -h 192.168.1.215 -o raw -n 9100
	cscript C:\Windows\SysWOW64\Printing_Admin_Scripts\fr-FR\prnport.vbs -a -r IP_192.168.100.216 -h 192.168.1.216 -o raw -n 9100
	cscript C:\Windows\SysWOW64\Printing_Admin_Scripts\fr-FR\prnport.vbs -a -r IP_192.168.100.219 -h 192.168.1.216 -o raw -n 9100
	cscript C:\Windows\SysWOW64\Printing_Admin_Scripts\fr-FR\prnport.vbs -a -r IP_192.168.100.222 -h 192.168.1.216 -o raw -n 9100

	iCACLS "C:\Program Files\sap\SAP Business One\AddOns" /Grant "Tout le monde":F /T 
	goto menu

	:exit
	@exit