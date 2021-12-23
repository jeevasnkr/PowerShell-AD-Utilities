<#
.MODIFICATION DATE
Dec 23, 2021

.AUTHOR/CONTACT INFORMATION
jeevashnkr45@gmail.com 

.DESCRIPTION
The purpose of this script is to create a random complex password 
- Generate a random 30 char long passwords. Letters will be preferred twice as more as signs or numbers as there are alomst twice as many letters.


.SYNTAX
.\RandomPwdGenerator_v1.ps1
 #>


#Initializing variables and accepting inputs
$ErrorActionPreference = "SilentlyContinue"

#Function to create a new complex password
function Get-Password   
	{
	$PwdLength = 30 
    # Defining characters for complex password 
	$UpperCase = @('A','B','C','D','E','F','G','H','J','K','M','N','P','Q','R','S','T','U','V','W','X','Y','Z')
	$LowerCase = @('a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z') 
	$Numbers = @('1','2','3','4','5','6','7','8','9','0')
	$SpecialChars = @('~','!','@','#','$','%','^','&','*','_','+','=','.','?')
    $RandomPassword = @() 
	For ($i=1; $i -le $PwdLength; $i++) # Getting characters for a new password of the required length 
		{
		If (($i % 6) -eq 0) {$RandomPassword += $UpperCase | Get-Random}
		If (($i % 6) -eq 1) {$RandomPassword += $LowerCase | Get-Random}
		If (($i % 6) -eq 2) {$RandomPassword += $Numbers | Get-Random}
		If (($i % 6) -eq 3) {$RandomPassword += $SpecialChars | Get-Random}
		If (($i % 6) -eq 4) {$RandomPassword += $UpperCase | Get-Random}
		If (($i % 6) -eq 5) {$RandomPassword += $LowerCase | Get-Random}
		}
    $ShuffledPwd = $RandomPassword | Sort-Object { Get-Random } # Shuffling the array
	$FinalPwd = (($ShuffledPwd.ToCharArray()) -join "") #Converting to string 
    return $FinalPwd #Returning the password 
	}
	

        
# <<<---------------------------Main Script--------------------------->>> 

Write-Host " "
$Pwd = Get-Password 
Write-Host $Pwd
Read-Host -Prompt "Press Enter to exit..."



 
 
