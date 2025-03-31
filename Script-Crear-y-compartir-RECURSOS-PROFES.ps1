# Crear la carpeta 'RECURSOS-PROFES' dentro de 'RECURSOS'
$carpetaProfes = "C:\RECURSOS\RECURSOS-PROFES"
New-Item -Path $carpetaProfes -ItemType Directory -Force

# Compartir la carpeta 'RECURSOS-PROFES' con el nombre 'RECURSOS-PROFES'
New-SmbShare -Name "RECURSOS-PROFES" -Path $carpetaProfes -FullAccess "MISTIK\gProfes" -ReadAccess "MISTIK\gAlumnos" -Description "Carpeta de RECURSOS compartida para Profes y Alumnos"

# Configurar permisos NTFS
$acl = Get-Acl $carpetaProfes

# Limpiar permisos heredados
$acl.SetAccessRuleProtection($true, $false)

# Definir permisos para gProfes (Control Total)
$permisoProfes = New-Object System.Security.AccessControl.FileSystemAccessRule("MISTIK\gProfes", "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")

# Definir permisos para gAlumnos (Solo lectura)
$permisoAlumnos = New-Object System.Security.AccessControl.FileSystemAccessRule("MISTIK\gAlumnos", "ReadAndExecute", "ContainerInherit,ObjectInherit", "None", "Allow")

# Agregar permisos al ACL
$acl.SetAccessRule($permisoProfes)
$acl.SetAccessRule($permisoAlumnos)

# Aplicar los permisos a la carpeta
Set-Acl -Path $carpetaProfes -AclObject $acl

Write-Output "Carpeta compartida y permisos NTFS configurados correctamente."
