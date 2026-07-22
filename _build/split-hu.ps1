# Split The Holographic Universe (OCR epub) into per-chapter plain-text files
$src = 'C:\Repos\libros-mente\source\holographic-universe\OEBPS'
$out = 'C:\Repos\libros-mente\source\holographic-universe\chapters'
New-Item -ItemType Directory -Force $out | Out-Null

# 1. Collect all <p> paragraphs in spine order
$paras = New-Object System.Collections.Generic.List[string]
foreach ($i in 0..5) {
    $html = [System.IO.File]::ReadAllText("$src\part000$i.html")
    foreach ($m in [regex]::Matches($html, '<p>(.*?)</p>', 'Singleline')) {
        $t = $m.Groups[1].Value -replace '<[^>]+>', ' ' -replace '\s+', ' '
        $t = [System.Net.WebUtility]::HtmlDecode($t).Trim()
        if ($t.Length -gt 0) { $paras.Add($t) }
    }
}
"total paragraphs: $($paras.Count)"

$chapters = @(
    @{n='00'; slug='introduction';                          title='Introduction';                         rx='^Introduction$'},
    @{n='01'; slug='the-brain-as-hologram';                 title='The Brain as Hologram';                rx='^The Brain as Hologram$'},
    @{n='02'; slug='the-cosmos-as-hologram';                title='The Cosmos as Hologram';               rx='^The Cosmos as Hologram$'},
    @{n='03'; slug='the-holographic-model-and-psychology';  title='The Holographic Model and Psychology'; rx='^The Holographic Model and Psycholog.$'},
    @{n='04'; slug='i-sing-the-body-holographic';           title='I Sing the Body Holographic';          rx='^. Sing the Body Holographic$'},
    @{n='05'; slug='a-pocketful-of-miracles';               title='A Pocketful of Miracles';              rx='^A Pocketful of Miracles$'},
    @{n='06'; slug='seeing-holographically';                title='Seeing Holographically';               rx='^Seeing Ho.ographical.y$'},
    @{n='07'; slug='time-out-of-mind';                      title='Time Out of Mind';                     rx='^Time Out of Mind$'},
    @{n='08'; slug='traveling-in-the-superhologram';        title='Traveling in the Superhologram';       rx='^Travel.ng in the Superhologram$'},
    @{n='09'; slug='return-to-the-dreamtime';               title='Return to the Dreamtime';              rx='^Return to the Dreamtime$'},
    @{n='99'; slug='notes';                                 title='Notes';                                rx='^Notes$'}
)

# 2. Find boundaries: first match of each title, scanning forward from the previous one.
#    Start after the standalone 'Acknowledgments' section head (skips the printed TOC).
$ptr = 0
for ($i = 0; $i -lt $paras.Count; $i++) { if ($paras[$i] -cmatch '^Acknowledgments$') { $ptr = $i; break } }
"acknowledgments head at paragraph $ptr"
foreach ($ch in $chapters) {
    $found = -1
    for ($i = $ptr + 1; $i -lt $paras.Count; $i++) {
        if ($paras[$i] -cmatch $ch.rx) { $found = $i; break }
    }
    if ($found -lt 0) { throw "BOUNDARY NOT FOUND: $($ch.title) (searching from $ptr)" }
    $ch.start = $found
    $ptr = $found
}
for ($c = 0; $c -lt $chapters.Count - 1; $c++) { $chapters[$c].end = $chapters[$c + 1].start - 1 }
$chapters[-1].end = $paras.Count - 1

# 3. Per chapter: drop running headers / bare page numbers, merge page-broken paragraphs, write file
$report = @()
foreach ($ch in $chapters) {
    $body = New-Object System.Collections.Generic.List[string]
    for ($i = $ch.start + 1; $i -le $ch.end; $i++) {
        $p = $paras[$i]
        if ($p -cmatch $ch.rx) { continue }                       # running header: chapter title
        if ($p -match '^(THE HOLOGRAPHIC UN[Il1]VERSE|INTRODUCTION|ACKNOWLEDGMENTS)$') { continue }
        if ($p -match '^[\dxvil]{1,4}$') { continue }             # bare page numbers (arabic or OCR'd roman)
        if ($body.Count -gt 0) {
            $prev = $body[$body.Count - 1]
            if ($prev -match '-$' -and $p -cmatch '^[a-z]') {     # hyphen break at page turn
                $body[$body.Count - 1] = ($prev -replace '-$','') + $p; continue
            }
            if ($prev -match '[a-z,;]$' -and $p -cmatch '^[a-z]') { # sentence continues past page turn
                $body[$body.Count - 1] = $prev + ' ' + $p; continue
            }
        }
        $body.Add($p)
    }
    $text = "# $($ch.title)`r`n`r`n" + ($body -join "`r`n`r`n")
    $file = "$out\$($ch.n)-$($ch.slug).txt"
    [System.IO.File]::WriteAllText($file, $text, [System.Text.Encoding]::UTF8)
    $words = ($text -split '\s+').Count
    $report += '{0}  paras {1,4}  words {2,6}  {3}' -f $ch.n, $body.Count, $words, $ch.title
}
$report
