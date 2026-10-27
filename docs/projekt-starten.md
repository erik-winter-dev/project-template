# Aus der Vorlage ein neues Projekt starten

Diese Anleitung steht in jedem Projekt, das aus der Vorlage entsteht. Sie wird nach dem Start nicht gelöscht, weil sie erklärt, warum die Dateien so aussehen.

## Schritte

1. **Repo erzeugen:** Auf GitHub bei der Vorlage „Use this template“ wählen, Name und Sichtbarkeit festlegen. Oder per Kommandozeile: `gh repo create <konto>/<name> --template erik-winter-dev/project-template --public --clone`.
2. **gitleaks installieren** (einmal pro Rechner): `winget install --id Gitleaks.Gitleaks -e`. Die Installation kann mit `gitleaks version` geprüft werden.
3. **Hooks aktivieren** (einmal pro Klon): `git config core.hooksPath .githooks`.
4. **Platzhalter ersetzen:** In `README.md`, `CLAUDE.md` und `docs/index.md` alle Stellen in spitzen Klammern (`<...>`) ausfüllen oder löschen.
5. **Lizenz entscheiden:** Ohne `LICENSE`-Datei gilt „Alle Rechte vorbehalten“. Für ein öffentliches Portfolio-Projekt ist die MIT-Lizenz üblich, für ein späteres Produkt eher nicht. Die Entscheidung als ADR festhalten und im README eintragen.
6. **`main` schützen:** Änderungen nur per Pull Request, Status-Prüfungen `secret-scan` und `commit-messages` verlangen.
7. **Ersten Lerntagebuch-Eintrag** anlegen (`docs/lerntagebuch/`).

## Was die Vorlage enthält und warum

| Datei | Zweck |
|---|---|
| `RULES.md` | Verbindliche Regeln für Mensch und KI: Genauigkeit, Datenklassen, Sicherheit, Autonomie, Code-Stil, Lernregel |
| `CLAUDE.md` | Projektkontext für die KI, damit jede Sitzung ohne Vorwissen startet |
| `.githooks/pre-commit` | Blockiert Commits mit Zugangsdaten (gitleaks) |
| `.githooks/commit-msg` | Erzwingt Conventional Commits, aus denen Changelog und Version entstehen |
| `.github/workflows/secret-scan.yml` | Wiederholt beide Prüfungen auf dem Server, falls ein Hook lokal übersprungen wurde |
| `.github/pull_request_template.md` | Fertig-Checkliste in jedem Pull Request |
| `.gitattributes` | Hält Shell-Skripte und Hooks auf LF-Zeilenenden; unter Windows laufen sie sonst nicht |
| `.gitignore` | Schließt Geheimnisse, Build-Ausgaben und lokale Dateien aus |
| `docs/` | Doku-Struktur, ADR-Vorlage und Lerntagebuch |
