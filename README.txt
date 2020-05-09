Windows ICS (Internet Connection Sharing) doesn't work after system reboot. The workaround solution is to re-enable ICS at system startup. This project provides
1. A powershell script which can re-enable ICS.
2. Install/uninstall powershell script as/from scheduled system startup tasks.


Installation:
1. Find out the description of your public network adapter (has Internet access) and private network adapter (connect with your LAN) by executing "ipconfig" in command prompt.
   > ipconfig
2. Modify $publicInterface and $privateInterface in ics_reenabler.ps1 accordingly.
3. Copy modified ics_reenabler.ps1 to C:\Windows\ics_reenabler.ps1.
4. Open a command prompt with admin privilege,
   > regsvr32 hnetcfg.dll
   > install.bat


Uninstallation:
1. Open a command prompt with admin privilege,
   > uninstall.bat
