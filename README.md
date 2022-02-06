# Install Active Directory from Powershell
Automatic install active directory

You need to copy the all script folder to the C:\drive. and then run in powershell the "first-step.ps1" on dc-1, on dc-2 you should run in powershell 2-first-step.ps1<br>
dc-1 is for the first DC in the new forest <br>
dc-2 is for the next DC in the existing forest<br>


Requirements:<br>
One and more clean install windows server 2k16/2k19/2k22 with default password "Pa$$w0rd"

DC1
<BR>
  first-step.ps1
  <BR>
![1](https://user-images.githubusercontent.com/99129741/152687952-15deed88-ff02-4d8d-8468-00e1aa6aa291.PNG)

 <br><br>
  second-step.ps1
  <br>
  ![2](https://user-images.githubusercontent.com/99129741/152688016-b51b8c94-a8fa-4fb9-9d85-c9c647356455.PNG)
