# build-libros.ps1 — assemble libros.html from the notes tree
# Usage: powershell -File build-libros.ps1   (rebuild after any note/synthesis change)
$ErrorActionPreference = 'Stop'
$root  = Split-Path $PSScriptRoot -Parent
$notes = Join-Path $root 'notes'
$content = Join-Path $root 'content'
$research = Join-Path $content 'research'
$out   = Join-Path $root 'libros.html'

# Display metadata per book folder (add a line when a new book is processed)
# section: 'reality' (Reality & Physics) | 'mind' (Mind & Meaning). bridge: straddles both.
# demoted: kept as an appendix summary, not shown as a shelf book.
$bookMeta = @{
    'holographic-universe' = @{ title = 'The Holographic Universe'; author = 'Michael Talbot'; year = '1991'; shelf = 'reality'; section = 'reality' }
    'simulation-hypothesis' = @{ title = 'The Simulation Hypothesis'; author = 'Rizwan Virk'; year = '2019'; shelf = 'reality'; section = 'reality' }
    'power-of-now' = @{ title = 'Practicing the Power of Now'; author = 'Eckhart Tolle'; year = '2001'; shelf = 'practice'; section = 'mind' }
    'my-big-toe' = @{ title = 'My Big TOE'; author = 'Thomas Campbell'; year = '2007'; shelf = 'reality'; section = 'reality' }
    'zen-motorcycle' = @{ title = 'Zen and the Art of Motorcycle Maintenance'; author = 'Robert M. Pirsig'; year = '1974'; shelf = 'practice'; section = 'mind' }
    'american-cosmic' = @{ title = 'American Cosmic'; author = 'D.W. Pasulka'; year = '2019'; shelf = 'reality'; section = 'reality'; bridge = $true }
    'dark-psychology' = @{ title = 'Dark Psychology and Manipulation'; author = 'William Cooper'; year = '2024'; shelf = 'practice'; section = 'mind'; demoted = $true }
    'sekret-machines-war' = @{ title = 'Sekret Machines 3: War'; author = 'DeLonge & Levenda'; year = '2024'; shelf = 'reality'; section = 'reality'; bridge = $true }
    'sekret-machines-gods' = @{ title = 'Sekret Machines 1: Gods'; author = 'DeLonge & Levenda'; year = '2017'; shelf = 'reality'; section = 'reality'; bridge = $true }
    'sekret-machines-man' = @{ title = 'Sekret Machines 2: Man'; author = 'DeLonge & Levenda'; year = '2018'; shelf = 'reality'; section = 'reality'; bridge = $true }
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
    if ($meta.demoted) { continue }   # kept on disk, surfaced only as an appendix summary
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
            concepts = @($n.fm.concepts | Where-Object { $_ })
            people   = @($n.fm.people | Where-Object { $_ })
            body     = $n.body
        }
    }
    if ($docs.Count -gt 0) {
        $books += [ordered]@{
            id = $dir.Name; title = $meta.title; author = $meta.author; year = $meta.year; shelf = $meta.shelf
            section = $meta.section; bridge = [bool]$meta.bridge; demoted = [bool]$meta.demoted
            docs = $docs
        }
    }
}
if ($books.Count -eq 0) { throw "No notes found under $notes" }

$atlasPath = Join-Path $content 'concept-atlas.json'
if (-not (Test-Path $atlasPath)) { throw "Concept atlas not found: $atlasPath" }
$atlas = @()
foreach ($hub in ([System.IO.File]::ReadAllText($atlasPath) | ConvertFrom-Json)) {
    $atlas += $hub
}

$dossiers = @()
foreach ($f in (Get-ChildItem $research -Filter '*.md' | Sort-Object Name)) {
    $n = Parse-Note $f.FullName
    if (-not $n.fm.id) { throw "Research dossier is missing an id: $($f.FullName)" }
    $dossiers += [ordered]@{
        id          = $n.fm.id
        title       = $n.fm.title
        eyebrow     = $n.fm.eyebrow
        description = $n.fm.description
        topics      = @($n.fm.topics | Where-Object { $_ })
        body        = $n.body
    }
}

# Cross-domain extras: curated debates + disclosed bridges (Reality <-> Mind)
$debates = @()
$bridges = @()
$linksPath = Join-Path $content 'atlas-links.json'
if (Test-Path $linksPath) {
    $links = [System.IO.File]::ReadAllText($linksPath) | ConvertFrom-Json
    if ($links.debates) { $debates = @($links.debates) }
    if ($links.bridges) { $bridges = @($links.bridges) }
}

# Appendix summaries: demoted books, kept as a condensed reference (not shelf books)
$appendix = @()
foreach ($f in (Get-ChildItem $content -Filter 'appendix-*.md' | Sort-Object Name)) {
    $n = Parse-Note $f.FullName
    if (-not $n.fm.id) { throw "Appendix summary is missing an id: $($f.FullName)" }
    $appendix += [ordered]@{
        id      = $n.fm.id
        title   = $n.fm.title
        author  = $n.fm.author
        year    = $n.fm.year
        hub     = $n.fm.hub
        summary = $n.fm.summary
        body    = $n.body
    }
}

$payload = [ordered]@{
    built    = (Get-Date -Format 'yyyy-MM-dd HH:mm')
    books    = $books
    atlas    = $atlas
    dossiers = $dossiers
    debates  = $debates
    bridges  = $bridges
    appendix = $appendix
}
$json = ConvertTo-Json $payload -Depth 10 -Compress
$json = $json -replace '</', '<\/'   # keep </script> sequences from closing the data block

$template = [System.IO.File]::ReadAllText((Join-Path $PSScriptRoot 'libros-template.html'))
$html = $template.Replace('/*__DATA__*/', $json)
$enc = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllText($out, $html, $enc)
[System.IO.File]::WriteAllText((Join-Path $root 'index.html'), $html, $enc)   # same site, GitHub Pages entrypoint
"built $out + index.html ($([Math]::Round((Get-Item $out).Length/1KB)) KB) - $($books.Count) book(s), $(@($books | ForEach-Object { $_.docs }).Count) docs"
