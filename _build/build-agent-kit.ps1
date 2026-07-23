# build-agent-kit.ps1 — refresh agent-kit/ knowledge copies from notes/
# 00-instructions.md is hand-maintained and never touched.
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$kit  = Join-Path $root 'agent-kit'
$notes = Join-Path $root 'notes'
New-Item -ItemType Directory -Force $kit | Out-Null

# short prefix per book folder (add when a new book is processed)
$bookPrefix = @{
    'holographic-universe'  = 'hu'
    'simulation-hypothesis' = 'sh'
    'my-big-toe'            = 'mbt'
    'power-of-now'          = 'pon'
    'american-cosmic'       = 'ac'
    'zen-motorcycle'        = 'zen'
    'dark-psychology'       = 'dp'
    'sekret-machines-war'   = 'smw'
}

Get-ChildItem $kit -Filter '*.md' | Where-Object { $_.Name -ne '00-instructions.md' } | Remove-Item -Force
$n = 1
foreach ($dir in (Get-ChildItem $notes -Directory | Sort-Object Name)) {
    $p = $bookPrefix[$dir.Name]; if (-not $p) { $p = $dir.Name }
    $order = @('00-map.md', '90-glossary.md', '91-qa.md') +
             @(Get-ChildItem $dir.FullName -Filter '*.md' | Where-Object { $_.Name -notin '00-map.md','90-glossary.md','91-qa.md' } | Sort-Object Name | ForEach-Object Name)
    foreach ($f in $order) {
        $src = Join-Path $dir.FullName $f
        if (-not (Test-Path $src)) { continue }
        $label = $f -replace '\.md$','' -replace '^\d+-',''
        $dest = Join-Path $kit ('{0:D2}-{1}-{2}.md' -f $n, $p, $label)
        Copy-Item $src $dest -Force
        $n++
    }
}
"agent-kit refreshed: $((Get-ChildItem $kit -Filter '*.md').Count) files (incl. instructions)"
