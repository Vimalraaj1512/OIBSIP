# OASIS INFOBYTE — Task 1: Basic Nmap scanning
# Safety scope: one VM IPv4 address on a VirtualBox Host-Only network only.
# This script rejects public IPs, other subnets, the host address and ranges.

$ErrorActionPreference = 'Stop'
$ProjectRoot = $PSScriptRoot
$ResultsDir = Join-Path $ProjectRoot 'results'
New-Item -ItemType Directory -Path $ResultsDir -Force | Out-Null

function Find-NmapExecutable {
    $command = Get-Command 'nmap.exe' -ErrorAction SilentlyContinue
    if ($command) { return $command.Source }
    $candidatePaths = @(
        (Join-Path $env:ProgramFiles 'Nmap\nmap.exe'),
        'C:\Program Files (x86)\Nmap\nmap.exe'
    )
    foreach ($path in $candidatePaths) {
        if (Test-Path $path) { return $path }
    }
    throw 'Nmap not found. Install it from https://nmap.org/download.html and reopen PowerShell.'
}

function Test-PrivateIPv4 {
    param([System.Net.IPAddress]$Address)
    $text = $Address.IPAddressToString
    return (($text -match '^10\.') -or ($text -match '^192\.168\.') -or
            ($text -match '^172\.(1[6-9]|2[0-9]|3[01])\.'))
}

function Test-SameSubnetIPv4 {
    param([System.Net.IPAddress]$LocalAddress, [System.Net.IPAddress]$RemoteAddress, [int]$PrefixLength)
    if ($LocalAddress.AddressFamily -ne [System.Net.Sockets.AddressFamily]::InterNetwork -or
        $RemoteAddress.AddressFamily -ne [System.Net.Sockets.AddressFamily]::InterNetwork -or
        $PrefixLength -lt 1 -or $PrefixLength -gt 32) { return $false }
    $localBytes = $LocalAddress.GetAddressBytes()
    $remoteBytes = $RemoteAddress.GetAddressBytes()
    for ($i = 0; $i -lt 4; $i++) {
        $remaining = $PrefixLength - (8 * $i)
        if ($remaining -ge 8) { $mask = 255 }
        elseif ($remaining -le 0) { $mask = 0 }
        else { $mask = ([int]([Math]::Pow(2, $remaining) - 1)) -shl (8 - $remaining) }
        if (($localBytes[$i] -band $mask) -ne ($remoteBytes[$i] -band $mask)) { return $false }
    }
    return $true
}

$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal($identity)
if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    throw 'Open PowerShell with Run as administrator, then run this script again.'
}

$NmapExe = Find-NmapExecutable
$hostOnlyConfig = Get-NetIPConfiguration | Where-Object {
    $_.NetAdapter.Status -eq 'Up' -and $_.IPv4Address -and
    ($_.NetAdapter.InterfaceDescription -match 'VirtualBox Host-Only')
} | Select-Object -First 1
if ($null -eq $hostOnlyConfig) {
    throw 'No active VirtualBox Host-Only adapter found. Create/connect it and boot your VM first.'
}

$hostOnlyAddress = $hostOnlyConfig.IPv4Address | Select-Object -First 1
$HostOnlyIP = [System.Net.IPAddress]::Parse([string]$hostOnlyAddress.IPAddress)
$HostOnlyPrefix = [int]$hostOnlyAddress.PrefixLength

Write-Host ''
Write-Host 'Oasis Infobyte — Task 1: Basic Network Scanning with Nmap' -ForegroundColor Cyan
Write-Host "Host-Only adapter: $($hostOnlyConfig.InterfaceAlias)"
Write-Host "Windows Host-Only address: $($HostOnlyIP.IPAddressToString)/$HostOnlyPrefix"
$targetText = Read-Host 'Enter the IPv4 address of your own Kali/Ubuntu VM on this Host-Only network'
$TargetAddress = $null
if (-not [System.Net.IPAddress]::TryParse($targetText, [ref]$TargetAddress)) { throw 'Invalid IP address.' }
if ($TargetAddress.AddressFamily -ne [System.Net.Sockets.AddressFamily]::InterNetwork) { throw 'IPv4 only.' }
if (-not (Test-PrivateIPv4 -Address $TargetAddress)) { throw 'Rejected: target must be an RFC1918 private IPv4 address.' }
if ($TargetAddress.IPAddressToString -eq $HostOnlyIP.IPAddressToString) { throw 'Rejected: this is the Windows host address, not the VM.' }
if (-not (Test-SameSubnetIPv4 -LocalAddress $HostOnlyIP -RemoteAddress $TargetAddress -PrefixLength $HostOnlyPrefix)) {
    throw 'Rejected: target is not in the VirtualBox Host-Only subnet.'
}

