# CLAUDE.md – <PROJEKTNAME>

Lies zuerst `RULES.md` (gilt immer). Diese Datei enthält nur Projektspezifisches.
Alles in spitzen Klammern (`<...>`) ist ein Platzhalter und wird beim Projektstart ersetzt.

## Worum es geht

<2 bis 4 Sätze: Welches Problem löst das Projekt, für wen, was ist die Kernfunktion?>

## Herkunft und Status

- Datenklasse: <öffentlich | intern | vertraulich> (siehe `RULES.md`, Abschnitt 2).
- Status: <in Planung | in Arbeit | abgeschlossen>.
- Pipeline-Stand: <aktuelle Phase und nächster Schritt>.

## Architektur

<Bausteine mit je einer Aufgabe, z. B. als Tabelle. Wie kommunizieren sie miteinander?>

| Baustein | Aufgabe |
|---|---|
| `<name>` | <eine Zeile> |

## Datenhaltung

<Datenbank und Tabellen, wichtige Muster (z. B. Soft-Delete, nur anhängen). Entfällt, wenn es keine gibt.>

## Befehle

```bash
<Abhängigkeiten installieren>
<starten>
<Tests ausführen>
```

Konfiguration: <welche Vorlagen es gibt, z. B. `.env.example`, und dass die echte Datei nie committet wird>.

## Konventionen

<Projektspezifische Regeln, zusätzlich zu `RULES.md`, Abschnitt 5. Zum Beispiel Sprach-Skill, Namensmuster, Fehlerbehandlung.>

## Offene Punkte

1. <Punkt mit Phase>

## Beobachtungen (ungeprüft)

- <Dinge, die aufgefallen sind, aber noch nicht geprüft wurden>
