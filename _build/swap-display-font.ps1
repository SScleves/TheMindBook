# Swaps the display font from Fraunces to Orbitron (embedded base64).
$ErrorActionPreference = 'Stop'
$dir = Join-Path $PSScriptRoot 'fonts'
$tplPath = Join-Path $PSScriptRoot 'libros-template.html'

$b64 = [Convert]::ToBase64String([IO.File]::ReadAllBytes((Join-Path $dir 'orbitron-normal.woff2')))
$orb = "@font-face{font-family:'Orbitron';font-style:normal;font-weight:400 900;font-display:swap;src:url(data:font/woff2;base64,$b64) format('woff2')}"

$tpl = [IO.File]::ReadAllText($tplPath)
if ($tpl.Contains("font-family:'Orbitron'")) { Write-Host 'Orbitron already embedded; nothing to do.'; return }

$rx = [regex]"@font-face\{font-family:'Fraunces';[^\r\n]*?format\('woff2'\)\}"
if (-not $rx.IsMatch($tpl)) { throw 'Fraunces @font-face rule not found' }
$tpl = $rx.Replace($tpl, { param($m) $orb }, 1)
$tpl = $tpl.Replace('    --display: "Fraunces", Baskerville, "Iowan Old Style", Palatino, Georgia, serif;', '    --display: "Orbitron", "Space Grotesk", "Segoe UI", system-ui, sans-serif;')

[IO.File]::WriteAllText($tplPath, $tpl, (New-Object System.Text.UTF8Encoding($false)))
$faces = ([regex]::Matches($tpl, "@font-face\{font-family:'([^']+)'") | ForEach-Object { $_.Groups[1].Value }) -join ', '
Write-Host "Swapped display -> Orbitron. Faces now: $faces"
