# Virtual Machine Preshutdown Notification Service
This project is for Virtual Machine Preshutdown Notification Service.  Service sends Preshutdown notification message to Virtual Machines ahead of Hyper-V Managemnt Services.  
This service helps to work around the issue with a Server 2019 Hyper-V bug where during the restarts of the host, virtual  machines are being turn it off instead of being gracefully shutdown. With this service and machines set to "Save" system will attempt to shutdown VM's and those that don’t complete shutdown on time will be saved at the point where it no longer matter for them because they were in a process commencing shutdown anyway. This is important for domain controllers, Database servers, Exchanges servers and any machine running replication.

## Getting Started
Download Visual Studio Community to compile the source code from 
* [Visual Studio downloads] (https://visualstudio.microsoft.com/downloads/)

Download This project from github as zip file 
* [Github ZIP] (https://github.com/platformcoders/vmmshutfix/archive/master.zip)

Compiled version can be downloaded from following location
* [Github release] (https://github.com/platformcoders/vmmshutfix/releases/tag/vmmshytfix)

## Installing
1. Unzip downloaded files to a folder and right click on **servicesettingsscript_V1.ps1**  than select edit. 
2. This should open Powershell ISE, click on the Run script icon or press F5 to run script. 
3. Powershell supposed to create folder **vmmshutfix** under **c:\Program Files** and copy 
* vmmshutfix.exe
* vmmshutfix.exe.config
* vmmshutfix.exe.pdb
* servicesettingsscript_V1.ps1

    Than powershell registers **vmmshutfix.exe** as service and register itself at the begingin of the **Preshutdownorder** registry key located:
hklm:SYSTEM\CurrentControlSet\Control

4. Type **start-service vmmshutfix** at PowerShell prompt, and watch for confirmation if service is started.
5. Once service is started you can set your Virtual Machines to **Auto Save** on Host reboots. 


## Uninstalling 
1. Open CMD as an Administrator
2. Type **Net Stop vmmshutfix** and press **Enter**
3. Once service stops, than Type **sc.exe delete vmmshutfix.exe** and press **Enter**
4. You should get confirmation that service is deleted 
5. Now you can delete **vmmshutfix** directory under **C:\Program Files**

## FAQ
1. **Does service issues shutdown commands to machines if you stop service itself?**
A: No, service won't stop machines so you can stop service and run sc.exe delete vmmshutfix while the HyperV host is operational.
2. **What happens if machine is stubborn to shutdown?**
A:When Machine is set to **Save** and **Autostart** in HyperV vmmshutfix will issue shutdown command, and if machine takes too long HyperV will Save whatever is left of shutdown process. Machine will finish shutdown process after HyperV host comes back online.  AFter machine finishes shutdown it can be started again.
