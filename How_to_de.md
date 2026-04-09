# MemPalace How-To (Deutsch)

[![Python 3.10+](https://img.shields.io/badge/Python-3.10%2B-blue)](https://www.python.org/)
[![CLI Guide](https://img.shields.io/badge/Guide-CLI%20%26%20MCP-success)](README.md)
[![Local First](https://img.shields.io/badge/Runtime-Local%20First-orange)](README.md)

Ein professioneller, praxisnaher Leitfaden für Setup, Datenimport und tägliche Nutzung von MemPalace.

---

## Inhalt

1. [Voraussetzungen](#voraussetzungen)
2. [Installation](#installation)
3. [Palace initialisieren](#palace-initialisieren)
4. [Daten importieren (`mine`)](#daten-importieren-mine)
5. [Suchen und Status prüfen](#suchen-und-status-prüfen)
6. [Mit AI-Tools verbinden (MCP)](#mit-ai-tools-verbinden-mcp)
7. [Empfohlener Daily Workflow](#empfohlener-daily-workflow)
8. [Troubleshooting](#troubleshooting)

---

## Voraussetzungen

- Python **3.10+**
- Terminal mit Zugriff auf deine Projekt- und Chat-Verzeichnisse
- Optional: Claude/Cursor/Gemini/ChatGPT-Umgebung mit MCP-Unterstützung

---

## Installation

```bash
pip install mempalace
```

Verifizieren:

```bash
mempalace --help
```

---

## Palace initialisieren

```bash
mempalace init ~/projects/myapp
```

Das legt die Grundstruktur für dein Projektgedächtnis an.

---

## Daten importieren (`mine`)

### 1) Projektdateien (Code, Docs, Notes)

```bash
mempalace mine ~/projects/myapp
```

### 2) Konversationen (Claude, ChatGPT, Slack-Exporte)

```bash
mempalace mine ~/chats/ --mode convos
```

### 3) Konversationen + inhaltliche Extraktion

```bash
mempalace mine ~/chats/ --mode convos --extract general
```

`--extract general` hilft, Entscheidungen, Meilensteine und Probleme später gezielter zu finden.

---

## Suchen und Status prüfen

### Suche

```bash
mempalace search "why did we switch to GraphQL"
```

Oder auf Deutsch:

```bash
mempalace search "Warum haben wir auf GraphQL gewechselt?"
```

### Status

```bash
mempalace status
```

---

## Mit AI-Tools verbinden (MCP)

Beispiel mit Claude CLI:

```bash
claude mcp add mempalace -- python -m mempalace.mcp_server
```

Danach kann dein Assistent MemPalace-Tools direkt verwenden, statt jedes Mal manuell `mempalace search ...` auszuführen.

---

## Empfohlener Daily Workflow

1. **Einmalig:** `pip install mempalace` und `mempalace init ...`
2. **Regelmäßig:** neue Inhalte per `mempalace mine ...` importieren
3. **Im AI-Chat:** Fragen zur Historie, Entscheidungen und Kontext stellen
4. **Bei Bedarf manuell:** punktgenaue Suche mit `mempalace search "..."`

---

## Troubleshooting

- **`mempalace: command not found`**  
  Prüfe Python-/Pip-Umgebung und PATH.
- **Leere Suchtreffer**  
  Erst Inhalte mit `mempalace mine ...` importieren.
- **MCP-Verbindung funktioniert nicht**  
  MCP-Eintrag neu anlegen, CLI/Editor neu starten.

---

## Optionaler Schnellstart

Falls du eine direkte Vorlage willst:

- [`examples/quickstart.sh`](examples/quickstart.sh)
