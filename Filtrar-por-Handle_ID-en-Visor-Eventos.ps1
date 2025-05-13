# Mostrar tabla de eventos comunes relacionados con handles
Write-Host "`nEventos relacionados con handles"
Write-Host "ID Evento`tDescripción`t`tCategoría"
Write-Host "---------`t-----------------------------`t-------------------------"
@"
4656    Se ha solicitado acceso a un objeto      Acceso a objetos
4660    Se ha eliminado un objeto                Acceso a objetos
4663    Se ha accedido a un objeto               Acceso a objetos
4658    Se ha cerrado el identificador de un objeto Acceso a objetos
"@ | Write-Host

# Solicitar el handle al usuario
$handle = Read-Host "`nIntroduce el handle que deseas buscar (ejemplo: 0x0000000000000004)"

# Validar si el handle está en formato hexadecimal
if (-not $handle -match '^0x[0-9A-Fa-f]+$') {
    Write-Host "El valor introducido no es un handle válido en formato hexadecimal (ejemplo: 0x0000000000000004)." -ForegroundColor Red
    exit
}

# Opcional: permitir ajustar días hacia atrás
$days = Read-Host "¿Cuántos días atrás quieres buscar? (Por defecto: 1)"
if (-not [int]::TryParse($days, [ref]0)) {
    $days = 1
}

# Buscar eventos relacionados con el handle
Write-Host "`nBuscando eventos relacionados con el handle $handle en los últimos $days día(s)...`n"

try {
    $events = Get-WinEvent -FilterHashtable @{
        LogName = 'Security';
        Id = 4656, 4660, 4663, 4658;
        StartTime = (Get-Date).AddDays(-[int]$days)
    } | Where-Object { $_.Message -match "$handle" }

    if ($events) {
        foreach ($event in $events) {
            Write-Host "`nFecha y hora: $($event.TimeCreated)"
            Write-Host "Mensaje del evento:"
            Write-Host $event.Message
            Write-Host "-----------------------------------------------"

            # Extraer información adicional del mensaje
            $nombreCuenta = "No disponible"
            $dominioCuenta = "No disponible"
            $nombreObjeto = "No disponible"

            if ($event.Message -match "Nombre de cuenta:\s+([^\r\n]+)") {
                $nombreCuenta = $matches[1]
            }

            if ($event.Message -match "Dominio de cuenta:\s+([^\r\n]+)") {
                $dominioCuenta = $matches[1]
            }

            if ($event.Message -match "Nombre de objeto:\s+([^\r\n]+)") {
                $nombreObjeto = $matches[1]
            }

            # Mostrar información resumida al final
            Write-Host "`nInformación resumida:"
            Write-Host "Nombre de cuenta: $nombreCuenta"
            Write-Host "Dominio de cuenta: $dominioCuenta"
            Write-Host "Nombre de objeto: $nombreObjeto"
            Write-Host "==============================================="
        }
    } else {
        Write-Host "No se encontraron eventos para el handle $handle en los últimos $days día(s)." -ForegroundColor Yellow
    }
} catch {
    Write-Host "Error al recuperar los eventos. Asegúrate de tener permisos de administrador y que el registro exista." -ForegroundColor Red
}
