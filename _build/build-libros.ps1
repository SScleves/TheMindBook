# build-libros.ps1 — assemble libros.html from the notes tree
# Usage: powershell -File build-libros.ps1   (rebuild after any note/synthesis change)
$ErrorActionPreference = 'Stop'
$root  = Split-Path $PSScriptRoot -Parent
$notes = Join-Path $root 'notes'
$out   = Join-Path $root 'libros.html'

# Display metadata per book folder (add a line when a new book is processed)
$bookMeta = @{
    'holographic-universe' = @{ title = 'The Holographic Universe'; author = 'Michael Talbot'; year = '1991' }
    'simulation-hypothesis' = @{ title = 'The Simulation Hypothesis'; author = 'Rizwan Virk'; year = '2019' }
    'power-of-now' = @{ title = 'Practicing the Power of Now'; author = 'Eckhart Tolle'; year = '2001' }
    'my-big-toe' = @{ title = 'My Big TOE'; author = 'Thomas Campbell'; year = '2007' }
    'zen-motorcycle' = @{ title = 'Zen and the Art of Motorcycle Maintenance'; author = 'Robert M. Pirsig'; year = '1974' }
    'american-cosmic' = @{ title = 'American Cosmic'; author = 'D.W. Pasulka'; year = '2019' }
    'dark-psychology' = @{ title = 'Dark Psychology and Manipulation'; author = 'William Cooper'; year = '' }
    'sekret-machines-war' = @{ title = 'Sekret Machines 3: War'; author = 'DeLonge & Levenda'; year = '2024' }
}

function Parse-Note([string]$path) {
    $raw = [System.IO.File]::ReadAllText($path)
    $fm = @{}
    $body = $raw
    if ($raw -match '(?s)^---\r?\n(.*?)\r?\n---\r?\n(.*)$') {
        $body = $Matches[2]
        foreach ($line in ($Matches[1] -split '\r?\n')) {
            if ($line -match '^(\w[\w-]*):\s*(.*)$') {
                $k = $Matches[1]; $v = $Matches[2].Trim()
                if ($v -match '^\[(.*)\]$') { $fm[$k] = @($Matches[1] -split ',\s*' | ForEach-Object { $_.Trim() } | Where-Object { $_ }) }
                else { $fm[$k] = $v -replace '^"|"$', '' }
            }
        }
    }
    return @{ fm = $fm; body = $body }
}

$books = @()
foreach ($dir in (Get-ChildItem $notes -Directory | Sort-Object Name)) {
    $meta = $bookMeta[$dir.Name]
    if (-not $meta) { $meta = @{ title = $dir.Name; author = ''; year = '' } }
    $docs = @()
    foreach ($f in (Get-ChildItem $dir.FullName -Filter '*.md' | Sort-Object Name)) {
        $n = Parse-Note $f.FullName
        $type = if ($n.fm.type) { $n.fm.type } elseif ($f.Name -eq '00-map.md') { 'map' } else { 'chapter' }
        $title = if ($n.fm.title) { $n.fm.title } else { $f.BaseName }
        $docs += [ordered]@{
            id       = "$($dir.Name)/$($f.BaseName)"
            file     = $f.Name
            title    = $title
            type     = $type
            chapter  = if ($null -ne $n.fm.chapter) { "$($n.fm.chapter)" } else { $null }
            concepts = @($n.fm.concepts)
            people   = @($n.fm.people)
            body     = $n.body
        }
    }
    if ($docs.Count -gt 0) {
        $books += [ordered]@{
            id = $dir.Name; title = $meta.title; author = $meta.author; year = $meta.year
            docs = $docs
        }
    }
}
if ($books.Count -eq 0) { throw "No notes found under $notes" }

$json = ConvertTo-Json @{ built = (Get-Date -Format 'yyyy-MM-dd HH:mm'); books = $books } -Depth 6 -Compress
$json = $json -replace '</', '<\/'   # keep </script> sequences from closing the data block

$template = [System.IO.File]::ReadAllText((Join-Path $PSScriptRoot 'libros-template.html'))
$html = $template.Replace('/*__DATA__*/', $json)
[System.IO.File]::WriteAllText($out, $html, (New-Object System.Text.UTF8Encoding $false))
"built $out ($([Math]::Round((Get-Item $out).Length/1KB)) KB) - $($books.Count) book(s), $(@($books | ForEach-Object { $_.docs }).Count) docs"
