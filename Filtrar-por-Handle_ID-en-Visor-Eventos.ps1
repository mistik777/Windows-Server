# Solicitar al usuario que ingrese el Handle ID (ejemplo: 0x1fc)
$handleId = Read-Host "Introduce el Handle ID (por ejemplo: 0x1fc)"

# Validación del formato de Handle ID (debe ser hexadecimal)
if ($handleId -notmatch "^0x[0-9a-fA-F]+$") {
    Write-Host "El Handle ID debe estar en formato hexadecimal (ejemplo: 0x1fc)." -ForegroundColor Red
    exit
}

# Preguntar al usuario cuantos días hacia atrás desea buscar
$daysInput = Read-Host "¿Cuántos días atrás quieres buscar? (por defecto: 1)"
if (-not [int]::TryParse($daysInput, [ref]$null)) {
    $days = 1
} else {
    $days = [int]$daysInput
}

# Calcular la fecha de inicio para la búsqueda
$startTime = (Get-Date).AddDays(-$days)

# Mostrar mensaje al usuario
Write-Host "`nBuscando eventos con Handle ID = $handleId en los últimos $days día(s)...`n"

# Obtener eventos de 'Security' (puedes cambiarlo por otro registro si lo deseas)
try {
    $events = Get-WinEvent -FilterHashtable @{
        LogName   = 'Security'
        StartTime = $startTime
    } -ErrorAction Stop
} catch {
    Write-Host "❌ No se pudo acceder al registro de eventos 'Security'."
    Write-Host "ℹ️  Ejecuta PowerShell como **administrador** para poder acceder a estos eventos." -ForegroundColor Yellow
    exit
}

if (-not $events) {
    Write-Host "No se encontraron eventos o no hay acceso al registro." -ForegroundColor Yellow
    exit
}

# Buscar los eventos con el Handle ID especificado
$matches = @()

foreach ($event in $events) {
    try {
        $xmlRaw = $event.ToXml()
        if (-not $xmlRaw) { continue }

        $xml = [xml]$xmlRaw
        $handleField = $xml.Event.EventData.Data | Where-Object { $_.Name -eq "HandleId" }

        if ($handleField -and $handleField.'#text' -eq $handleId) {
            $data = @{}
            foreach ($item in $xml.Event.EventData.Data) {
                $data[$item.Name] = $item.'#text'
            }

            # Almacenar los eventos que coinciden
            $matches += [PSCustomObject]@{
                Fecha         = $event.TimeCreated
                EventoID      = $event.Id
                Usuario       = $data["SubjectUserName"]
                Dominio       = $data["SubjectDomainName"]
                Objeto        = $data["ObjectName"]
                TipoObjeto    = $data["ObjectType"]
                Acceso        = $data["AccessMask"]
                Proceso       = $data["ProcessName"]
                ProcesoID     = $data["ProcessId"]
                HandleId      = $data["HandleId"]
                Mensaje       = $event.Message
            }
        }
    } catch {
        continue
    }
}

# Mostrar resultados
if ($matches.Count -eq 0) {
    Write-Host "⚠️ No se encontraron eventos con HandleId $handleId." -ForegroundColor Yellow
} else {
    Write-Host "✅ Se encontraron $($matches.Count) evento(s) con HandleId $handleId.`n" -ForegroundColor Green
    foreach ($match in $matches) {
        Write-Host "----------------------------------------" -ForegroundColor Cyan
        Write-Host "Fecha:         $($match.Fecha)"
        Write-Host "Evento ID:     $($match.EventoID)"
        Write-Host "Usuario:       $($match.Usuario)"
        Write-Host "Dominio:       $($match.Dominio)"
        Write-Host "Objeto:        $($match.Objeto)"
        Write-Host "Tipo Objeto:   $($match.TipoObjeto)"
        Write-Host "Acceso:        $($match.Acceso)"
        Write-Host "Proceso:       $($match.Proceso)"
        Write-Host "ID Proceso:    $($match.ProcesoID)"
        Write-Host "HandleId:      $($match.HandleId)"
        Write-Host "`nMensaje:`n$($match.Mensaje)`n"
    }
}
