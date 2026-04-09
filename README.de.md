<div align="center">

<img src="assets/mempalace_logo.png" alt="MemPalace" width="280">

# MemPalace (Deutsch)

### Das KI-Speichersystem mit der höchsten Punktzahl, das jemals bewertet wurde. Und es ist kostenlos.

<br>

Jedes Gespräch, das Sie mit einer KI führen – jede Entscheidung, jede Debugging-Sitzung, jede Architekturdebatte – verschwindet, wenn die Sitzung endet. Sechs Monate Arbeit sind vorbei. Du fängst jedes Mal von vorne an.

Andere Speichersysteme versuchen, dies zu beheben, indem sie die KI entscheiden lassen, was es wert ist, erinnert zu werden. Es extrahiert „Benutzer bevorzugt Postgres“ und verwirft die Konversation, in der Sie *warum* erklärt haben. MemPalace verfolgt einen anderen Ansatz: **Alles speichern und dann auffindbar machen.**

**Der Palast** – Antike griechische Redner lernten ganze Reden auswendig, indem sie Ideen in Räumen eines imaginären Gebäudes platzierten. Gehen Sie durch das Gebäude und finden Sie die Idee. MemPalace wendet das gleiche Prinzip auf das KI-Gedächtnis an: Ihre Gespräche werden in Flügel (Personen und Projekte), Säle (Erinnerungsarten) und Räume (spezifische Ideen) organisiert. Keine KI entscheidet, worauf es ankommt – Sie behalten jedes Wort und die Struktur bietet Ihnen eine navigierbare Karte anstelle eines flachen Suchindex.

**Rohe wörtliche Speicherung** – MemPalace speichert Ihren tatsächlichen Austausch in ChromaDB ohne Zusammenfassung oder Extraktion. Das LongMemEval-Ergebnis von 96,6 % stammt aus diesem Rohmodus. Wir verbrennen kein LLM, um zu entscheiden, was „erinnerungswürdig“ ist – wir behalten alles und lassen es durch die semantische Suche finden.

