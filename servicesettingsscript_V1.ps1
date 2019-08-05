$Stringarray = @()
$newarray = @()
$value = get-ItemProperty -Path "hklm:SYSTEM\CurrentControlSet\Control" -Name PreshutdownOrder #|  select -expandproperty preshutdownorder # -Value $a
$Stringarray = $value.Preshutdownorder


$newval = "vmmshutfix"

[boolean]$NewServiceexists = $true
foreach ($item in $Stringarray){



        if ($item -like "vmmshutfix")
        {
            $NewServiceexists = $false
            
        }


}

If ($NewServiceexists) {
$newarray += $newval
$newarray += $Stringarray
Set-ItemProperty -Path "hklm:SYSTEM\CurrentControlSet\Control" -Name "PreshutdownOrder" -type MultiString -Value $newarray
$newarray
}






#Set-ItemProperty -Path "hklm:SYSTEM\CurrentControlSet\Control" -Name "WaitToKillServiceTimeout" -type DWord -Value "5000"

#Set-ItemProperty -Path "hklm:SOFTWARE\Microsoft\Windows NT\CurrentVersion\Virtualization" -Name "ShutdownTimeout" -type DWord -Value "120"

$findvmmshutfix = get-service -name vmmshutfix -ErrorAction SilentlyContinue

If ($findvmmshutfix -like ""){



}
Else {
stop-service -name vmmshutfix -Force
Invoke-Expression -Command "sc.exe delete vmmshutfix"


}

$despath = "C:\Program Files\vmmshutfix"

$foldercheck = Test-Path "$despath" -PathType Container

If (-not $foldercheck){
New-Item -Path $despath -ItemType Directory

}



#copy files to system32
Copy-Item -Path ".\vmmshutfix.exe" -Destination "$despath" -force
copy-item -path ".\vmmshutfix.exe.config"  -Destination "$despath" -force
copy-item -path ".\vmmshutfix.pdb"  -Destination "$despath" -force
Copy-Item -Path ".\servicesettingsscript_v1.ps1" -Destination "$despath" -force

$SCpath = $despath


Invoke-Expression -Command 'sc.exe create vmmshutfix DisplayName="Virtual Machine PreShutdown Notification Service" binpath="C:\Program Files\vmmshutfix\vmmshutfix.exe" type=own start=auto'