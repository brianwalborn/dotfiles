#!/usr/bin/env zsh

cd "$(dirname "${ZSH_SOURCE}")";

git pull origin main;

function install() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude "install.sh" \
		-avh --no-perms . ~;

	source ~/.zprofile;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	install;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;

	echo "";

	if [[ $REPLY =~ ^[Yy]$ ]]; then
		install;
	fi;
fi;

unset install;
