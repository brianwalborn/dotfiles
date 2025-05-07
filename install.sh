#!/usr/bin/env zsh

cd "$(dirname "${ZSH_SOURCE}")";

git pull origin main;

function install() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude "install.sh" \
  		--exclude "README.md" \
		-avh --no-perms . ~;

	source ~/.zprofile;
}

if [[ "$1" == "--force" ]] || [[ "$1" == "-f" ]]; then
	install;
else
	vared -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -c REPLY;

	echo "";

	if [[ $REPLY =~ ^[Yy]$ ]]; then
		install;
	fi;
fi;

unset install;
