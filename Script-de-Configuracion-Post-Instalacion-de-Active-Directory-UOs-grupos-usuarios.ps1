#
# Script de Configuración Post-Instalación de Active Directory
#

# Importar módulo de Active Directory
Try {
    Import-Module ActiveDirectory -ErrorAction Stop
    Write-Host "Módulo Active Directory cargado correctamente."
} Catch {
    Write-Host "Error: No se pudo cargar el módulo Active Directory."
    Exit 1
}

# Crear Unidades Organizativas (OUs)
$ouPath = "DC=mistik,DC=edu"
New-ADOrganizationalUnit -Name "ASIR" -Path $ouPath -ProtectedFromAccidentalDeletion $true
New-ADOrganizationalUnit -Name "Profes" -Path "OU=ASIR,$ouPath" -ProtectedFromAccidentalDeletion $true
New-ADOrganizationalUnit -Name "Alumnos" -Path "OU=ASIR,$ouPath" -ProtectedFromAccidentalDeletion $true
New-ADOrganizationalUnit -Name "Padres" -Path "OU=ASIR,$ouPath" -ProtectedFromAccidentalDeletion $true

# Crear Grupos de Seguridad dentro de sus respectivas UOs
New-ADGroup -Name "gProfes" -GroupCategory Security -GroupScope Global -Path "OU=Profes,OU=ASIR,$ouPath"
New-ADGroup -Name "gAlumnos" -GroupCategory Security -GroupScope Global -Path "OU=Alumnos,OU=ASIR,$ouPath"

# Crear Usuarios de Prueba dentro de las UOs correctas
New-ADUser -Name "profe00" -GivenName "Profe" -Surname "00" -UserPrincipalName "profe00@mistik.edu" -SamAccountName "profe00" -Path "OU=Profes,OU=ASIR,$ouPath" -AccountPassword (ConvertTo-SecureString "123QWEasd" -AsPlainText -Force) -Enabled $true

New-ADUser -Name "alumn00" -GivenName "Alumn" -Surname "00" -UserPrincipalName "alumn00@mistik.edu" -SamAccountName "alumn00" -Path "OU=Alumnos,OU=ASIR,$ouPath" -AccountPassword (ConvertTo-SecureString "123QWEasd" -AsPlainText -Force) -Enabled $true

New-ADUser -Name "familiar00" -GivenName "Familiar" -Surname "00" -UserPrincipalName "familiar00@mistik.edu" -SamAccountName "familiar00" -Path "OU=Padres,OU=ASIR,$ouPath" -AccountPassword (ConvertTo-SecureString "123QWEasd" -AsPlainText -Force) -Enabled $true

# Agregar Usuarios a sus respectivos Grupos
Add-ADGroupMember -Identity "gProfes" -Members "profe00"
Add-ADGroupMember -Identity "gAlumnos" -Members "alumn00"

# Mensajes de confirmación
Write-Host "Implementación de Active Directory completada con éxito."
Write-Host "Se crearon las siguientes Unidades Organizativas: ASIR, Profes, Alumnos, Padres"
Write-Host "Se crearon los Grupos de Seguridad dentro de sus respectivas OUs: gProfes, gAlumnos, gPadres"
Write-Host "Se crearon los Usuarios: profe00, alumn00, familiar00"
