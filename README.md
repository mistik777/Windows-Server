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
[Script-instalar-Active-Directory-como-dominio-mistik.edu](Script-instalar-Active-Directory-como-dominio-mistik-edu.ps1)  
- Configuración Post-Instalación de Active Directory (UOs, grupos, usuarios…)  
[Script-de-Configuracion-Post-Instalacion-de-Active-Directory-UOs-grupos-usuarios.ps1](Script-de-Configuracion-Post-Instalacion-de-Active-Directory-UOs-grupos-usuarios.ps1)  
- Crear directorio Perfiles, compartirlo y ocultarlo$
[Crear directorio Perfiles, compartirlo y ocultarlo$](Script-Crear-directorio-Perfiles-compartirlo-y-ocultarlo$.ps1)  
- Crear y compartir RECURSOS PROFES para que gProfes tengan acceso total y gAlumn solo leer
[Crear y compartir RECURSOS PROFES](Script-Crear-y-compartir-RECURSOS-PROFES.ps1)  
- Crear y compartir RECURSOS ALUMNO para que gProfes y gAlumnos tengan acceso total
[Crear y compartir RECURSOS ALUMNO](Script-Crear-y-compartir-RECURSOS-ALUMNO.ps1)  

# 🗺️ Esquema:
<img src="https://raw.githubusercontent.com/mistik777/windows-server/refs/heads/main/estructura-cliente-servidor-windows-server.webp">
