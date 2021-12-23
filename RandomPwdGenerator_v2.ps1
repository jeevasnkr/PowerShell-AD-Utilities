<#
.MODIFICATION DATE
Dec 18, 2021

.AUTHOR/CONTACT INFORMATION
jeevasnkr@gmail.com 

.DESCRIPTION
The purpose of this script is to create a random complex password 
- Generate a random passwords, with the provision to input the length of password. Letters will be preferred twice as more as signs or numbers as there are alomst twice as many letters.


.SYNTAX
.\RandomPwdGenerator_v2.ps1
 #>


#Initializing variables and accepting inputs
$ErrorActionPreference = "SilentlyContinue"

#Function to check if input is valid 
function Is-Numeric ($Value) {
    return $Value -match "^[\d\.]+$"
}

#Function to create a new complex password
function Get-Password   
	{
	$PwdLength = $Length 
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

$Length = Read-Host -Prompt "Enter the length of passwords to be generated"  
$Input1 = Is-Numeric $Length  


if($Input1 -eq 'TRUE' )
    {
    $Pwd = Get-Password 
	Write-Host $Pwd
    Write-Host "Activity Completed " 
    } 

else
    {
    Write-Host "Invalid Input. Exiting..."
	}

Read-Host -Prompt "Press Enter to exit..."



 
 
