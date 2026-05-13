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

install_claude_config() {
  local claude_dir="$HOME/.claude"

  echo "--> installing claude configuration..."

  if [[ ! -d "$claude_dir" ]]; then
    echo "--> creating $claude_dir directory"
    mkdir -p "$claude_dir"
  fi

  for file in claude/*; do
    if [[ -f "$file" ]]; then
      local filename=$(basename "$file")
      local dest="$claude_dir/$filename"

      # special handling for settings.json - don't overwrite existing config
      if [[ "$filename" == "settings.json" && -f "$dest" ]]; then
        echo "--> skipping settings.json (already exists)"
        echo "    please manually merge ./claude/settings.json with $dest"
        continue
      fi

      backup_file "$dest"

      echo "--> copying $file to $dest"
      cp "$file" "$dest"
    fi
  done
}

install_docker_config() {
  local docker_dir="$HOME/.docker"

  echo "--> installing docker configuration..."

  if [[ ! -d "$docker_dir" ]]; then
    echo "--> creating $docker_dir directory"
    mkdir -p "$docker_dir"
  fi

  for file in docker/*; do
    if [[ -f "$file" ]]; then
      local filename=$(basename "$file")
      local dest="$docker_dir/$filename"

      # special handling for config.json - don't overwrite existing config
      if [[ "$filename" == "config.json" && -f "$dest" ]]; then
        echo "--> skipping config.json (already exists)"
        echo "    please manually merge ./docker/config.json with $dest"
        continue
      fi

      backup_file "$dest"

      echo "--> copying $file to $dest"
      cp "$file" "$dest"
    fi
  done
}

install_all_dotfiles() {
  echo "--> copying dotfiles from $(pwd)..."

  for file in .[^.]*; do
    if [[ -f "$file" ]]; then
      install_dotfile "$file"
    fi
  done

  install_claude_config
  install_docker_config

  source "$HOME/.zprofile"

  echo "--> installation complete!"
}

install_all_dotfiles
