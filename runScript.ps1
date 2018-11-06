$path = "\\secured\share\"
$scriptPath="c:\path\to\script\add-local-admins.ps1"
$file1=Get-Content $path"!users.txt"
$comps=get-content $path"!hosts.txt"
foreach ($line1 in $file1)
{	
	$file+=$line1+"`n"
}
foreach ($comp in $comps)
{
	if ($comp -ne "")
	{
		$comp=$comp.trim()
		try
		{
			Invoke-Command -ComputerName $comps -FilePath $scriptPath -argumentlist $file -errorAction Stop | out-file $path$comp".txt"
		}
		catch
		{
			$errors="computer $comp is unavailable over winrm"
			write-host "computer $comp is unavailable over winrm" 
			$date=get-date
			add-content $path"!errors.txt" $date" "$errors
		}
	}
}