# Install Active Directory from Powershell
Automatic install active directory


Requirements:
<BR>
<BR>
One and more clean install windows server 2k16/2k19/2k22 with default password "Pa$$w0rd"
<BR>
Create folder of name "script" on C:\. Then:
<BR>
on dc-1 run in powershell  first-step.ps1
 <BR>
on dc-2 run in powershell 2-first-step.ps1

dc-1 is for the first DC in the new forest
dc-2 is for the next DC in the existing forest


DC1
<BR>
first-step.ps1
 <BR>
![1](https://user-images.githubusercontent.com/99129741/152687952-15deed88-ff02-4d8d-8468-00e1aa6aa291.PNG)
<br><br>
second-step.ps1
<br>
![secound-step](https://user-images.githubusercontent.com/99129741/156857880-46bff241-4a8b-4d2e-be92-62ba7a9efdc9.PNG)

<br><br>
third-step.ps1
<br>
![3](https://user-images.githubusercontent.com/99129741/156859041-a30ca15c-f048-4774-ac85-2d0c7ffe8807.PNG)

<br><br>    
DC02<br>    
2-first-step.ps1<br>    

![1](https://user-images.githubusercontent.com/99129741/156860187-1337729d-dbab-4b04-8b07-1acc7eb25278.PNG)
<br><br>
2-second-step<br>


![2](https://user-images.githubusercontent.com/99129741/156860390-37b09e0f-2931-40cf-b562-6a662d983841.PNG)
  
  <br><br>
