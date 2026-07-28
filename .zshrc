#!/usr/bin/env zsh

# .zprofile is the single entry point; it sources .completions, which sets up bun
# and asyncapi completions.
[ -n "$PROMPT" ] && source ~/.zprofile;
