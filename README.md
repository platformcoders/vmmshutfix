# Project vmmshutfix
This project is for Virtual Machine Preshutdown Notification Service.  Service sends Preshutdown notification message to Virtual Machines ahead of Hyper-V Managemnt Services.  
THis was originally written to solve issue with a Server 2019 HyperV bug where during the host restart machines were being turn it off instead of shutdown. With this service and machines set to "Save" system will attempt to shutdown VM's and those that dont complete shutdown on time will be saved at the point where it no longer matter for them because they were in a process comencing shtdown anyway. This is important for domain controllers, Database servers, Exchanges servers and any machine running replication. 

## Getting Started
Download Visual Studio Community to compile the source code from 
* [Visual Studio downloads] (https://visualstudio.microsoft.com/downloads/)

Download This project from github as zip file 
* [Github ZIP] (https://github.com/platformcoders/vmmshutfix/archive/master.zip)

Compiled version can be downloaded from following location
* [Githubrelease]

## Installing
1. Unzip files to a folder and right click on **servicesettingsscript_V1.ps1**  than select edit. 
2. This should open Powershell ISE, click on the Run script icon or press F5 to run script. 
3. Powershell supposed to create folder **vmmshutfix** under **c:\Program Files** and copy 
* vmmshutfix.exe
* vmmshutfix.exe.config
* vmmshutfix.exe.pdb
* servicesettingsscript_V1.ps1
Than register **vmmshutfix.exe** as service and register itself at the begingin of the **Preshutdownorder** registry key located:
hklm:SYSTEM\CurrentControlSet\Control
4. Type **start-service vmmshutfix** at PowerShell prompt, and watch for confirmation if service is started.
5. Once service is started you can set your Virtual Machines to **Auto Save** on Host reboots. 