**AAAK (experimentell)** – Ein verlustbehafteter Abkürzungsdialekt zum Packen wiederholter Entitäten in weniger Token im großen Maßstab. Kann von jedem LLM gelesen werden, der Text liest – Claude, GPT, Gemini, Llama, Mistral – kein Decoder erforderlich. **AAAK ist eine separate Komprimierungsschicht, nicht der Speicherstandard**, und im LongMemEval-Benchmark weist sie derzeit einen Rückgang im Vergleich zum Rohmodus auf (84,2 % gegenüber 96,6 %). Wir iterieren. Den ehrlichen Status finden Sie in der [Anmerkung oben](#a-note-from-milla--ben--april-7-2026).

**Lokal, offen, anpassungsfähig** – MemPalace läuft vollständig auf Ihrem Computer, mit allen Daten, die Sie lokal haben, ohne externe APIs oder Dienste zu verwenden. Es wurde anhand von Gesprächen getestet – es kann jedoch für verschiedene Arten von Datenspeichern angepasst werden. Aus diesem Grund veröffentlichen wir es als Open Source.

<br>

[![][version-shield]][release-link]
[![][python-shield]][python-link]
[![][license-shield]][license-link]
[![][discord-shield]][discord-link]

<br>

[Schnellstart](#quick-start) · [Der Palast](#the-palace) · [AAAK-Dialekt](#aaak-dialect-experimental) · [Benchmarks](#benchmarks) · [MCP Tools](#mcp-server)

<br>

### Höchster jemals veröffentlichter LongMemEval-Score – kostenlos oder kostenpflichtig.

<table>
<tr>
<td align="center"><strong>96.6%</strong><br><sub>LongMemEval R@5<br><b>raw mode</b>, zero API calls</sub></td>
<td align="center"><strong>500/500</strong><br><sub>questions tested<br>independently reproduced</sub></td>
<td align="center"><strong>$0</strong><br><sub>No subscription<br>No cloud. Local only.</sub></td>
</tr>
</table>

<sub>Reproducible — runners in <a href="benchmarks/">benchmarks/</a>. <a href="benchmarks/BENCHMARKS.md">Full results</a>. The 96.6% is from <b>raw verbatim mode</b>, not AAAK or rooms mode (those score lower — see <a href="#a-note-from-milla--ben--april-7-2026">note above</a>).</sub>

</div>

---

## Eine Notiz von Milla & Ben – 7. April 2026

> Die Community hat in dieser README-Datei bereits wenige Stunden nach der Veröffentlichung echte Probleme festgestellt, und wir möchten sie direkt beheben.
>
> **Was wir falsch verstanden haben:**
>
> - **Das AAAK-Token-Beispiel war falsch.** Wir haben eine grobe Heuristik („len(text)//3“) für die Token-Zählungen anstelle eines tatsächlichen Tokenizers verwendet. Echte Zählungen über den Tokenizer von OpenAI: Das englische Beispiel beträgt 66 Token, das AAAK-Beispiel 73. AAAK speichert keine Token in kleinem Maßstab – es ist für *wiederholte Entitäten in großem Maßstab* konzipiert, und das README-Beispiel war eine schlechte Demonstration dessen. Wir schreiben es neu.
>
> - **„30x verlustfreie Komprimierung“ wurde überbewertet.** AAAK ist ein verlustbehaftetes Abkürzungssystem (Entitätscodes, Satzkürzung). Unabhängige Benchmarks zeigen im AAAK-Modus Werte von **84,2 % R@5 gegenüber 96,6 %** im Rohmodus bei LongMemEval – eine Regression von 12,4 Punkten. Der ehrliche Rahmen ist: AAAK ist eine experimentelle Komprimierungsschicht, die Treue gegen Token-Dichte eintauscht, und **die Schlagzeilenzahl von 96,6 % stammt aus dem RAW-Modus, nicht aus AAAK**.
>
> - **„+34 % Palast-Boost“ war irreführend. ** Diese Zahl vergleicht die ungefilterte Suche mit der Filterung von Flügel- und Raummetadaten. Die Metadatenfilterung ist eine Standardfunktion von ChromaDB und kein neuartiger Abrufmechanismus. Echt und nützlich, aber kein Graben.
>
> - **„Widerspruchserkennung“** existiert als separates Dienstprogramm („fact_checker.py“), ist aber derzeit nicht in die Knowledge-Graph-Operationen eingebunden, wie in der README-Datei angedeutet.
>
> - **„100 % mit Haiku-Reranking“** ist real (wir haben die Ergebnisdateien), aber die Reranking-Pipeline ist nicht in den öffentlichen Benchmark-Skripten enthalten. Wir fügen es hinzu.
>
> **Was noch wahr und reproduzierbar ist:**
>
> - **96,6 % R@5 bei LongMemEval im Rohmodus**, bei 500 Fragen, keine API-Aufrufe – unabhängig reproduziert auf M2 Ultra in weniger als 5 Minuten von [@gizmax](https://github.com/milla-jovovich/mempalace/issues/39).
> - Lokal, kostenlos, kein Abonnement, keine Cloud, keine Daten verlassen Ihren Computer.
> - Die Architektur (Flügel, Räume, Schränke, Schubladen) ist real und nützlich, auch wenn es sich nicht um einen magischen Wiederauffindungsschub handelt.
>
> **Was wir tun:**
>
> 1. Umschreiben des AAAK-Beispiels mit echten Tokenizer-Zählungen und einem Szenario, in dem AAAK tatsächlich eine Komprimierung demonstriert
> 2. Klares Hinzufügen von „mode raw / aaak / rooms“ zur Benchmark-Dokumentation, damit die Kompromisse sichtbar sind
> 3. Verknüpfen Sie „fact_checker.py“ mit den KG-Operationen, damit die Behauptung der Widerspruchserkennung wahr wird
> 4. Anheften von ChromaDB an einen getesteten Bereich (Problem Nr. 100), Beheben der Shell-Injektion in Hooks (Nr. 110) und Beheben des macOS ARM64-Segfaults (Nr. 74)
>
> **Vielen Dank an alle, die hier Löcher gestochen haben.** Brutale, ehrliche Kritik ist genau das, was Open Source zum Funktionieren bringt, und genau das haben wir gefordert. Besonderer Dank geht an [@panuhorsmalahti](https://github.com/milla-jovovich/mempalace/issues/43), [@lhl](https://github.com/milla-jovovich/mempalace/issues/27), [@gizmax](https://github.com/milla-jovovich/mempalace/issues/39) und alle, die zuerst ein Problem oder eine PR eingereicht haben 48 Stunden. Wir hören zu, wir reparieren, und wir möchten lieber Recht haben, als zu beeindrucken.
>
> — *Milla Jovovich & Ben Sigman*

---

## Schnellstart

```bash
pip install mempalace

# Set up your world — who you work with, what your projects are
mempalace init ~/projects/myapp

# Mine your data
mempalace mine ~/projects/myapp                    # projects — code, docs, notes
mempalace mine ~/chats/ --mode convos              # convos — Claude, ChatGPT, Slack exports
mempalace mine ~/chats/ --mode convos --extract general  # general — classifies into decisions, milestones, problems

# Search anything you've ever discussed
mempalace search "why did we switch to GraphQL"

# Your AI remembers
mempalace status
```

Bevorzugen Sie ein Skript zum Kopieren/Einfügen? Siehe [`examples/quickstart.sh`](examples/quickstart.sh). Deutscher Leitfaden: [`How_to_de.md`](How_to_de.md).

Drei Mining-Modi: **Projekte** (Code und Dokumente), **Konvos** (Konversationsexporte) und **Allgemein** (automatische Klassifizierung in Entscheidungen, Präferenzen, Meilensteine, Probleme und emotionaler Kontext). Alles bleibt auf Ihrer Maschine.

---

## Wie Sie es tatsächlich verwenden

Nach der einmaligen Einrichtung (Install → Init → Mine) führen Sie MemPalace-Befehle nicht mehr manuell aus. Ihre KI nutzt es für Sie. Es gibt zwei Möglichkeiten, je nachdem, welche KI Sie verwenden.

### Mit Claude Code (empfohlen)

Installation des nativen Marktplatzes:

```bash
claude plugin marketplace add milla-jovovich/mempalace
claude plugin install --scope user mempalace
```

Starten Sie Claude Code neu und geben Sie dann „/skills“ ein, um zu überprüfen, ob „mempalace“ angezeigt wird.

### Mit Claude, ChatGPT, Cursor, Gemini (MCP-kompatible Tools)

```bash
# Connect MemPalace once
claude mcp add mempalace -- python -m mempalace.mcp_server
```

Jetzt stehen Ihrer KI über MCP 19 Tools zur Verfügung. Fragen Sie es etwas:

> *„Was haben wir letzten Monat bezüglich der Authentifizierung entschieden?“*

Claude ruft automatisch „mempalace_search“ auf, erhält wörtliche Ergebnisse und antwortet Ihnen. Sie geben nie wieder „mempalace search“ ein. Die KI kümmert sich darum.

MemPalace funktioniert auch nativ mit **Gemini CLI** (das den Server verwaltet und Hooks automatisch speichert) – siehe [Gemini CLI-Integrationshandbuch] (examples/gemini_cli_setup.md).

### Mit lokalen Modellen (Llama, Mistral oder ein beliebiges Offline-LLM)

Lokale Models sprechen im Allgemeinen noch kein MCP. Zwei Ansätze:

**1. Weckbefehl** – Laden Sie Ihre Welt in den Kontext des Modells:

```bash
mempalace wake-up > context.txt
# Paste context.txt into your local model's system prompt
```

Dadurch erhält Ihr lokales Modell etwa 170 Token mit kritischen Fakten (auf Wunsch auch in AAAK), bevor Sie eine einzige Frage stellen.

**2. CLI-Suche** – Abfrage bei Bedarf, Eingabe der Ergebnisse in Ihre Eingabeaufforderung:

```bash
mempalace search "auth decisions" > results.txt
# Include results.txt in your prompt
```

Oder verwenden Sie die Python-API:

```python
from mempalace.searcher import search_memories
results = search_memories("auth decisions", palace_path="~/.mempalace/palace")
# Inject into your local model's context
```

So oder so – Ihr gesamter Speicherstapel läuft offline. ChromaDB auf Ihrem Computer, Llama auf Ihrem Computer, AAAK für Komprimierung, keine Cloud-Aufrufe.

---

## Das Problem

Entscheidungen fallen jetzt in Gesprächen. Nicht in Dokumenten. Nicht in Jira. In Gesprächen mit Claude, ChatGPT, Copilot. Die Argumentation, die Kompromisse, das „Wir haben X ausprobiert und es ist fehlgeschlagen, weil Y“ – alles gefangen in Chatfenstern, die verschwinden, wenn die Sitzung endet.

**Sechs Monate täglicher KI-Einsatz = 19,5 Millionen Token.** Das ist jede Entscheidung, jede Debugging-Sitzung, jede Architekturdebatte. Gegangen.

| Ansatz | Token geladen | Jährliche Kosten |
|----------|--------------|-------------|
| Alles einfügen | 19,5 M – passt in kein Kontextfenster | Unmöglich |
| LLM-Zusammenfassungen | ~650K | ~507 $/Jahr |
| **MemPalace-Weckruf** | **~170 Token** | **~0,70 $/Jahr** |
| **MemPalace + 5 Suchanfragen** | **~13.500 Token** | **~10 $/Jahr** |

MemPalace lädt beim Aufwachen 170 Token mit wichtigen Fakten – Ihr Team, Ihre Projekte, Ihre Vorlieben. Sucht dann nur bei Bedarf. 10 $/Jahr, um sich alles zu merken, im Vergleich zu 507 $/Jahr für Zusammenfassungen, die den Kontext verlieren.

---

## Wie es funktioniert

### Der Palast

Das Layout ist ziemlich einfach, obwohl es lange gedauert hat, bis es fertig war.

Es beginnt mit einem **Flügel**. Jedes Projekt, jede Person oder jedes Thema, das Sie einreichen, erhält einen eigenen Flügel im Palast.

Mit jedem Flügel sind **Räume** verbunden, in denen Informationen in Themen unterteilt sind, die sich auf diesen Flügel beziehen – sodass jeder Raum ein anderes Element dessen ist, was Ihr Projekt enthält. Projektideen könnten ein Raum sein, Mitarbeiter könnten ein anderer sein, Finanzberichte ein anderer. Es kann eine endlose Anzahl von Räumen geben, die den Flügel in Abschnitte unterteilen. Die MemPalace-Installation erkennt diese automatisch für Sie und Sie können sie natürlich nach Ihren Wünschen personalisieren.

An jedes Zimmer ist ein **Schrank** angeschlossen, und hier wird es interessant. Wir haben eine KI-Sprache namens **AAAK** entwickelt. Fragen Sie nicht – es ist eine ganz eigene Geschichte. Ihr Agent lernt jedes Mal, wenn er aufwacht, die Abkürzung AAAK. Da AAAK im Wesentlichen Englisch ist, jedoch eine sehr gekürzte Version aufweist, versteht Ihr Agent die Verwendung innerhalb von Sekunden. Es ist Teil der Installation und in den MemPalace-Code integriert. In unserem nächsten Update werden wir AAAK direkt zu den Schränken hinzufügen, was ein echter Game Changer sein wird – die Menge an Informationen in den Schränken wird viel größer sein, aber sie werden viel weniger Platz beanspruchen und viel weniger Lesezeit für Ihren Agenten.

In diesen Schränken befinden sich **Schubladen**, und in diesen Schubladen befinden sich Ihre Originaldateien. In dieser ersten Version haben wir AAAK nicht als verstecktes Tool verwendet, aber dennoch zeigten die Zusammenfassungen bei allen Benchmarks, die wir auf mehreren Benchmarking-Plattformen durchgeführt haben, **96,6 % Rückruf**. Sobald die Schränke AAAK verwenden, werden die Suchvorgänge noch schneller, während jedes Wort präzise bleibt. Aber schon jetzt ist der Closet-Ansatz ein großer Vorteil dafür, wie viele Informationen auf kleinem Raum gespeichert werden – er wird verwendet, um Ihren KI-Agenten einfach auf die Schublade zu verweisen, in der sich Ihre Originaldatei befindet. Sie verlieren nie etwas und das alles geschieht in Sekundenschnelle.

Es gibt auch **Hallen**, die Räume innerhalb eines Flügels verbinden, und **Tunnel**, die Räume verschiedener Flügel miteinander verbinden. So wird das Finden von Dingen wirklich mühelos – wir haben der KI eine saubere und organisierte Möglichkeit gegeben, zu wissen, wo sie mit der Suche beginnen soll, ohne jedes Schlüsselwort in riesigen Ordnern durchsuchen zu müssen.

Sie sagen, wonach Sie suchen, und schon weiß es, zu welchem ​​Flügel es gehen muss. Allein *das* hätte schon einen großen Unterschied gemacht. Aber das ist schön, elegant, organisch und vor allem effizient.

```
  ┌─────────────────────────────────────────────────────────────┐
  │  WING: Person                                              │
  │                                                            │
  │    ┌──────────┐  ──hall──  ┌──────────┐                    │
  │    │  Room A  │            │  Room B  │                    │
  │    └────┬─────┘            └──────────┘                    │
  │         │                                                  │
  │         ▼                                                  │
  │    ┌──────────┐      ┌──────────┐                          │
  │    │  Closet  │ ───▶ │  Drawer  │                          │
  │    └──────────┘      └──────────┘                          │
  └─────────┼──────────────────────────────────────────────────┘
            │
          tunnel
            │
  ┌─────────┼──────────────────────────────────────────────────┐
  │  WING: Project                                             │
  │         │                                                  │
  │    ┌────┴─────┐  ──hall──  ┌──────────┐                    │
  │    │  Room A  │            │  Room C  │                    │
  │    └────┬─────┘            └──────────┘                    │
  │         │                                                  │
  │         ▼                                                  │
  │    ┌──────────┐      ┌──────────┐                          │
  │    │  Closet  │ ───▶ │  Drawer  │                          │
  │    └──────────┘      └──────────┘                          │
  └─────────────────────────────────────────────────────────────┘
```

**Flügel** – eine Person oder ein Projekt. So viele wie Sie brauchen.
**Räume** – spezifische Themen innerhalb eines Flügels. Authentifizierung, Abrechnung, Bereitstellung – endlose Räume.
**Hallen** – Verbindungen zwischen verwandten Räumen *innerhalb* desselben Flügels. Wenn Raum A (Authentifizierung) und Raum B (Sicherheit) miteinander verbunden sind, werden sie durch einen Flur verbunden.
**Tunnel** – Verbindungen *zwischen* Flügeln. Wenn Person A und ein Projekt beide einen Raum zum Thema „Authentifizierung“ haben, werden sie durch einen Tunnel automatisch miteinander verknüpft.
**Schränke** – Zusammenfassungen, die auf den ursprünglichen Inhalt verweisen. (In Version 3.0.0 handelt es sich dabei um Zusammenfassungen im Klartext; AAAK-codierte Schränke werden in einem zukünftigen Update verfügbar sein – siehe [Aufgabe Nr. 30](https://github.com/milla-jovovich/mempalace/issues/30).)
**Schubladen** – die ursprünglichen wörtlichen Dateien. Die genauen Worte, nie zusammengefasst.

**Hallen** sind Erinnerungstypen – in jedem Flügel gleich und fungieren als Korridore:
- „hall_facts“ – getroffene Entscheidungen, festgelegte Entscheidungen
- „hall_events“ – Sitzungen, Meilensteine, Debugging
- „hall_discoveries“ – Durchbrüche, neue Erkenntnisse
- „hall_preferences“ – Gewohnheiten, Vorlieben, Meinungen
- „hall_advice“ – Empfehlungen und Lösungen

**Räume** sind benannte Ideen – „auth-migration“, „graphql-switch“, „ci-pipeline“. Wenn derselbe Raum in verschiedenen Flügeln erscheint, entsteht ein **Tunnel**, der dasselbe Thema über Domänen hinweg verbindet:

```
wing_kai       / hall_events / auth-migration  → "Kai debugged the OAuth token refresh"
wing_driftwood / hall_facts  / auth-migration  → "team decided to migrate auth to Clerk"
wing_priya     / hall_advice / auth-migration  → "Priya approved Clerk over Auth0"
```

Gleiches Zimmer. Drei Flügel. Der Tunnel verbindet sie.

### Warum Struktur wichtig ist

Getestet an über 22.000 echten Gesprächserinnerungen:

```
Search all closets:          60.9%  R@10
Search within wing:          73.1%  (+12%)
Search wing + hall:          84.8%  (+24%)
Search wing + room:          94.8%  (+34%)
```

Flügel und Räume sind nicht kosmetisch. Sie bedeuten eine **34 %ige Verbesserung beim Abrufen**. Die Palaststruktur ist das Produkt.

### Der Speicherstapel

| Schicht | Was | Größe | Wann |
|-------|------|------|------|
| **L0** | Identität – wer ist diese KI? | ~50 Token | Immer geladen |
| **L1** | Kritische Fakten – Team, Projekte, Vorlieben | ~120 Token (AAAK) | Immer geladen |
| **L2** | Raumrückruf – letzte Sitzungen, aktuelles Projekt | Auf Anfrage | Wenn das Thema auftaucht |
| **L3** | Tiefensuche – semantische Suche über alle Schränke hinweg | Auf Anfrage | Auf ausdrückliche Nachfrage |

Deine KI wacht mit L0 + L1 (~170 Token) auf und kennt deine Welt. Suchvorgänge werden nur bei Bedarf ausgelöst.

### AAAK-Dialekt (experimentell)

AAAK ist ein verlustbehaftetes Abkürzungssystem – Entitätscodes, Strukturmarkierungen und Satzkürzungen –, das darauf ausgelegt ist, wiederholte Entitäten und Beziehungen in weniger Tokens im großen Maßstab zu packen. Es ist **von jedem LLM lesbar, das Text liest** (Claude, GPT, Gemini, Llama, Mistral) ohne Decoder, sodass ein lokales Modell es ohne Cloud-Abhängigkeit verwenden kann.

**Ehrlichkeitsstatus (April 2026):**

- **AAAK ist verlustbehaftet, nicht verlustfrei.** Es verwendet eine auf Regex basierende Abkürzung, keine reversible Komprimierung.
- **In kleinen Mengen werden keine Tokens gespeichert.** Kurzer Text ermöglicht bereits eine effiziente Tokenisierung. Der AAAK-Overhead (Codes, Trennzeichen) kostet mehr, als er bei ein paar Sätzen einspart.
- **Es kann Tokens in großem Umfang einsparen** – in Szenarien mit vielen sich wiederholenden Entitäten (ein Team wird hunderte Male erwähnt, dasselbe Projekt über Tausende von Sitzungen hinweg) amortisieren sich die Entitätscodes.
- **AAAK führt derzeit zu einer Regression von LongMemEval** im Vergleich zum rohen wörtlichen Abruf (84,2 % R@5 vs. 96,6 %). Die Schlagzeilenzahl von 96,6 % stammt aus dem **Rohmodus**, nicht aus dem AAAK-Modus.
- **Der MemPalace-Speicherstandard ist roher wörtlicher Text in ChromaDB** – daher kommen die Benchmark-Siege. AAAK ist eine separate Komprimierungsschicht zum Laden des Kontexts, nicht das Speicherformat.

Wir iterieren an der Dialektspezifikation, fügen einen echten Tokenizer für Statistiken hinzu und suchen nach besseren Haltepunkten für die Verwendung. Verfolgen Sie den Fortschritt in [Ausgabe Nr. 43] (https://github.com/milla-jovovich/mempalace/issues/43) und [Nr. 27] (https://github.com/milla-jovovich/mempalace/issues/27).

### Widerspruchserkennung (experimentell, noch nicht in KG verkabelt)

Ein separates Dienstprogramm („fact_checker.py“) kann Behauptungen anhand von Entitätsfakten prüfen. Es wird derzeit nicht automatisch von den Knowledge Graph-Operationen aufgerufen – dies wird behoben (Track in [Problem Nr. 27](https://github.com/milla-jovovich/mempalace/issues/27)). Wenn es aktiviert ist, werden Dinge erfasst wie:

```
Input:  "Soren finished the auth migration"
Output: 🔴 AUTH-MIGRATION: attribution conflict — Maya was assigned, not Soren

Input:  "Kai has been here 2 years"
Output: 🟡 KAI: wrong_tenure — records show 3 years (started 2023-04)

Input:  "The sprint ends Friday"
Output: 🟡 SPRINT: stale_date — current sprint ends Thursday (updated 2 days ago)
```

Fakten anhand des Wissensgraphen überprüft. Alter, Daten und Amtszeiten werden dynamisch berechnet – nicht fest codiert.

---

## Beispiele aus der Praxis

### Solo-Entwickler für mehrere Projekte

```bash
# Mine each project's conversations
mempalace mine ~/chats/orion/  --mode convos --wing orion
mempalace mine ~/chats/nova/   --mode convos --wing nova
mempalace mine ~/chats/helios/ --mode convos --wing helios

# Six months later: "why did I use Postgres here?"
mempalace search "database decision" --wing orion
# → "Chose Postgres over SQLite because Orion needs concurrent writes
#    and the dataset will exceed 10GB. Decided 2025-11-03."

# Cross-project search
mempalace search "rate limiting approach"
# → finds your approach in Orion AND Nova, shows the differences
```

### Teamleiter, der ein Produkt verwaltet

```bash
# Mine Slack exports and AI conversations
mempalace mine ~/exports/slack/ --mode convos --wing driftwood
mempalace mine ~/.claude/projects/ --mode convos

# "What did Soren work on last sprint?"
mempalace search "Soren sprint" --wing driftwood
# → 14 closets: OAuth refactor, dark mode, component library migration

# "Who decided to use Clerk?"
mempalace search "Clerk decision" --wing driftwood
# → "Kai recommended Clerk over Auth0 — pricing + developer experience.
#    Team agreed 2026-01-15. Maya handling the migration."
```

### Vor dem Mining: Megadateien aufteilen

Bei manchen Transkript-Exporten werden mehrere Sitzungen zu einer großen Datei zusammengefasst:

```bash
mempalace split ~/chats/                      # split into per-session files
mempalace split ~/chats/ --dry-run            # preview first
mempalace split ~/chats/ --min-sessions 3     # only split files with 3+ sessions
```

---

## Wissensgraph

Zeitliche Entitäts-Beziehungs-Tripel – wie Zeps Graphiti, aber SQLite anstelle von Neo4j. Lokal und kostenlos.

```python
from mempalace.knowledge_graph import KnowledgeGraph

kg = KnowledgeGraph()
kg.add_triple("Kai", "works_on", "Orion", valid_from="2025-06-01")
kg.add_triple("Maya", "assigned_to", "auth-migration", valid_from="2026-01-15")
kg.add_triple("Maya", "completed", "auth-migration", valid_from="2026-02-01")

# What's Kai working on?
kg.query_entity("Kai")
# → [Kai → works_on → Orion (current), Kai → recommended → Clerk (2026-01)]

# What was true in January?
kg.query_entity("Maya", as_of="2026-01-20")
# → [Maya → assigned_to → auth-migration (active)]

# Timeline
kg.timeline("Orion")
# → chronological story of the project
```

Fakten haben Gültigkeitsfenster. Wenn etwas nicht mehr wahr ist, machen Sie es ungültig:

```python
kg.invalidate("Kai", "works_on", "Orion", ended="2026-03-01")
```

Jetzt wird bei Anfragen nach Kais aktueller Arbeit Orion nicht zurückgegeben. Historische Abfragen werden dies weiterhin tun.

| Besonderheit | MemPalace | Zep (Graphiti) |
|---------|-----------|----------------|
| Lagerung | SQLite (lokal) | Neo4j (Cloud) |
| Kosten | Frei | 25 $/Monat+ |
| Zeitliche Gültigkeit | Ja | Ja |
| Selbst gehostet | Stets | Nur für Unternehmen |
| Privatsphäre | Alles lokal | SOC 2, HIPAA |

---

## Spezialagenten

Erstellen Sie Agenten, die sich auf bestimmte Bereiche konzentrieren. Jeder Agent erhält seinen eigenen Flügel und sein eigenes Tagebuch im Palast – nicht in Ihrem CLAUDE.md. Fügen Sie 50 Agenten hinzu, Ihre Konfiguration bleibt gleich groß.

```
~/.mempalace/agents/
  ├── reviewer.json       # code quality, patterns, bugs
  ├── architect.json      # design decisions, tradeoffs
  └── ops.json            # deploys, incidents, infra
```

Ihr CLAUDE.md benötigt nur eine Zeile:

```
You have MemPalace agents. Run mempalace_list_agents to see them.
```

Die KI entdeckt ihre Agenten aus dem Palast zur Laufzeit. Jeder Agent:

- **Hat einen Fokus** – worauf es achtet
- **Führt ein Tagebuch** – in AAAK geschrieben, bleibt sitzungsübergreifend erhalten
- **Baut Fachwissen auf** – liest seine eigene Geschichte, um in seinem Bereich auf dem Laufenden zu bleiben

```
# Agent writes to its diary after a code review
mempalace_diary_write("reviewer",
    "PR#42|auth.bypass.found|missing.middleware.check|pattern:3rd.time.this.quarter|★★★★")

# Agent reads back its history
mempalace_diary_read("reviewer", last_n=10)
# → last 10 findings, compressed in AAAK
```

Jeder Agent ist ein spezieller Blick auf Ihre Daten. Der Rezensent merkt sich jedes erkannte Fehlermuster. Der Architekt erinnert sich an jede Entwurfsentscheidung. Der Einsatzagent erinnert sich an jeden Vorfall. Sie teilen sich keinen Notizblock – jeder behält sein eigenes Gedächtnis.

Letta berechnet 20–200 US-Dollar/Monat für vom Agenten verwalteten Speicher. MemPalace macht es mit einem Flügel.

---

## MCP-Server

```bash
# Via plugin (recommended)
claude plugin marketplace add milla-jovovich/mempalace
claude plugin install --scope user mempalace

# Or manually
claude mcp add mempalace -- python -m mempalace.mcp_server
```

### 19 Werkzeuge

**Palast (lesen)**

| Werkzeug | Was |
|------|------|
| `mempalace_status` | Palace-Übersicht + AAAK-Spezifikation + Speicherprotokoll |
| `mempalace_list_wings` | Flügel mit Zählungen |
| `mempalace_list_rooms` | Zimmer innerhalb eines Flügels |
| `mempalace_get_taxonomy` | Voller Flügel → Raum → Zählbaum |
| `mempalace_search` | Semantische Suche mit Flügel-/Raumfiltern |
| `mempalace_check_duplicate` | Überprüfen Sie dies vor der Einreichung |
| `mempalace_get_aaak_spec` | AAAK-Dialektreferenz |

**Palast (schreiben)**

| Werkzeug | Was |
|------|------|
| `mempalace_add_drawer` | Wörtlichen Inhalt der Datei |
| `mempalace_delete_drawer` | Nach ID entfernen |

**Wissensdiagramm**

| Werkzeug | Was |
|------|------|
| `mempalace_kg_query` | Entitätsbeziehungen mit Zeitfilterung |
| `mempalace_kg_add` | Fakten hinzufügen |
| `mempalace_kg_invalidate` | Fakten als beendet markieren |
| `mempalace_kg_timeline` | Chronologische Entitätsgeschichte |
| `mempalace_kg_stats` | Diagrammübersicht |

**Navigation**

| Werkzeug | Was |
|------|------|
| `mempalace_traverse` | Gehen Sie die Grafik von einem Raum aus über die Flügel |
| `mempalace_find_tunnels` | Finden Sie Räume, die zwei Flügel überbrücken |
| `mempalace_graph_stats` | Übersicht über die Diagrammkonnektivität |

**Agententagebuch**

| Werkzeug | Was |
|------|------|
| `mempalace_diary_write` | Schreiben Sie einen AAAK-Tagebucheintrag |
| `mempalace_diary_read` | Lesen Sie aktuelle Tagebucheinträge |

Die KI lernt AAAK und das Speicherprotokoll automatisch aus der „mempalace_status“-Antwort. Keine manuelle Konfiguration.

---

## Hooks automatisch speichern

Zwei Hooks für Claude Code, die Erinnerungen während der Arbeit automatisch speichern:

**Save Hook** – löst alle 15 Nachrichten eine strukturierte Speicherung aus. Themen, Entscheidungen, Zitate, Codeänderungen. Regeneriert außerdem die Ebene mit den kritischen Fakten.

**PreCompact Hook** – wird vor der Kontextkomprimierung ausgelöst. Notfallspeicherung, bevor das Fenster kleiner wird.

```json
{
  "hooks": {
    "Stop": [{"matcher": "", "hooks": [{"type": "command", "command": "/path/to/mempalace/hooks/mempal_save_hook.sh"}]}],
    "PreCompact": [{"matcher": "", "hooks": [{"type": "command", "command": "/path/to/mempalace/hooks/mempal_precompact_hook.sh"}]}]
  }
}
```

**Optionale automatische Aufnahme:** Setzen Sie die Umgebungsvariable „MEMPAL_DIR“ auf einen Verzeichnispfad und die Hooks führen „mempalace mine“ bei jedem Speicherauslöser automatisch in diesem Verzeichnis aus (im Hintergrund bei Stopp, synchron bei Vorkomprimierung).

---

## Benchmarks

Getestet anhand standardmäßiger akademischer Benchmarks – reproduzierbare, veröffentlichte Datensätze.

| Benchmark | Modus | Punktzahl | API-Aufrufe |
|-----------|------|-------|-----------|
| **LongMemEval R@5** | Raw (nur ChromaDB) | **96,6 %** | Null |
| **LongMemEval R@5** | Hybrid + Haiku neu eingestuft | **100 %** (500/500) | ~500 |
| **LoCoMo R@10** | Roh, Sitzungsebene | **60,3 %** | Null |
| **Persönlicher Palast R@10** | Heuristische Bank | **85%** | Null |
| **Auswirkungen auf die Palaststruktur** | Flügel- und Raumfilterung | **+34 %** R@10 | Null |

Der Rohwert von 96,6 % ist das höchste veröffentlichte LongMemEval-Ergebnis, das zu keinem Zeitpunkt einen API-Schlüssel, keine Cloud und kein LLM erfordert.

### vs. veröffentlichte Systeme

| System | LongMemEval R@5 | API erforderlich | Kosten |
|--------|----------------|--------------|------|
| **MemPalace (Hybrid)** | **100%** | Optional | Frei |
| Supermemory ASMR | ~99 % | Ja | — |
| **MemPalace (roh)** | **96,6 %** | **Keiner** | **Frei** |
| Mastra | 94,87 % | Ja (GPT) | API-Kosten |
| Speicher0 | ~85 % | Ja | 19–249 $/Monat |
| Zep | ~85 % | Ja | 25 $/Monat+ |

---

## Alle Befehle

```bash
# Setup
mempalace init <dir>                              # guided onboarding + AAAK bootstrap

# Mining
mempalace mine <dir>                              # mine project files
mempalace mine <dir> --mode convos                # mine conversation exports
mempalace mine <dir> --mode convos --wing myapp   # tag with a wing name

# Splitting
mempalace split <dir>                             # split concatenated transcripts
mempalace split <dir> --dry-run                   # preview

# Search
mempalace search "query"                          # search everything
mempalace search "query" --wing myapp             # within a wing
mempalace search "query" --room auth-migration    # within a room

# Memory stack
mempalace wake-up                                 # load L0 + L1 context
mempalace wake-up --wing driftwood                # project-specific

# Compression
mempalace compress --wing myapp                   # AAAK compress

# Status
mempalace status                                  # palace overview

# MCP
mempalace mcp                                     # show MCP setup command
```

Alle Befehle akzeptieren „--palace <Pfad>“, um den Standardspeicherort zu überschreiben.

---

## Konfiguration

### Global (`~/.mempalace/config.json`)

```json
{
  "palace_path": "/custom/path/to/palace",
  "collection_name": "mempalace_drawers",
  "people_map": {"Kai": "KAI", "Priya": "PRI"}
}
```

### Wing-Konfiguration (`~/.mempalace/wing_config.json`)

Erzeugt von „mempalace init“. Ordnet Ihre Mitarbeiter und Projekte Wings zu:

```json
{
  "default_wing": "wing_general",
  "wings": {
    "wing_kai": {"type": "person", "keywords": ["kai", "kai's"]},
    "wing_driftwood": {"type": "project", "keywords": ["driftwood", "analytics", "saas"]}
  }
}
```

### Identität (`~/.mempalace/identity.txt`)

Klartext. Wird zu Layer 0 – wird bei jeder Sitzung geladen.

---

## Dateireferenz

| Datei | Was |
|------|------|
| `cli.py` | CLI-Einstiegspunkt |
| `config.py` | Laden der Konfiguration und Standardeinstellungen |
| `normalize.py` | Konvertiert 5 Chatformate in Standardtranskripte |
| `mcp_server.py` | MCP-Server – 19 Tools, AAAK-Auto-Teach, Speicherprotokoll |
| `miner.py` | Aufnahme der Projektdatei |
| „convo_miner.py“. | Konversationsaufnahme – Blöcke nach Austauschpaar |
| `searcher.py` | Semantische Suche über ChromaDB |
| `layers.py` | 4-lagiger Speicherstapel |
| `dialect.py` | AAAK-Komprimierung – 30x verlustfrei |
| `knowledge_graph.py` | Zeitlicher Entitätsbeziehungsgraph (SQLite) |
| `palace_graph.py` | Raumbasiertes Navigationsdiagramm |
| „onboarding.py“. | Geführte Einrichtung – generiert AAAK-Bootstrap + Wing-Konfiguration |
| `entity_registry.py` | Entitätscode-Registrierung |
| `entity_detector.py` | Erkennen Sie Personen und Projekte automatisch anhand von Inhalten |
| `split_mega_files.py` | Teilen Sie verkettete Transkripte in Dateien pro Sitzung auf |
| `hooks/mempal_save_hook.sh` | Alle N Nachrichten automatisch speichern |
| `hooks/mempal_precompact_hook.sh` | Notfallspeicherung vor der Verdichtung |

---

## Projektstruktur

```
mempalace/
├── README.md                  ← you are here
├── mempalace/                 ← core package (README)
│   ├── cli.py                 ← CLI entry point
│   ├── mcp_server.py          ← MCP server (19 tools)
│   ├── knowledge_graph.py     ← temporal entity graph
│   ├── palace_graph.py        ← room navigation graph
│   ├── dialect.py             ← AAAK compression
│   ├── miner.py               ← project file ingest
│   ├── convo_miner.py         ← conversation ingest
│   ├── searcher.py            ← semantic search
│   ├── onboarding.py          ← guided setup
│   └── ...                    ← see mempalace/README.md
├── benchmarks/                ← reproducible benchmark runners
│   ├── README.md              ← reproduction guide
│   ├── BENCHMARKS.md          ← full results + methodology
│   ├── longmemeval_bench.py   ← LongMemEval runner
│   ├── locomo_bench.py        ← LoCoMo runner
│   └── membench_bench.py      ← MemBench runner
├── hooks/                     ← Claude Code auto-save hooks
│   ├── README.md              ← hook setup guide
│   ├── mempal_save_hook.sh    ← save every N messages
│   └── mempal_precompact_hook.sh ← emergency save
├── examples/                  ← usage examples
│   ├── basic_mining.py
│   ├── convo_import.py
│   └── mcp_setup.md
├── tests/                     ← test suite (README)
├── assets/                    ← logo + brand assets
└── pyproject.toml             ← package config (v3.0.0)
```

---

## Anforderungen

- Python 3.9+
- `chromadb>=0.4.0`
- `pyyaml>=6.0`

Kein API-Schlüssel. Kein Internet nach der Installation. Alles lokal.

```bash
pip install mempalace
```

---

## Mitwirken

PRs willkommen. Informationen zur Einrichtung und zu Richtlinien finden Sie unter [CONTRIBUTING.md](CONTRIBUTING.md).

## Lizenz

MIT – siehe [LIZENZ](LIZENZ).

<!-- Link Definitions -->
[version-shield]: https://img.shields.io/badge/version-3.1.0-4dc9f6?style=flat-square&labelColor=0a0e14
[release-link]: https://github.com/milla-jovovich/mempalace/releases
[python-shield]: https://img.shields.io/badge/python-3.9+-7dd8f8?style=flat-square&labelColor=0a0e14&logo=python&logoColor=7dd8f8
[python-link]: https://www.python.org/
[license-shield]: https://img.shields.io/badge/license-MIT-b0e8ff?style=flat-square&labelColor=0a0e14
[license-link]: https://github.com/milla-jovovich/mempalace/blob/main/LICENSE
[discord-shield]: https://img.shields.io/badge/discord-join-5865F2?style=flat-square&labelColor=0a0e14&logo=discord&logoColor=5865F2
[discord-link]: https://discord.com/invite/ycTQQCu6kn
