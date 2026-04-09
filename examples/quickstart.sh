#!/usr/bin/env bash
set -euo pipefail

# Install MemPalace
pip install mempalace

# Set up your world — who you work with, what your projects are
mempalace init ~/projects/myapp

# Mine your data
mempalace mine ~/projects/myapp                             # projects — code, docs, notes
mempalace mine ~/chats/ --mode convos                       # convos — Claude, ChatGPT, Slack exports
mempalace mine ~/chats/ --mode convos --extract general     # general — classifies into decisions, milestones, problems

# Search anything you've ever discussed
mempalace search "why did we switch to GraphQL"

# Your AI remembers
mempalace status
