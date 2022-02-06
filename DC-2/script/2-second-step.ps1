<#
            DESCRIPTION
            Developer: Kuba
            
            v.1
#>

function autoremove {
Write-Host ""
Write-Host "3. Removing autologon function" -ForegroundColor Green
Write-Host ""

Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name AutoAdminLogon  -Value "0"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name ForceAutoLogon  -Value "0"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name DefaultUserName  -Value "0"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name DefaultPassword   -Value "0"
remove-itemproperty -path HKLM:\Software\Microsoft\Windows\CurrentVersion\Run -name MyKey
}

function finddc1 {
 Write-Host ""
Write-Host "6. Choosing a dc" -ForegroundColor Green
Write-Host ""
$global:domanname=(Get-ADDomain).dnsroot
$listdc1=(Get-ADDomainController -filter *)
$global:listdc=(Get-ADDomainController -filter *).hostname


$listdcglo=$listdc1  | select hostname, site
echo "$listdcglo"
$global:selectdc=read-host "Select the name of the DC from whom you would like to replicate data 'enter host name with $global:domanname '"


if ($lisdc -ccontains $selectdc)
{
Write-Host "entered server  $selectdc is unreachable "
write-host ""
finddc1
}

}



function site1 {
Write-Host ""
Write-Host "5. Choosing a site" -ForegroundColor Green
Write-Host ""
$global:site=(Get-ADReplicationSite -Filter *).name
$global:site

$global:sitecheck=Read-Host "Select the name of the site into which you want to add new DC"
Write-Host ""
Write-Host ""
            if ($site -cnotcontains $sitecheck)
            {
                Write-Host ""
                Write-Host "Site $sitecheck does not exist" -ForegroundColor Red
                Write-Host ""
                Write-Host "Please enter name of site again"
                site1
            }

            }


function installad {
Write-Host "Instaling role AD.... wait"
Install-WindowsFeature -name AD-Domain-Services -IncludeManagementTools -WarningAction SilentlyContinue > $null
Write-Host "installing AD"

Import-Module ADDSDeployment
$global:domanname=(Get-ADDomain).dnsroot
#$global:domanname.dnsroot
Write-Host "-----Add a domain controller $global:domanname to domain------- only FULL DC"
}


function show{
Write-Host "



Install-ADDSDomainController `
-NoGlobalCatalog:$false `
-CreateDnsDelegation:$false `
-CriticalReplicationOnly:$false `
-DatabasePath "C:\Windows\NTDS" `
-DomainName "$domanname" `
-InstallDns:$true `
-LogPath "C:\Windows\NTDS" `
-NoRebootOnCompletion:$false `
-ReplicationSourceDC $selectdc `
-SiteName $sitecheck `
-SysvolPath "C:\Windows\SYSVOL" `
-Force:$true

"

        For ($c=0; $c -le 15; $c++) { 
        
         Write-host "*" -foregroundcolor "green" -nonewline 

        Start-Sleep -s 1 

        } 
        Write-Host ""
}


function install
{
Install-ADDSDomainController `
-NoGlobalCatalog:$false `
-CreateDnsDelegation:$false `
-CriticalReplicationOnly:$false `
-DatabasePath "C:\Windows\NTDS" `
-DomainName "$domanname" `
-InstallDns:$true `
-LogPath "C:\Windows\NTDS" `
-NoRebootOnCompletion:$false `
-ReplicationSourceDC $selectdc `
-SiteName $sitecheck `
-SysvolPath "C:\Windows\SYSVOL" `
-Force:$true
}

            autoremove
            installad
            site1
            finddc1
            show
            install





