# split-pon.ps1 -- split "Practicing the Power of Now" (Tolle) EPUB into per-chapter plain text.
# Clean per-chapter EPUB (OEBPS/text000NN.html); a few chapters span 2 consecutive files.
# Units = Introduction + 9 chapters (Part-divider pages and front/back boilerplate excluded).
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Web | Out-Null
$oebps  = 'C:\Repos\libros-mente\source\power-of-now\OEBPS'
$outDir = 'C:\Repos\libros-mente\source\power-of-now\chapters'
if (Test-Path $outDir) { Remove-Item $outDir -Recurse -Force }
New-Item -ItemType Directory -Force $outDir | Out-Null
$enc = New-Object System.Text.UTF8Encoding $false

function HtmlToText([string]$html) {
  if (-not $html) { return '' }
  $html = [regex]::Replace($html, '(?is)<(script|style)\b.*?</\1>', '')
  $html = [regex]::Replace($html, '(?i)<br\s*/?>', "`n")
  $html = [regex]::Replace($html, '(?i)</(p|div|h[1-6]|li|blockquote|tr|table|ul|ol)\s*>', "`n`n")
  $html = [regex]::Replace($html, '(?s)<[^>]+>', '')
  $html = [System.Web.HttpUtility]::HtmlDecode($html)
  $html = $html -replace '\r\n?', "`n"
  $html = [regex]::Replace($html, '(\w)-\n(\w)', '$1$2')
  $html = [regex]::Replace($html, '[ \t]+', ' ')
  $html = [regex]::Replace($html, ' *\n *', "`n")
  $html = [regex]::Replace($html, '\n{3,}', "`n`n")
  return $html.Trim()
}

$units = @(
  @{ n=0; slug='introduction';                                    title='Introduction';                                    files=@('text00005.html') },
  @{ n=1; slug='being-and-enlightenment';                         title='Chapter One: Being and Enlightenment';            files=@('text00008.html') },
  @{ n=2; slug='the-origin-of-fear';                              title='Chapter Two: The Origin of Fear';                 files=@('text00009.html') },
  @{ n=3; slug='entering-the-now';                                title='Chapter Three: Entering the Now';                 files=@('text00010.html') },
  @{ n=4; slug='dissolving-unconsciousness';                      title='Chapter Four: Dissolving Unconsciousness';        files=@('text00011.html') },
  @{ n=5; slug='beauty-arises-in-the-stillness-of-your-presence'; title='Chapter Five: Beauty Arises in the Stillness of Your Presence'; files=@('text00012.html') },
  @{ n=6; slug='dissolving-the-pain-body';                        title='Chapter Six: Dissolving the Pain-Body';           files=@('text00015.html') },
  @{ n=7; slug='from-addictive-to-enlightened-relationships';     title='Chapter Seven: From Addictive to Enlightened Relationships'; files=@('text00016.html') },
  @{ n=8; slug='acceptance-of-the-now';                           title='Chapter Eight: Acceptance of the Now';            files=@('text00019.html') },
  @{ n=9; slug='transforming-illness-and-suffering';              title='Chapter Nine: Transforming Illness and Suffering';files=@('text00020.html') }
)

foreach ($u in $units) {
  $parts = foreach ($f in $u.files) {
    $fp = Join-Path $oebps $f
    if (Test-Path $fp) { HtmlToText([System.IO.File]::ReadAllText($fp)) }
  }
  $body = ($parts -join "`n`n").Trim()
  $text = "$($u.title)`n`n$body"
  $name = ('{0:D2}-{1}.txt' -f $u.n, $u.slug)
  [System.IO.File]::WriteAllText((Join-Path $outDir $name), $text, $enc)
}

"units written: $($units.Count)"
Get-ChildItem $outDir -Filter '*.txt' | Sort-Object Name | ForEach-Object {
  $w = (((Get-Content $_.FullName -Raw) -split '\s+') | Where-Object { $_ }).Count
  "{0,-52} {1,6} words" -f $_.Name, $w
}
