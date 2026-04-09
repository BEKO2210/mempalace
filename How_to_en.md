# MemPalace How-To (English)

[![Python 3.10+](https://img.shields.io/badge/Python-3.10%2B-blue)](https://www.python.org/)
[![CLI Guide](https://img.shields.io/badge/Guide-CLI%20%26%20MCP-success)](README.md)
[![Local First](https://img.shields.io/badge/Runtime-Local%20First-orange)](README.md)

A professional, practical guide for setup, data ingestion, and daily MemPalace usage.

---

## Contents

1. [Prerequisites](#prerequisites)
2. [Install](#install)
3. [Initialize your palace](#initialize-your-palace)
4. [Ingest data (`mine`)](#ingest-data-mine)
5. [Search and status checks](#search-and-status-checks)
6. [Connect AI tools (MCP)](#connect-ai-tools-mcp)
7. [Recommended daily workflow](#recommended-daily-workflow)
8. [Troubleshooting](#troubleshooting)

---

## Prerequisites

- Python **3.10+**
- Terminal access to your project and chat directories
- Optional: Claude/Cursor/Gemini/ChatGPT environment with MCP support

---

## Install

```bash
pip install mempalace
```

Verify:

```bash
mempalace --help
```

---

## Initialize your palace

```bash
mempalace init ~/projects/myapp
```

This creates the base structure for your project memory.

---

## Ingest data (`mine`)

### 1) Project files (code, docs, notes)

```bash
mempalace mine ~/projects/myapp
```

### 2) Conversations (Claude, ChatGPT, Slack exports)

```bash
mempalace mine ~/chats/ --mode convos
```

### 3) Conversations + semantic extraction

```bash
mempalace mine ~/chats/ --mode convos --extract general
```

`--extract general` helps surface decisions, milestones, and problems more quickly later.

---

## Search and status checks

### Search

```bash
mempalace search "why did we switch to GraphQL"
```

German query example:

```bash
mempalace search "Warum haben wir auf GraphQL gewechselt?"
```

### Status

```bash
mempalace status
```

---

## Connect AI tools (MCP)

Example with Claude CLI:

```bash
claude mcp add mempalace -- python -m mempalace.mcp_server
```

After this, your assistant can call MemPalace tools directly instead of you manually running `mempalace search ...` each time.

---

## Recommended daily workflow

1. **One-time setup:** `pip install mempalace` and `mempalace init ...`
2. **Regularly:** ingest new content with `mempalace mine ...`
3. **In AI chat:** ask for historical decisions and context
4. **When needed:** run targeted lookup with `mempalace search "..."`

---

## Troubleshooting

- **`mempalace: command not found`**  
  Check your Python/Pip environment and PATH.
- **Empty search results**  
  Import content first with `mempalace mine ...`.
- **MCP connection not working**  
  Re-add the MCP entry and restart your CLI/editor.

---

## Optional quickstart template

If you prefer a direct command template:

- [`examples/quickstart.sh`](examples/quickstart.sh)
