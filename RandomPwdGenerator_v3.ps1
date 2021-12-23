<#
.MODIFICATION DATE
Dec 18, 2021

.AUTHOR/CONTACT INFORMATION
jeevasnkr@gmail.com 

.DESCRIPTION
The purpose of this script is to create a random complex password 
- Generate a random 30 char long passwords. Letters will be preferred twice as more as signs or numbers as there are alomst twice as many letters.
- Can generate random 30 char long passwords. Takes number of passwords to be genenrated, as input.

.SYNTAX
.\RandomPwdGenerator_v3.ps1
 #>


#Initializing variables and accepting inputs
$OutputFile = $PSScriptRoot + "\RandomPwdGenerator\RandomPwdGenerator_Outputs.csv"
$ErrorActionPreference = "SilentlyContinue"
$Passwords= @() 

#Function to create unique directories  
function Create-UniqueDirectory($FolderName) 
    {
    $Path = "$PSScriptRoot" + "\$FolderName"
    if ((-not (Test-Path -LiteralPath $Path)))
        {
        New-Item -Path $PSScriptRoot -ItemType Directory -Name $FolderName -ErrorAction Stop | Out-Null
        Write-Log ("Successfully created directory $Path")
        }
    else 
        {
        Write-Log ("Directory $FolderName already exists")
        }
    return
    }


#Function to check if input is valid 
function Is-Numeric ($Value) {
    return $Value -match "^[\d\.]+$"
}



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

Create-UniqueDirectory "RandomPwdGenerator"

$Number = Read-Host -Prompt "Enter the number of passwords to be generated"  

$Input = Is-Numeric $Number  

if($Input -eq 'TRUE')
    {
    Write-Host "Creating $Number passwords" 
    $Count =  1 
    while ($Count -le $Number) 
        {
        $Pwds = New-Object PSObject
        $Pwd = Get-Password 
        $Pwds| Add-Member -MemberType NoteProperty -Name "Sl No." -Value "$Count"
        $Pwds| Add-Member -MemberType NoteProperty -Name "Password" -Value "$Pwd"
        $Passwords += $Pwds 
        $Count ++
        }
    $Passwords | Export-Csv -Path $OutputFile -Append -NoTypeInformation 
    Write-Host "Activity Completed " 
    }

else
    {
    Write-Host "Invalid Input. Exiting..."
    }

 
 
