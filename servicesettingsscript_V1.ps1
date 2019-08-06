<#
//The MIT License (MIT) 
// 
//
// 
//Permission is hereby granted, free of charge, to any person obtaining a copy 
//of this software and associated documentation files (the "Software"), to deal 
//in the Software without restriction, including without limitation the rights 
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell 
//copies of the Software, and to permit persons to whom the Software is 
//furnished to do so, subject to the following conditions: 
// 
//The above copyright notice and this permission notice shall be included in 
//all copies or substantial portions of the Software. 
// 
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN 
//THE SOFTWARE. 
// 

#>

$Stringarray = @()
$newarray = @()
$value = get-ItemProperty -Path "hklm:SYSTEM\CurrentControlSet\Control" -Name PreshutdownOrder 
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




Copy-Item -Path ".\vmmshutfix.exe" -Destination "$despath" -force
copy-item -path ".\vmmshutfix.exe.config"  -Destination "$despath" -force
copy-item -path ".\vmmshutfix.pdb"  -Destination "$despath" -force
Copy-Item -Path ".\servicesettingsscript_v1.ps1" -Destination "$despath" -force

$SCpath = $despath


Invoke-Expression -Command 'sc.exe create vmmshutfix DisplayName="Virtual Machine PreShutdown Notification Service" binpath="C:\Program Files\vmmshutfix\vmmshutfix.exe" type=own start=auto'