# MemPalace – So verbindest du es und nutzt es im Alltag (Deutsch)

Diese Anleitung zeigt dir zwei Wege:

1. **Direkt per CLI** (zum Einrichten und Testen)
2. **Verbunden mit deinem AI-Tool** über MCP (für den täglichen Einsatz)

---

## 1) Installation

```bash
pip install mempalace
```

Prüfen, ob es installiert ist:

```bash
mempalace --help
```

---

## 2) Ein Palace-Verzeichnis anlegen

```bash
mempalace init ~/projects/myapp
```

Damit erzeugst du die MemPalace-Struktur für dein Projekt.

---

## 3) Daten einlesen („mine“)

### Projektdateien (Code, Doku, Notizen)

```bash
mempalace mine ~/projects/myapp
```

### Chats importieren (Claude, ChatGPT, Slack-Exporte)

```bash
mempalace mine ~/chats/ --mode convos
```

### Chats importieren + automatische Extraktion

```bash
mempalace mine ~/chats/ --mode convos --extract general
```

`--extract general` hilft dir, Entscheidungen, Meilensteine und Probleme schneller wiederzufinden.

---

## 4) Inhalte durchsuchen

```bash
mempalace search "why did we switch to GraphQL"
```

Du kannst natürlich auf Deutsch suchen, z. B.:

```bash
mempalace search "Warum haben wir auf GraphQL gewechselt?"
```

---

## 5) Status prüfen

```bash
mempalace status
```

Damit siehst du, ob dein Palace korrekt angelegt ist und Daten enthält.

---

## 6) Mit AI-Tools verbinden (MCP)

Wenn du MemPalace im Alltag mit Claude/ChatGPT/Cursor/Gemini nutzen willst, verbindest du es einmal über MCP.

Beispiel (Claude CLI):

```bash
claude mcp add mempalace -- python -m mempalace.mcp_server
```

Danach kann dein Assistent die MemPalace-Tools direkt aufrufen, statt dass du ständig manuell `mempalace search ...` eintippen musst.

---

## 7) Typischer Ablauf im Alltag

1. Einmalig: `pip install` + `mempalace init`
2. Regelmäßig: neue Daten mit `mempalace mine ...` einlesen
3. Im Chat mit AI: Fragen stellen wie
   - „Was haben wir letzten Monat zur Auth-Strategie entschieden?“
   - „Zeig mir die Diskussion, warum wir GraphQL gewählt haben.“
4. Bei Bedarf direkt per CLI nachschlagen: `mempalace search "..."`

---

## Fehlerbehebung (kurz)

- **Befehl nicht gefunden:** Prüfe, ob `pip` in dieselbe Python-Umgebung installiert hat, die dein Terminal nutzt.
- **Leere Suchergebnisse:** Stelle sicher, dass du vorher mit `mempalace mine ...` Inhalte importiert hast.
- **MCP klappt nicht:** Server-Eintrag erneut anlegen und Terminal/Tool neu starten.

---

## Optional: Schnellstart-Skript

Wenn du die Kommandos als Vorlage willst, nutze:

- `examples/quickstart.sh`

