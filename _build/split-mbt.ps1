# split-mbt.ps1 -- split "My Big TOE - the Complete Trilogy" (Calibre EPUB) into per-chapter plain text.
# Structure: 92 numbered chapters are <h3 class="calibre22"> headings (text begins "<n> Title"),
# spread across text/part0007..part0024. Section headers are <h2 class="calibre21">; within-chapter
# subheads are <h4 class="calibre30"> (must NOT be treated as boundaries). Front matter (About,
# Synopsis, Preface, Foreword: A Conceptual Orientation, Acronyms) -> 00-front-matter.txt.
# Output: source/my-big-toe/chapters/NN-slug.txt  (verbatim text, not summarized).
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Web | Out-Null
$root    = 'C:\Repos\libros-mente'
$src     = Join-Path $root 'source\my-big-toe'
$textDir = Join-Path $src 'text'
$outDir  = Join-Path $src 'chapters'
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
function Slug([string]$s) {
  $s = [regex]::Replace($s.ToLower(), '[^a-z0-9]+', '-')
  $s = $s.Trim('-')
  if ($s.Length -gt 40) { $s = ($s.Substring(0,40)).Trim('-') }
  return $s
}

# Boundaries = section (h2.calibre21) + chapter (h3.calibre22) OPENING tags. Find each heading's
# close tag via IndexOf so multi-line headings (wrapped titles / <br/>) are handled robustly.
$openRe = [regex]'(?i)<h([23])\s+class="calibre2[12]"[^>]*>'
$chapters = @()
foreach ($p in (Get-ChildItem $textDir -Filter 'part00*.html' | Sort-Object Name)) {
  $raw = [System.IO.File]::ReadAllText($p.FullName)
  $opens = $openRe.Matches($raw)
  for ($i = 0; $i -lt $opens.Count; $i++) {
    $o = $opens[$i]
    $level = $o.Groups[1].Value
    $openEnd = $o.Index + $o.Length
    $closeTag = "</h$level>"
    $closeIdx = $raw.IndexOf($closeTag, $openEnd, [System.StringComparison]::OrdinalIgnoreCase)
    if ($closeIdx -lt 0) { continue }
    $title = ((HtmlToText($raw.Substring($openEnd, $closeIdx - $openEnd))) -replace '\s+', ' ').Trim()
    if ($level -eq '3' -and $title -match '^(\d+)\s+(.+)$') {
      $num    = [int]$Matches[1]
      $ctitle = $Matches[2].Trim()
      $bodyStart = $closeIdx + $closeTag.Length
      $bodyEnd   = if ($i -lt $opens.Count - 1) { $opens[$i+1].Index } else { $raw.Length }
      $bodyText  = HtmlToText($raw.Substring($bodyStart, $bodyEnd - $bodyStart))
      $chapters += [pscustomobject]@{ num = $num; title = $ctitle; text = "$num $ctitle`n`n$bodyText"; src = $p.Name }
    }
  }
}

$fmParts = @(
  @{ f = 'part0001.html'; h = 'ABOUT THE MY BIG TOE TRILOGY' },
  @{ f = 'part0002.html'; h = 'SYNOPSIS - My Big Picture Theory of Everything' },
  @{ f = 'part0004.html'; h = 'PREFACE - Author Note to the Reader' },
  @{ f = 'part0005.html'; h = 'FOREWORD - A Conceptual Orientation' },
  @{ f = 'part0006.html'; h = 'LIST OF ACRONYMS, SYMBOLS, AND FOREIGN WORDS' }
)
$fmChunks = foreach ($fp in $fmParts) {
  $fpath = Join-Path $textDir $fp.f
  if (Test-Path $fpath) { "===== $($fp.h) =====`n`n" + (HtmlToText([System.IO.File]::ReadAllText($fpath))) + "`n" }
}
[System.IO.File]::WriteAllText((Join-Path $outDir '00-front-matter.txt'), ($fmChunks -join "`n"), $enc)

$chapters = $chapters | Sort-Object num
$written = 0
foreach ($c in $chapters) {
  $name = ('{0:D2}-{1}.txt' -f $c.num, (Slug $c.title))
  [System.IO.File]::WriteAllText((Join-Path $outDir $name), $c.text, $enc)
  $written++
}

$nums = @($chapters | ForEach-Object { $_.num })
$dupes = ($nums | Group-Object | Where-Object Count -gt 1 | ForEach-Object Name) -join ','
$missing = (1..92 | Where-Object { $_ -notin $nums }) -join ','
"chapters written: $written (expected 92)"
"duplicate numbers: $(if($dupes){$dupes}else{'none'})"
"missing numbers:   $(if($missing){$missing}else{'none'})"
$wc = $chapters | ForEach-Object { [pscustomobject]@{ num=$_.num; words=(($_.text -split '\s+').Count); title=$_.title.Substring(0,[Math]::Min(38,$_.title.Length)) } }
"--- smallest 6 chapters (words) ---"
$wc | Sort-Object words | Select-Object -First 6 | Format-Table -AutoSize
"--- largest 4 chapters (words) ---"
$wc | Sort-Object words -Descending | Select-Object -First 4 | Format-Table -AutoSize
$total = (($chapters | ForEach-Object { ($_.text -split '\s+').Count }) | Measure-Object -Sum).Sum
"total chapter words: $total"
