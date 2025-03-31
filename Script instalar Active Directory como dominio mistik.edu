#
# Script de Windows PowerShell para implementación de AD DS en mistik.edu
#

# Importar módulo de Active Directory Deployment Services
Import-Module ADDSDeployment -ErrorAction Stop

# Configurar contraseña segura para el Administrador de Modo Seguro
$SafeModeAdminPassword = ConvertTo-SecureString "123QWEasd" -AsPlainText -Force

# Instalar el bosque de Active Directory
Install-ADDSForest `
    -CreateDnsDelegation:$false `
    -DatabasePath "C:\Windows\NTDS" `
    -DomainMode "WinThreshold" `
    -DomainName "mistik.edu" `
    -DomainNetbiosName "MISTIK" `
    -ForestMode "WinThreshold" `
    -InstallDns:$true `
    -LogPath "C:\Windows\NTDS" `
    -SysvolPath "C:\Windows\SYSVOL" `
    -NoRebootOnCompletion:$false `
    -SafeModeAdministratorPassword $SafeModeAdminPassword `
    -Force:$true

# Reiniciar el servidor tras la instalación
Write-Host "Reiniciando el servidor en 10 segundos..."
Start-Sleep -Seconds 10
Restart-Computer -Force
