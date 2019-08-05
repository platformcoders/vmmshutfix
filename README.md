# Project vmmshutfix
This project is for Virtual Machine Preshutdown Notification Service.  Service sends Preshutdown notification message to Virtual Machines ahead of Hyper-V Managemnt Services.  
THis was originally written to solve issue with a Server 2019 HyperV bug where during the host restart machines were being turn it off instead of shutdown. With this service and machines set to "Save" system will attempt to shutdown VM's and those that dont complete shutdown on time will be saved at the point where it no longer matter for them because they were in a process comencing shtdown anyway. This is important for domain controllers, Database servers, Exchanges servers and any machine running replication. 

## Getting Started
Download Visual Studio Community to compile the source code from 
* [Visual Studio downloads] (https://visualstudio.microsoft.com/downloads/)

Downlaod This project from github as zip file 
* [Github ZIP] (https://github.com/platformcoders/vmmshutfix/archive/master.zip)

