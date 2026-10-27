# <PROJEKTNAME>

<Ein bis zwei Sätze: Was löst das Projekt, für wen?>

**Technik:** <Sprache und Framework, Datenbank, wichtige Bibliotheken>
**Status:** <in Planung | in Arbeit | abgeschlossen>

## Struktur

| Ordner | Inhalt |
|---|---|
| `src/` | <Quellcode> |
| `docs/` | Dokumentation, Entscheidungen (ADR) und Lerntagebuch |
| `.githooks/` | Commit-Hooks (Secret-Scan, Commit-Meldung) |
| `.github/` | Workflows und Vorlage für Pull Requests |
| `scripts/` | Hilfsskripte, z. B. `protect-main.ps1` (Branch-Schutz) |

## Schnellstart

1. <Voraussetzungen installieren>
2. <Konfiguration aus der Vorlage anlegen, z. B. `.env.example` nach `.env` kopieren; nie committen>
3. <Starten>

## Entwicklung

- Regeln für Mensch und KI: [`RULES.md`](RULES.md), Projektkontext: [`CLAUDE.md`](CLAUDE.md).
- Nach dem Klonen einmal die Commit-Hooks aktivieren (benötigt [gitleaks](https://github.com/gitleaks/gitleaks)):
  `git config core.hooksPath .githooks`
- Commits nach Conventional Commits, Englisch: `type(scope): description`.
- Änderungen stehen im [`CHANGELOG.md`](CHANGELOG.md).

## Lerntagebuch

Was gebaut wurde, warum so und was dabei gelernt wurde, steht in [`docs/lerntagebuch/`](docs/lerntagebuch/).

## Lizenz

<Lizenz eintragen oder „Alle Rechte vorbehalten“, bis eine Lizenz gewählt ist.>
