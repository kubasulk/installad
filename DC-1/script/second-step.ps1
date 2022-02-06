<#
    .NOTES
        Version: 1.0
    .DESCRIPTION
        Developer
            Developer: Kuba
            License: Free for private use only
            Changing name of computer, Removing autologon functions", Installing role AD
#>
function autologon {Write-Host ""Write-Host "3. Removing autologin function" -ForegroundColor GreenWrite-Host ""Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name AutoAdminLogon  -Value "0"Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name ForceAutoLogon  -Value "0"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name DefaultUserName  -Value "0"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name DefaultPassword   -Value "0"Remove-itemproperty -path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run" -name MyKey

Write-Host "Removing autologon function"
        For ($c=0; $c -le 10; $c++) { 

        Write-host "*" -foregroundcolor "yellow" -nonewline 

        Start-Sleep -s 1 

        } 
        Write-Host ""
        Write-Host ""
        Write-Host ""
        Write-Host ""
        }



function installad {
Write-Host ""Write-Host ""Write-Host ""Write-Host ""Write-Host ""Write-Host "4. Instaling AD role" -ForegroundColor GreenWrite-Host ""

Write-Host ""
Write-Host "Instaling role AD.... wait"
Write-Host ::
Install-WindowsFeature -name AD-Domain-Services -IncludeManagementTools -WarningAction SilentlyContinue > $null
        For ($c=0; $c -le 20; $c++) { 

        Write-host "*" -foregroundcolor "green" -nonewline 

        Start-Sleep -s 1 

        } 
$check=Get-WindowsFeature AD-Domain-Services  

if ($check.InstallState -eq "Installed")
{
Write-Host ""
Write-Host ""
Write-Host "Role is installed" -ForegroundColor "Green"
Write-Host ""
Write-Host ""
}
else {
Write-Host "Role is not installed" -ForegroundColor "red"
break
}
}



function conf{
Write-Host ""
Write-Host "5. Conf AD" -ForegroundColor Green
Write-Host ""
$global:DomainMode=read-host "Enter name of domain:"
$global:DomainNetbiosName=read-host "Enter name of NetBios:"


if ($global:DomainMode -like "*.*"){



Write-Host ""

$version=(Get-CimInstance -ClassName CIM_OperatingSystem).Caption 
Write-Host "Rembemer that your system this $version" -ForegroundColor red
Write-Host ""

$global:ForestModelvl=read-host "Enter level of Forest win2008 / win2008R2 / win2012 / win2012R2 / WinThreshold"

if ($ForestModelvl -eq "win2008")
{
$global:domainModelvl=read-host "Enter level of domain win2008 / win2008R2 / win2012 / win2012R2 / WinThreshold"
    if (($domainModelvl -ne "WinThreshold") -and ($domainModelvl -ne "win2012R2") -and ($domainModelvl -ne "win2012") -and ($domainModelvl -ne "win2008R2") -and ($domainModelvl -ne "win2008")){
    write-host "bad choice,  domain level will be set on win2008"
    $domainModelvl="win2008"
    }
}

if ($ForestModelvl -eq "win2008R2")
{
$global:domainModelvl=read-host "Enter level of domain win2008R2 / win2012 / win2012R2 / WinThreshold"
    if (($domainModelvl -ne "WinThreshold") -and ($domainModelvl -ne "win2012R2") -and ($domainModelvl -ne "win2012") -and ($domainModelvl -ne "win2008R2")){
    write-host "bad choice,  domain level will be set on win2008R2"
    $domainModelvl="win2008R2"
    }
}

if ($ForestModelvl -eq "win2012")
{
$global:domainModelvl=read-host "Enter level of domain win2012 / win2012R2 / WinThreshold"
    if (($domainModelvl -ne "WinThreshold") -and ($domainModelvl -ne "win2012R2") -and ($domainModelvl -ne "win2012")){
    write-host "bad choice,  domain level will be set on win2012"
    $domainModelvl="win2012"
    }
}

if ($ForestModelvl -eq "win2012R2")
{
$global:domainModelvl=read-host "Enter level of domain win2012R2 / WinThreshold"
    if (($domainModelvl -ne "WinThreshold") -and ($domainModelvl -ne "win2012R2")){
    write-host "bad choice,  domain level will be set on win2012R2"
    $domainModelvl="win2012R2"
    }
}
if ($ForestModelvl -eq "WinThreshold")
{
$global:domainModelvl="WinThreshold"
write-host "domain level will be set on WinThreshold"
}

if ($ForestModelvl -ne "WinThreshold" -and $ForestModelvl -ne "win2012R2" -and $ForestModelvl -ne "win2012" -and $ForestModelvl -ne "win2008R2" -and $ForestModelvl -ne "win2008")
{
write-host "bad choice of level forest"
conf

}

}

else {
Write-Host ""
Write-Host "bad name of domain" -ForegroundColor Red
Write-Host ""
conf}



}


function show{
Write-Host ""
Write-Host "6. Show parameters" -ForegroundColor Green
Write-Host ""
Write-Host ""
Write-Host "
Install-ADDSForest `
-CreateDnsDelegation:$false `
-DatabasePath "C:\Windows\NTDS" `
-DomainMode $domainModelvl `
-DomainName $DomainMode `
-DomainNetbiosName $DomainNetbiosName `
-ForestMode $ForestModelvl `
-InstallDns:$true `
-LogPath "C:\Windows\NTDS" `
-NoRebootOnCompletion:$false `
-SysvolPath "C:\Windows\SYSVOL" `
-Force:$true
"
        For ($c=0; $c -le 15; $c++) { 
        
         Write-host "*" -foregroundcolor "green" -nonewline 

        Start-Sleep -s 1 

        } 
        Write-Host ""
}

function startinstall{
Write-Host ""
Write-Host "7. instaling AD"
Write-Host ""
Install-ADDSForest `
-CreateDnsDelegation:$false `
-DatabasePath "C:\Windows\NTDS" `
-DomainMode $domainModelvl `
-DomainName $DomainMode `
-DomainNetbiosName $DomainNetbiosName `
-ForestMode $ForestModelvl `
-InstallDns:$true `
-LogPath "C:\Windows\NTDS" `
-NoRebootOnCompletion:$false `
-SysvolPath "C:\Windows\SYSVOL" `
-Force:$true

}


function thirdstep{
new-itemproperty -path HKLM:\Software\Microsoft\Windows\CurrentVersion\Run MyKey -propertytype String -value "Powershell C:\script\third-step.ps1" > $nullSet-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name DefaultUserName -Value "$DomainNetbiosName\Administrator"Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name DefaultPassword -Value 'Pa$$w0rd'Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name AutoAdminLogon  -Value "1"Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name ForceAutoLogon  -Value "1"
}

autologon
installad
conf
show
thirdstep
startinstall


