﻿<#


function network {
function name {

Write-Host ""
$namecopm=read-host "enter the name of computer"
$namedomainjoin=read-host "enter the name of domain"
$namenetbios=read-host "enter the name of netbios"
Write-Host ""
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name DefaultUserName -Value "$namenetbios\Administrator"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name DefaultPassword -Value 'Pa$$w0rd'
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name AutoAdminLogon  -Value "1"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name ForceAutoLogon  -Value "1"
Write-Host "the system will reboot in 15 s.."
Write-Host "The script automatically sign in the system after a restart. In hyper-v you should disable enhanced session" -ForegroundColor "red"
        For ($c=0; $c -le 15; $c++) { 

        Write-host "." -foregroundcolor "red" -nonewline 
        Start-Sleep -s 1 

        }
        
        Add-Computer -DomainName $namedomainjoin  -PassThru -Verbose -Credential $namenetbios\administrator -NewName $namecopm -Restart
        
}

network
name



