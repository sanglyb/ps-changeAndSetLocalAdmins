param([string]$file1)
$errors=""
$ipaddress=(gwmi Win32_NetworkAdapterConfiguration| ?{$_.ipenabled}).IPAddress
$computername=get-childitem env:computername
$date=get-date
$computername=$computername.value
$ipaddress=$ipaddress[0]
$head=$computername+" "+$ipaddress+" "+$date
write-output $head
$langCheckRu=net localgroup Администраторы 2> $null
if ($langCheckRu -ne $null)
{
	$groupname="Администраторы"
}
else
{
	$groupname="Administrators"
}
$file=@()
$file=$file1.split("`n")
foreach ($line in $file)
{
	if ($line -ne "")
	{
		$errors=$null
		$username,$password=$line -split ',',2
		$username=$username.trim()
		$password=$password.trim()
		$usercheck=$null
		$usercheck = net user $username 2> $null
		if ($usercheck -eq $null)
		{
			if (($username -ne "Администратор") -and ($username -ne "Administrator"))
			{
				$errors=net user $username $password /add > $null
				if ($errors -ne $null)
				{
					$errors=$errors+"errors during adding user, username - "+$username
					write-output $errors
				}
				else 
				{
					$message=$username+" - "+$password
					write-output $message
				}
			}
		}
		else
		{		
			$errors=net user $username $password > $null
			if ($errors -ne $null)
				{
					$errors=$errors+"errors during changing password for username - "+$username + "`n"
					write-output $errors
				}
			else 
			{
				$message=$username+" - "+$password
				write-output $message
			}
		}
		net localgroup $groupname $username /add > $null 2>&1
	}
}
