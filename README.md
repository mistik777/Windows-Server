# 💻 Windows-Server instalación mediante cmdlets en PowerShell

Los siguientes scripts son para instalar Active Directory en un equipo con Windows Server, promover a controlador de dominio y crear la estructura de la imagen mediante cmdlets de PowerShell.

# 👷‍♀️ Dominio y DC

dominio: **mistik.edu**
controlador dominio: **dc01.mistik.edu**

# 🛣️ Pasos:

- Pemitir ejecución de scripts en PowerShell:
  ````
  Set-ExecutionPolicy Unrestricted -Force
  ````
- Instalar la característica AD-Domain-Services:
  ````
  Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
  ````
- Instalar Active Directory como dominio mistik.edu

````
https://github.com/mistik777/Windows-Server/blob/main/Script-instalar-Active-Directory-como-dominio-mistik-edu.sh
````

- Configuración Post-Instalación de Active Directory (UOs, grupos, usuarios…)
- Crear directorio Perfiles, compartirlo y ocultarlo$
- Crear y compartir RECURSOS PROFES para que gProfes tengan acceso total y gAlumn solo leer
- Crear y compartir RECURSOS ALUMNO para que gProfes y gAlumnos tengan acceso total

# 🗺️ Esquema:
<img src="https://raw.githubusercontent.com/mistik777/windows-server/refs/heads/main/estructura-cliente-servidor-windows-server.webp">
