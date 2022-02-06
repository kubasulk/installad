<#    DESCRIPTION            Developer: Kuba            License: Free for private use only            Creating sites, subnet, OU            v.1#>

$ErrorActionPreference = ‘SilentlyContinue’
Import-Module ActiveDirectory




function autologon {Write-Host ""Write-Host "8. Removing autologin function" -ForegroundColor GreenWrite-Host ""Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name AutoAdminLogon  -Value "0"Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name ForceAutoLogon  -Value "0"
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



 function upn1{   $global:checkupn=Get-adforest | select UPNSuffixes -ExpandProperty UPNSuffixes$global:checkupn1=$null$global:upnname=Read-Host "enter name of upn" $cif ($global:upnname -like "*.*"){                  if ($global:checkupn -notcontains $global:upnname)

                {
                Write-Host "upn was created"
                Get-ADForest | Set-ADForest -UPNSuffixes @{add=$global:upnname}
                $global:checkupn1=Get-adforest | select UPNSuffixes -ExpandProperty UPNSuffixes

                }                else {Write-Host "this upn exist"}                }            else{upn1}}


function upn{

Write-Host ""Write-Host "13. Creating UPN" -ForegroundColor GreenWrite-Host ""

do{



$global:upncount= [int]

$global:upncount=Read-Host "How many UPN-s would you like to create?"
$global:upncount = $global:upncount -as [int]

if ($global:upncount -is [int]){

        For ($c=1; $c -le $global:upncount; $c++) { 

     do{upn1        }until ([bool]$global:checkupn1 -contains $global:upnname)
}

         }

else {Write-Host "Only int"}
}until ($global:upncount -ge 0)
        } 


function site{

Write-Host ""Write-Host "9. Creating sites" -ForegroundColor GreenWrite-Host ""
set-ADReplicationSiteLink -Identity DEFAULTIPSITELINK -ReplicationFrequencyInMinutes 15
do{



$sitecount= [int]

$sitecount=Read-Host "How many sites would you like to create?"
$sitecount = $sitecount -as [int]

if ($sitecount -is [int]){

        For ($c=1; $c -le $sitecount; $c++) { 

     do{$checksite1=$null$checksite=(Get-ADReplicationSite -Filter *).name$global:sitename=Read-Host "enter name of site" $c    if ($checksite -notcontains $global:sitename)

{
Write-Host "site was created"
New-ADReplicationSite -Name $sitename
Set-ADReplicationSiteLink -Identity "DEFAULTIPSITELINK" -SitesIncluded @{add=$sitename}

$checksite1=Get-ADReplicationSite -Identity $sitename
}else {Write-Host "this site exist"}        }until ([bool]$checksite1.Name -eq $true)
}

         }

else {Write-Host "Only int"}
}until ($sitecount -ge 0)
        } 

      

function ou {

Write-Host ""Write-Host "10. Creating OUs" -ForegroundColor GreenWrite-Host ""

New-ADOrganizationalUnit -Name "administration" -ProtectedFromAccidentalDeletion:$true    

New-ADOrganizationalUnit -Name "Tier 0" -path "OU=administration,$namedc" -ProtectedFromAccidentalDeletion:$true
New-ADOrganizationalUnit -Name "Servers" -path "ou=Tier 0,OU=administration,$namedc" -ProtectedFromAccidentalDeletion:$true
New-ADOrganizationalUnit -Name "Accounts" -path "ou=Tier 0,OU=administration,$namedc" -ProtectedFromAccidentalDeletion:$true
New-ADOrganizationalUnit -Name "Groups" -path "ou=Tier 0,OU=administration,$namedc" -ProtectedFromAccidentalDeletion:$true


New-ADOrganizationalUnit -Name "Tier 1" -path "OU=administration,$namedc" -ProtectedFromAccidentalDeletion:$true
New-ADOrganizationalUnit -Name "Severs" -path "ou=Tier 1,OU=administration,$namedc" -ProtectedFromAccidentalDeletion:$true
New-ADOrganizationalUnit -Name "Accounts" -path "ou=Tier 1,OU=administration,$namedc" -ProtectedFromAccidentalDeletion:$true
New-ADOrganizationalUnit -Name "Groups" -path "ou=Tier 1,OU=administration,$namedc" -ProtectedFromAccidentalDeletion:$true

New-ADOrganizationalUnit -Name "Tier 2" -path "OU=administration,$namedc" -ProtectedFromAccidentalDeletion:$true
New-ADOrganizationalUnit -Name "Accounts" -path "ou=Tier 2,OU=administration,$namedc" -ProtectedFromAccidentalDeletion:$true
New-ADOrganizationalUnit -Name "Groups" -path "ou=Tier 2,OU=administration,$namedc" -ProtectedFromAccidentalDeletion:$true



Write-Host "Creating OU wait 5s"

        For ($c=0; $c -le 5; $c++) { 

        Write-host "." -foregroundcolor "red" -nonewline 

        Start-Sleep -s 1 

        } 
}


 function chsite {
 $checksite=(Get-ADReplicationSite -Filter *).name



 Write-Host ""Write-Host "11. Changing name of site Default-First-Site-Name" -ForegroundColor GreenWrite-Host ""
$checksite1=(Get-ADReplicationSite -Filter *).name
$renamesite=Read-Host "Would you like to change name of Default-First-Site-Name y/n"
if ($renamesite -eq "y")
{
Write-Host ""
Write-Host ""
Write-Host ""



$global:sitedefault=Get-ADObject -SearchBase (Get-ADRootDSE).ConfigurationNamingContext -filter "name -eq 'Default-First-Site-Name'" 
        if (!$sitedefault){
            write-host "name of site  "Default-First-Site-Name" doesn't exist"
             

            }
                    else
                    {
                     do {
                    $entername=read-host "enter new name of site Default-First-Site-Name"
                    
                    if ($checksite -notcontains $entername){

                    $sitedefault | Rename-ADObject -NewName $entername
                    write-host "Name was changed"
                    $checksite1=Get-ADReplicationSite -Identity $entername
                                                                 }
                                                                 else {Write-Host "This name exist"}
                                                                 } until ([bool]$checksite1.name -eq $true)

                    }}
else{
Write-Host "Name will be not change"
}

}


function network{
Write-Host ""Write-Host "12. Creating subnets" -ForegroundColor GreenWrite-Host ""

do{

$networkcount= [int]

$networkcount=Read-Host "how many subnet would you like create?"
$networkcount=$networkcount -as [int]
if ($networkcount -is [int]){

Write-Host ""
Write-Host "Available sites" -ForegroundColor green
Write-Host ""
$checksite=(Get-ADReplicationSite -Filter *).name
$checksite




        For ($d=1; $d -le $networkcount; $d++) { 
        Write-Host ""
        do
        {
        
        
        $tr=""
         $selectsite=""
         $entersubnet=""
         $checksite=(Get-ADReplicationSite -Filter *).name
         $checksubnet=(Get-ADReplicationSubnet -Filter *).name
        $selectsite=Read-Host "Select a site"
        Write-Host ""

        $entersubnet=Read-Host "Enter subnet e.q 10.0.0.0/24" $d


        if (($checksubnet -cnotcontains$entersubnet) -and ($checksite -ccontains $selectsite))
        {
        
 try { 

           New-ADReplicationSubnet -Name $entersubnet -Site $selectsite
           Write-Host "Subnet was created" -ForegroundColor Green
        }        catch { Write-Host "Incorrect  subnet or site" -ForegroundColor Red }



        

        $tr=Get-ADReplicationSubnet -Identity $entersubnet
        }

        else {
        Write-Host "Incorrect  subnet or site" -ForegroundColor Red
        }
        
        }   until ([bool]$tr.Name -eq $true)

}
}
else {Write-Host "Only int"}
}until ($networkcount -ge 0)
}


function ending{
Write-Host ""Write-Host "13. END" -ForegroundColor GreenWrite-Host ""
Write-Host "END:) THX!"
        For ($c=0; $c -le 10; $c++) { 

        Write-host "*" -foregroundcolor "red" -nonewline 

        Start-Sleep -s 1 

        } 
        Write-Host ""
        Write-Host ""
        Write-Host ""
        Write-Host ""
        }



autologon
site
ou
chsite
network
upn

end