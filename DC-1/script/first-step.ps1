﻿<#
            DESCRIPTION
            Developer: Kuba
            Setting IP Address, Changing name of computer, Setting autologin function / Setting second step (runinng script)
            v.1
#>

#$ErrorActionPreference = ‘SilentlyContinue’
function network{
                        Write-Host "1. Setting IP Address" -ForegroundColor Green
                        Write-Host ""
                        $ipadd=""
                        $mask=""
                        $gw=""
                        $dns=""
                        $dns1=""
                        $network=get-netadapter


                                    if ($network.Status -eq "up"){
                                       $ipadd=read-host "Enter IP Adress"
                                       $mask=read-host "Enter Prefix Length"
                                       $gw=read-host "Enter GW Adress"
                                       $dns=read-host "Enter DNS Adress"
                                       $dns1=read-host "Enter DNS 1 Adress"
                                       $enterip=(New-NetIPAddress –IPAddress $ipadd -DefaultGateway $gw -PrefixLength $mask -InterfaceIndex (Get-NetAdapter).InterfaceIndex -ErrorAction SilentlyContinue)

                                                  if (!$enterip){
                                                                   ""
                                                                   ""
                                                                   Write-Host "Check the provided address"  -ForegroundColor Red
                                                                   break
                                                                }
                                        else{
                                            $enterip> $null
                                            Set-DNSClientServerAddress –InterfaceIndex (Get-NetAdapter).InterfaceIndex –ServerAddresses $dns,$dns1
                                            Start-Sleep -s 5
                                            ipconfig
                                            Start-Sleep -s 5
                                            }
                                                                }

                            else{
                                    Write-Host "connect vm to any network" -ForegroundColor Red
                                    exit
                                }



}









function name ([string]$Global:namecopm){
Write-Host ""
Write-Host ""
Write-Host "2. Changing name of computer" -ForegroundColor Green
Write-Host ""
Write-Host ""
$global:namecopm=read-host "Enter the name of computer "
Write-Host ""
new-itemproperty -path HKLM:\Software\Microsoft\Windows\CurrentVersion\Run MyKey -propertytype String -value  "Powershell C:\script\second-step.ps1" > $null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name DefaultUserName -Value "Administrator"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name DefaultPassword -Value 'Pa$$w0rd'
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name AutoAdminLogon  -Value "1"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name ForceAutoLogon  -Value "1"
Write-Host "The system will reboot in 15 s.."
Write-Host "The script automatically sign in the system after a restart. In hyper-v you should disable enhanced session" -ForegroundColor "red"
Write-Host ""
        For ($c=0; $c -le 15; $c++) { 

                                        Write-host "." -foregroundcolor "red" -nonewline 
                                        Start-Sleep -s 1 

                                    } 
        Rename-Computer -NewName $global:namecopm -Restart
        
                                       }

network
name
