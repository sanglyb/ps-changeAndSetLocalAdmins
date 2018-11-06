# ps-changeAndSetLocalAdmins
PowerShell scripts for adding and changing passwords for local administraotors. 

To run scripts you should run runScript.ps1. It executes script add-local-admins.ps1 on remote host. Also it gets list of computers, where to add admins or change their passwords from file !hosts.txt. It takes usernames and passwords from file !users.txt

!users.txt should be in csv format, for example something like that:
user1,Passw0rd
user2,Passw0rd
user3,Passw0rd

Each host in file !hosts.txt should be on single line, like
comp1
comp2
comp3

On remote computers must be enabled remote powershell execution.

More info in my blog - https://www.mytechnote.ru/article/skript-dlya-smeny-paroley-lokalnym-administratoram-powershell
