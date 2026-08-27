# Embeds the variable woff2 fonts as base64 @font-face rules and swaps the font vars.
$ErrorActionPreference = 'Stop'
$dir = Join-Path $PSScriptRoot 'fonts'
$tplPath = Join-Path $PSScriptRoot 'libros-template.html'

Get-ChildItem $dir -Filter *.woff2 | ForEach-Object {
  $b = [IO.File]::ReadAllBytes($_.FullName)[0..3]
  $magic = -join ($b | ForEach-Object { [char]$_ })
  if ($magic -ne 'wOF2') { throw "Bad woff2 magic in $($_.Name): $magic" }
}

function FF($fam, $style, $wght, $file) {
  $b64 = [Convert]::ToBase64String([IO.File]::ReadAllBytes((Join-Path $dir $file)))
  "@font-face{font-family:'$fam';font-style:$style;font-weight:$wght;font-display:swap;src:url(data:font/woff2;base64,$b64) format('woff2')}"
}

$ff = @(
  (FF 'Fraunces' 'normal' '100 900' 'fraunces-normal.woff2'),
  (FF 'Newsreader' 'normal' '100 900' 'newsreader-normal.woff2'),
  (FF 'Newsreader' 'italic' '100 900' 'newsreader-italic.woff2'),
  (FF 'Space Grotesk' 'normal' '300 700' 'space-grotesk-normal.woff2')
) -join "`n"

$tpl = [IO.File]::ReadAllText($tplPath)
if ($tpl.Contains("font-family:'Fraunces'")) { Write-Host 'Fonts already embedded; nothing to do.'; return }

$tpl = $tpl.Replace('<style>', "<style>`n$ff`n")
$tpl = $tpl.Replace('    --display: Baskerville, "Iowan Old Style", "Palatino Linotype", Palatino, Georgia, serif;', '    --display: "Fraunces", Baskerville, "Iowan Old Style", Palatino, Georgia, serif;')
$tpl = $tpl.Replace('    --body: "Palatino Linotype", Palatino, Bookman, serif;', '    --body: "Newsreader", "Palatino Linotype", Palatino, Georgia, serif;')
$tpl = $tpl.Replace('    --utility: Aptos, "Segoe UI", system-ui, sans-serif;', '    --utility: "Space Grotesk", Aptos, "Segoe UI", system-ui, sans-serif;')

[IO.File]::WriteAllText($tplPath, $tpl, (New-Object System.Text.UTF8Encoding($false)))
Write-Host ('Embedded ' + ([regex]::Matches($tpl, '@font-face').Count) + ' @font-face rules and swapped font variables.')
