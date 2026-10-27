<#
  protect-main.ps1 – schützt den Standard-Branch (main) eines Repos mit einem GitHub-Ruleset.

  Zweck:    Erzwingt die Regel aus RULES.md, Abschnitt 8: Änderungen an main nur per Pull Request,
            mit bestandenen Prüfungen (Workflow secret-scan). Kein Löschen, kein Force-Push.
  Aufruf:   powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\protect-main.ps1
            powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\protect-main.ps1 -Repo konto/name
  Eingaben: -Repo  Optional, Format "konto/name". Ohne Angabe wird das Repo des aktuellen Ordners genommen.
  Ausgabe:  Meldung, ob das Ruleset angelegt wurde oder schon existierte. Bei Fehlern bricht das Skript ab.
  Voraussetzung: gh ist angemeldet (gh auth status) und das Konto darf das Repo verwalten.

  Warum ein Ruleset statt klassischem Branch-Schutz: Rulesets sind der neuere Mechanismus von GitHub
  und lassen sich per API sauber anlegen.
  Warum 0 Pflicht-Reviews: Ein Einzelentwickler kann sich nicht selbst freigeben. Der Pull Request
  bleibt trotzdem Pflicht, damit die Prüfungen laufen und jede Änderung nachvollziehbar ist.
  Achtung: Die Pflicht-Prüfungen "gitleaks" und "commit-messages" sind die Jobs aus
  .github/workflows/secret-scan.yml. Wird der Workflow gelöscht oder umbenannt, hängt jeder Pull
  Request, bis das Ruleset angepasst ist.
#>
param([string]$Repo)

$ErrorActionPreference = "Stop"
$rulesetName = "protect-main"

function Resolve-Repo {
  # Zweck:    Ziel-Repo bestimmen.
  # Ausgabe:  "konto/name"
  if ($Repo) { return $Repo }
  $name = gh repo view --json nameWithOwner --jq .nameWithOwner
  if ($LASTEXITCODE -ne 0 -or -not $name) {
    throw "Repo nicht erkannt. Im Repo-Ordner starten oder -Repo angeben."
  }
  return $name
}

function Test-RulesetExists([string]$target) {
  # Zweck:    Prüfen, ob das Ruleset schon da ist, damit es nicht doppelt angelegt wird.
  # Eingaben: $target = "konto/name"
  # Ausgabe:  $true oder $false
  $json = gh api "repos/$target/rulesets"
  if ($LASTEXITCODE -ne 0) { throw "Rulesets von $target konnten nicht gelesen werden." }
  $all = ($json -join "`n") | ConvertFrom-Json
  return [bool]($all | Where-Object { $_.name -eq $rulesetName })
}

function New-MainRuleset([string]$target) {
  # Zweck:    Ruleset für den Standard-Branch anlegen.
  # Eingaben: $target = "konto/name"
  # Ausgabe:  keine; wirft einen Fehler, wenn GitHub die Anlage ablehnt.
  # Warum ~DEFAULT_BRANCH: gilt auch, falls der Standard-Branch später umbenannt wird.
  $body = @'
{
  "name": "__NAME__",
  "target": "branch",
  "enforcement": "active",
  "conditions": { "ref_name": { "include": ["~DEFAULT_BRANCH"], "exclude": [] } },
  "rules": [
    { "type": "deletion" },
    { "type": "non_fast_forward" },
    { "type": "pull_request", "parameters": {
        "required_approving_review_count": 0,
        "dismiss_stale_reviews_on_push": false,
        "require_code_owner_review": false,
        "require_last_push_approval": false,
        "required_review_thread_resolution": false } },
    { "type": "required_status_checks", "parameters": {
        "strict_required_status_checks_policy": false,
        "required_status_checks": [ { "context": "gitleaks" }, { "context": "commit-messages" } ] } }
  ]
}
'@.Replace("__NAME__", $rulesetName)
  $body | gh api "repos/$target/rulesets" --method POST --input - | Out-Null
  if ($LASTEXITCODE -ne 0) { throw "Ruleset konnte nicht angelegt werden." }
}

$target = Resolve-Repo
if (Test-RulesetExists $target) {
  Write-Host "Ruleset '$rulesetName' existiert bereits in $target - nichts zu tun."
  exit 0
}
New-MainRuleset $target
Write-Host "Ruleset '$rulesetName' in $target angelegt: main nur per Pull Request, Pruefungen Pflicht."