$Target = $TargetAddress.IPAddressToString
Write-Host "Validated single VM target: $Target" -ForegroundColor Yellow
Write-Host 'Only proceed if this address belongs to the VM you created and control.'
$confirmation = Read-Host 'Type Y to confirm; any other key cancels'
if ($confirmation -notmatch '^(Y|y)$') { Write-Host 'Cancelled; no scan was run.'; exit 0 }

$basicFile = Join-Path $ResultsDir '01_basic_scan.txt'
$serviceFile = Join-Path $ResultsDir '02_service_version_scan.txt'
$osFile = Join-Path $ResultsDir '03_os_detection_scan.txt'
$xmlFile = Join-Path $ResultsDir 'service_scan.xml'
$masterFile = Join-Path $ResultsDir 'nmap_scan_results.txt'
$csvFile = Join-Path $ResultsDir 'open_ports.csv'

$scanDefinitions = @(
    @{ Label = 'Basic scan'; Args = @($Target); Output = $basicFile },
    @{ Label = 'Service-version scan'; Args = @('-sV', $Target, '-oX', $xmlFile); Output = $serviceFile },
    @{ Label = 'OS-detection scan'; Args = @('-O', $Target); Output = $osFile }
)
$report = New-Object System.Collections.Generic.List[string]
$report.Add('OASIS INFOBYTE — SECURITY ANALYST — TASK 1')
$report.Add('Basic Network Scanning with Nmap')
$report.Add("Run timestamp: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss K')")
$report.Add("Target VM: $Target")
$report.Add("Host-Only adapter: $($hostOnlyConfig.InterfaceAlias) / $($HostOnlyIP.IPAddressToString)/$HostOnlyPrefix")
$report.Add("Nmap executable: $NmapExe")
$report.Add('Scope: one VM address on the validated local VirtualBox Host-Only subnet.')
$report.Add('')

foreach ($scan in $scanDefinitions) {
    Write-Host ''
    Write-Host "=== $($scan.Label) ===" -ForegroundColor Cyan
    $argsForScan = $scan.Args
    $output = & $NmapExe @argsForScan 2>&1
    $exitCode = $LASTEXITCODE
    $outputText = @($output | ForEach-Object { [string]$_ })
    $outputText | Set-Content -Path $scan.Output -Encoding UTF8
    $report.Add("===== $($scan.Label) =====")
    $report.Add("Command: nmap $($argsForScan -join ' ')")
    $report.Add("Exit code: $exitCode")
    $report.AddRange([string[]]$outputText)
    $report.Add('')
    if ($exitCode -ne 0) { Write-Warning "$($scan.Label) returned exit code $exitCode; exact output was retained." }
}

$portRows = @()
if (Test-Path $xmlFile) {
    try {
        [xml]$xml = Get-Content -Path $xmlFile -Raw
        foreach ($port in $xml.SelectNodes('//port[state[@state="open"]]')) {
            $service = $port.SelectSingleNode('./service')
            $serviceName = 'unknown'; $productName = ''; $serviceVersion = ''; $extraInfo = ''
            if ($null -ne $service) {
                $serviceName = [string]$service.name
                $productName = [string]$service.product
                $serviceVersion = [string]$service.version
                $extraInfo = [string]$service.extrainfo
            }
            $portRows += [pscustomobject]@{
                Protocol = [string]$port.protocol; Port = [string]$port.portid; State = 'open'
                Service = $serviceName; Product = $productName; Version = $serviceVersion; ExtraInfo = $extraInfo
            }
        }
    } catch { $report.Add("XML parsing note: $($_.Exception.Message)") }
}
if ($portRows.Count -gt 0) { $portRows | Export-Csv -Path $csvFile -NoTypeInformation -Encoding UTF8 }
else { 'Protocol,Port,State,Service,Product,Version,ExtraInfo' | Set-Content -Path $csvFile -Encoding UTF8 }

$report.Add('===== OPEN PORT SUMMARY =====')
if ($portRows.Count -gt 0) {
    foreach ($row in $portRows) { $report.Add("$($row.Protocol)/$($row.Port) — $($row.Service) $($row.Product) $($row.Version) $($row.ExtraInfo)".Trim()) }
} else { $report.Add('No open ports were extracted from the service-scan XML. Review raw output; do not infer or invent ports.') }
$report.Add('')
$report.Add('Security analysis must be added manually for each real open port. Port numbers alone do not prove a vulnerability.')
$report | Set-Content -Path $masterFile -Encoding UTF8
Write-Host "Scan completed. Review actual evidence in $ResultsDir" -ForegroundColor Green
Write-Host 'Capture genuine screenshots of the terminal output.' -ForegroundColor Yellow
