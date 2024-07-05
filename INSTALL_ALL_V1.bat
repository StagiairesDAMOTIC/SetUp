
:installCOMPLETE
echo off
COLOR fc
echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Echo .
echo .		99) Installation de toutes les applications LAPPMULLER.LOCAL Et LAPPDOMAIN
Echo .
echo ============================================================================================================



CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#antivirusLMG\Fsecure\Client\fscs-15.11.1138.msi"
Pause

CMD /K "del /q /f /s %temp%\*"
CMD /K "del /s /q C:\windows\temp\*

CMD /c DISM /Online /Enable-Feature /FeatureName:NetFx3 /All
CMD /c DISM /Online /Enable-Feature /All /FeatureName:SMB1Protocol

net use o: \\LMGAPPS01\SEFlex\Program\%administrateur%Lmg@Olfex$83.com
net use p: \\lmgfile01\%administrateur%Lmg@Olfex$83.com
net use T: \\lmgfile01 /u:lappmuller\administrateur Lmg@Olfex$83.com

cmd /c \\192.168.100.94\it-lmg\Source\INSTALL2023\Polices\C062003T.TTF
cmd /c \\192.168.100.94\it-lmg\Source\INSTALL2023\Polices\C062006T.TTF
cmd /c \\192.168.100.94\it-lmg\Source\INSTALL2023\Polices\C063003T.TTF
cmd /c \\192.168.100.94\it-lmg\Source\INSTALL2023\Polices\C063006T.TTF
cmd /c \\192.168.100.94\it-lmg\Source\INSTALL2023\Polices\CorporateSTOT-Bol.otf
cmd /c \\192.168.100.94\it-lmg\Source\INSTALL2023\Polices\CorporateSTOT-Reg.otf


xcopy \\192.168.100.94\it-lmg\Source\INSTALL2023\Polices\*.* C:\Windows\Fonts\ /Y /E
xcopy \\192.168.100.94\it-lmg\Source\INSTALL2023\lebureau\*.* C:\Users%user%\Desktop\liensutiles /Y /E
Pause

CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\NSClient_96.1.1.1019.msi token=BtQ0lqBIn8uBPThsc5Qf host=addon-lappgroup.de.goskope.com mode=peruserconfig /l*v %PUBLIC%\nscinstall.log"

CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\#Office\O365-for-Admins\Install_Files\setup.exe" /configure "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\#Office\O365-for-Admins\Install_Files\Install-O365-Fr-EN.xml"
xcopy \\192.168.100.94\it-lmg\Source\Polices\*.* C:\Windows\Fonts\ /Y /E
xcopy \\192.168.100.94\it-lmg\Source\lebureau\*.* C:\Users\%user%\Desktop /Y /E

CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\ChromeSetup.exe"
Pause

CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\TeamViewer_Setup_x64.exe"
Pause

CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\JavaSetup8u351.exe"
Pause

CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\Firefox Setup 112.0.1.exe"
Pause

CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\vlc-3.0.18-win64.msi"
Pause

CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\Advanced_IP_Scanner_2.5.4594.1.exe"
Pause

CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\7z2201-x64.exe"
Pause
CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\pdfcreator_27579844948158094.exe"
Pause
CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\Dialog.msi"
Pause
CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\ganttproject-3.1.3100.exe"
Pause
CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\KeePass-2.52-Setup.exe"
Pause
CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\#BIGIFX\BES-10.0.7.52\Client\Client-10.0.7.52.exe"
Pause
CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\readerdc64_fr_l_cra_mdr_install.exe"
Pause
CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\rufus-3.14.exe"
Pause
CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\Solid_Edge_Web_Installer_2023.exe"
Pause
CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\VirtualBox-7.0.8-156879-Win.exe"
Pause
CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#applicationsDIVERS\Xmind-for-Windows-x64bit-22.11.3656.exe"

xcopy \\192.168.100.94\it-lmg\Source\INSTALL2023\Polices\*.* C:\Windows\Fonts\ /Y /E
xcopy \\192.168.100.94\it-lmg\Source\INSTALL2023\lebureau\*.* C:\Users%user%\Desktop\liensutiles /Y /E

CMD /c "\\192.168.100.94\it-lmg\Source\INSTALL2023\#VPNandSECURITY\E86.50_CheckPointVPN.msi"

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
Pause
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



:vmware
echo off
echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Echo .
Echo .
echo ============================================================================================================



echo ============================================================================================================
Echo .
Echo .
echo ////////////////////////////////    FIN.  //////////////////////////////////////////////////////////////////
goto menu



:xxxxx
echo off
echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    START   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Echo .
Echo .
echo ============================================================================================================
echo on

echo off
echo ============================================================================================================
Echo .
Echo .
echo ////////////////////////////////    FIN.  //////////////////////////////////////////////////////////////////
goto menu


:exit
@exit