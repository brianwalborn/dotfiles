#!/usr/bin/env zsh

# homebrew comes first: .path resolves brew prefixes, so brew has to already be
# on PATH by the time it is sourced.
if [ -r "/opt/homebrew/bin/brew" ]; then
   eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
#
# Order is load order, not preference: .exports defines variables that .path and
# .completions read, so it goes first.
for file in ~/.{exports,path,completions,aliases,functions,zprompt}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# mise last, so its shims take precedence over the paths set above
if type "mise" > /dev/null; then
   eval "$(mise activate zsh)"
fi

# https://code.visualstudio.com/remote/advancedcontainers/sharing-git-credentials#_using-ssh-keys
if [ -z "$SSH_AUTH_SOCK" ]; then
   # Check for a currently running instance of the agent
   RUNNING_AGENT="`ps -ax | grep 'ssh-agent -s' | grep -v grep | wc -l | tr -d '[:space:]'`";

   if [ "$RUNNING_AGENT" = "0" ]; then
        # Launch a new instance of the agent
        ssh-agent -s &> $HOME/.ssh/ssh-agent;
   fi

   eval `cat $HOME/.ssh/ssh-agent` > /dev/null;

   ssh-add $HOME/.ssh/id_rsa.pub 2> /dev/null;
fi
