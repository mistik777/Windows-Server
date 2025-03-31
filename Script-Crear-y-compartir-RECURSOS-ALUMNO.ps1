# Crear la carpeta 'RECURSOS-ALUMNO' dentro de 'RECURSOS'
$carpetaAlumno = "C:\RECURSOS\RECURSOS-ALUMNO"
New-Item -Path $carpetaAlumno -ItemType Directory -Force

# Compartir la carpeta 'RECURSOS-ALUMNO' con el nombre 'RECURSOS-ALUMNO'
New-SmbShare -Name "RECURSOS-ALUMNO" -Path $carpetaAlumno -FullAccess "MISTIK\gProfes", "MISTIK\gAlumnos" -Description "Carpeta de RECURSOS compartida para Profes y Alumnos con Control Total"

# Configurar permisos NTFS
$acl = Get-Acl $carpetaAlumno

# Limpiar permisos heredados
$acl.SetAccessRuleProtection($true, $false)

# Definir permisos para gProfes (Control Total)
$permisoProfes = New-Object System.Security.AccessControl.FileSystemAccessRule("MISTIK\gProfes", "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")

# Definir permisos para gAlumnos (Control Total)
$permisoAlumnos = New-Object System.Security.AccessControl.FileSystemAccessRule("MISTIK\gAlumnos", "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")

# Agregar permisos al ACL
$acl.SetAccessRule($permisoProfes)
$acl.SetAccessRule($permisoAlumnos)

# Aplicar los permisos a la carpeta
Set-Acl -Path $carpetaAlumno -AclObject $acl

Write-Output "Carpeta compartida y permisos NTFS configurados correctamente para Profes y Alumnos."
