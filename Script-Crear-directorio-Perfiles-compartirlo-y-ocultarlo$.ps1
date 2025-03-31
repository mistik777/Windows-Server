# Crear la carpeta 'perfiles' en C:\
$carpeta = "C:\perfiles"
New-Item -Path $carpeta -ItemType Directory -Force

# Compartir y OCULTAR la carpeta 'perfiles' con el nombre 'perfiles$'
$compartirNombre = "perfiles$"
New-SmbShare -Name $compartirNombre -Path $carpeta -FullAccess "MISTIK\Usuarios del dominio" -Description "Carpeta de perfiles compartida"

# Establecer permisos de control total para los usuarios del dominio "MISTIK\Usuarios del dominio"
$acl = Get-Acl $carpeta
$permiso = New-Object System.Security.AccessControl.FileSystemAccessRule("MISTIK\Usuarios del dominio", "FullControl", "ContainerInherit, ObjectInherit", "None", "Allow")
$acl.AddAccessRule($permiso)
Set-Acl -Path $carpeta -AclObject $acl

# Mostrar la ruta de acceso de red
$ipServidor = (Get-NetIPAddress | Where-Object { $_.AddressFamily -eq "IPv4" }).IPAddress[0]
$rutaRed = "\\$ipServidor\perfiles$"
Write-Output "Ruta de acceso de red: $rutaRed"
