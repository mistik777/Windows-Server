# 💻 Windows-Server instalación mediante cmdlets en PowerShell

Los siguientes scripts son para instalar Active Directory en un equipo con Windows Server, promover a controlador de dominio y crear la estructura de la imagen mediante cmdlets de PowerShell.

# 👷‍♀️ Dominio y DC

dominio: **mistik.edu**
controlador dominio: **dc01.mistik.edu**

# 🛣️ Pasos:

- Pemitir ejecución de scripts en PowerShell:
- Instalar la característica AD-Domain-Services:
- Instalar Active Directory como dominio mistik.edu
- Configuración Post-Instalación de Active Directory (UOs, grupos, usuarios…)
- Crear directorio Perfiles, compartirlo y ocultarlo$
- Crear y compartir RECURSOS PROFES para que gProfes tengan acceso total y gAlumn solo leer
- Crear y compartir RECURSOS ALUMNO para que gProfes y gAlumnos tengan acceso total
