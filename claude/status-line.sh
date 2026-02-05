#!/usr/bin/env zsh

input=$(cat)

# misc values from json
CONTEXT_SIZE=$(echo "$input" | jq -r '.context_window.context_window_size')
CWD=$(echo "$input" | jq -r '.workspace.current_dir' | sed "s|$HOME|~|")
MODEL=$(echo "$input" | jq -r '.model.display_name')
TOKENS_USED=$(echo "$input" | jq -r '.context_window.total_input_tokens + .context_window.total_output_tokens')
USAGE_PCT=$(echo "$input" | jq -r '.context_window.used_percentage')

# git branch if in a git repo
BRANCH=$(git -C "$CWD" rev-parse --abbrev-ref HEAD 2>/dev/null)

# color codes
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RESET='\033[0m'

# build status line
printf "${CYAN}%s${RESET} | ${GREEN}%s${RESET} | ctx: ${YELLOW}%.1f%%${RESET}" \
  "$MODEL" \
  "${BRANCH:-$CWD}" \
  "$USAGE_PCT"
