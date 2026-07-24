# split-sm-man.ps1 -- split Sekret Machines: Man directly from its EPUB.
# Keeps prologue, each section introduction, all 15 chapters, appendix, and
# source lists. Section title dividers, index, title, and copyright are excluded.
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression.FileSystem | Out-Null
Add-Type -AssemblyName System.Web | Out-Null

$root = Split-Path $PSScriptRoot -Parent
$epub = Join-Path $root 'source\Sekret Machines_ Man - Tom DeLonge.epub'
$outDir = Join-Path $root 'source\sekret-machines-man\chapters'
$enc = New-Object System.Text.UTF8Encoding $false

function HtmlToText([string]$html) {
    $html = [regex]::Replace($html, '(?is)<(script|style)\b.*?</\1>', '')
    $html = [regex]::Replace($html, '(?i)<br\s*/?>', "`n")
    $html = [regex]::Replace($html, '(?i)</(p|div|h[1-6]|li|blockquote|tr|table|ul|ol)\s*>', "`n`n")
    $html = [regex]::Replace($html, '(?s)<[^>]+>', '')
    $html = [System.Web.HttpUtility]::HtmlDecode($html)
    $html = $html -replace "`r`n?", "`n"
    $html = [regex]::Replace($html, '(\w)-\n(\w)', '$1$2')
    $html = [regex]::Replace($html, '[ \t]+', ' ')
    $html = [regex]::Replace($html, ' *\n *', "`n")
    return ([regex]::Replace($html, '\n{3,}', "`n`n")).Trim()
}

function Slug([string]$value) {
    $slug = [regex]::Replace($value.ToLowerInvariant(), '[^a-z0-9]+', '-').Trim('-')
    if ($slug.Length -gt 62) { $slug = $slug.Substring(0, 62).Trim('-') }
    return $slug
}

if (Test-Path $outDir) { Remove-Item $outDir -Recurse -Force }
New-Item -ItemType Directory -Force $outDir | Out-Null

$exclude = @(
    'Section One: Genetics and the Extraterrestrial Hypothesis',
    'Section Two: Consciousness',
    'Section Three: Human-Machine Symbiosis',
    'Index'
)

$zip = [IO.Compression.ZipFile]::OpenRead($epub)
try {
    $tocEntry = $zip.Entries | Where-Object FullName -eq 'toc.ncx'
    $reader = New-Object IO.StreamReader($tocEntry.Open())
    [xml]$toc = $reader.ReadToEnd()
    $reader.Dispose()
    $ns = New-Object Xml.XmlNamespaceManager($toc.NameTable)
    $ns.AddNamespace('n', 'http://www.daisy.org/z3986/2005/ncx/')
    $nav = @($toc.SelectNodes('//n:navPoint', $ns) | ForEach-Object {
        [pscustomobject]@{
            title = $_.SelectSingleNode('./n:navLabel/n:text', $ns).InnerText.Trim()
            src = $_.SelectSingleNode('./n:content', $ns).src.Split('#')[0]
        }
    } | Where-Object title -notin $exclude)

    if ($nav.Count -ne 22) { throw "Expected 22 substantive TOC units, found $($nav.Count)." }
    for ($index = 0; $index -lt $nav.Count; $index++) {
        $unit = $nav[$index]
        $entry = $zip.Entries | Where-Object FullName -eq $unit.src
        if (-not $entry) { throw "EPUB entry not found: $($unit.src)" }
        $reader = New-Object IO.StreamReader($entry.Open())
        $body = HtmlToText($reader.ReadToEnd())
        $reader.Dispose()
        $name = '{0:D2}-{1}.txt' -f $index, (Slug $unit.title)
        [IO.File]::WriteAllText((Join-Path $outDir $name), "$($unit.title)`n`n$body", $enc)
    }
}
finally { $zip.Dispose() }

$files = @(Get-ChildItem $outDir -Filter '*.txt' | Sort-Object Name)
"units written: $($files.Count) (expected 22)"
$files | ForEach-Object {
    $words = @(([IO.File]::ReadAllText($_.FullName) -split '\s+') | Where-Object { $_ }).Count
    '{0,-68} {1,7} words' -f $_.Name, $words
}