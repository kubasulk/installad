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
<br><br>
third-step.ps1
<br>
![3](https://user-images.githubusercontent.com/99129741/152691212-efa76bb1-80b0-40a6-b448-6b7e194d7a3f.PNG)
<br><br>    
DC02<br>    
2-first-step.ps1<br>    
![1-dc2](https://user-images.githubusercontent.com/99129741/152703481-46b9e45a-e1fa-479d-8375-a8d8b374a773.PNG)
<br><br>
2-second-step<br>

![2-dc2](https://user-images.githubusercontent.com/99129741/152704930-4e2b06cb-3dd9-4ac9-af67-6708e5375801.PNG)
