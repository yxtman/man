param(
  [string]$Root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
)

$ErrorActionPreference = 'Stop'
$failures = [System.Collections.Generic.List[string]]::new()

foreach ($file in Get-ChildItem -LiteralPath $Root -Filter '*.html') {
  $html = Get-Content -LiteralPath $file.FullName -Raw -Encoding UTF8
  $name = $file.Name

  if ($name -ne '404.html') {
    foreach ($required in @(
      '<meta property="og:url"',
      '<meta property="og:description"',
      '<meta property="og:locale"',
      '<meta name="twitter:card"'
    )) {
      if ($html -notmatch [regex]::Escape($required)) { $failures.Add("$name missing $required") }
    }
  }

  foreach ($toggle in [regex]::Matches($html, '<button\b[^>]*\bid="navToggle"[^>]*>')) {
    if ($toggle.Value -notmatch '\baria-controls="siteNav"') { $failures.Add("$name nav toggle missing aria-controls") }
  }
  if ($html -match 'id="siteNav"' -and $html -notmatch 'aria-label="[^"]+"') {
    $failures.Add("$name site nav missing aria-label")
  }

  foreach ($img in [regex]::Matches($html, '<img\b[^>]*>')) {
    if ($img.Value -notmatch '\bloading="(lazy|eager)"') { $failures.Add("$name image missing loading attribute") }
    if ($img.Value -notmatch '\bdecoding="async"') { $failures.Add("$name image missing decoding=async") }
  }
}

if ($failures.Count) {
  $failures | ForEach-Object { Write-Error $_ }
  exit 1
}

Write-Output "Site checks passed: $((Get-ChildItem -LiteralPath $Root -Filter '*.html').Count) HTML files"
