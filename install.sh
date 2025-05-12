#!/usr/bin/env zsh

backup_file() {
  local target="$1"

  if [[ -e "$target" ]]; then
    local backup="${target}.backup"

    echo "--> backing up $target to $backup"
    mv "$target" "$backup"
  fi
}

install_dotfile() {
  local file="$1"
  local src="./$file"
  local dest="$HOME/$file"

  backup_file "$dest"

  echo "--> copying $file to $dest"
  cp "$src" "$dest"
}

install_all_dotfiles() {
  echo "--> copying dotfiles from $(pwd)..."

  for file in .[^.]*; do
    if [[ -f "$file" ]]; then
      install_dotfile "$file"
    fi
  done

  source "$HOME/.zprofile"

  echo "--> installation complete!"
}

install_all_dotfiles
