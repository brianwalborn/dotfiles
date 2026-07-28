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

# Copies a config directory into place, recursing through subdirectories. Any
# trailing arguments name files that are left alone when they already exist,
# for configs that accumulate machine-local state.
install_config_dir() {
  local source_dir="$1"
  local dest_dir="$2"
  shift 2
  local protected_files=("$@")

  echo "--> installing $source_dir configuration..."

  local source_file
  for source_file in "./$source_dir"/**/*(.N); do
    local relative_path="${source_file#./$source_dir/}"
    local dest="$dest_dir/$relative_path"

    if (( ${protected_files[(Ie)$relative_path]} )) && [[ -f "$dest" ]]; then
      echo "--> skipping $relative_path (already exists)"
      echo "    please manually merge $source_file with $dest"
      continue
    fi

    backup_file "$dest"

    mkdir -p "$(dirname "$dest")"

    echo "--> copying $source_file to $dest"
    cp "$source_file" "$dest"
  done
}

# Configs are inert without the binaries behind them, so this runs first.
install_packages() {
  if ! type brew > /dev/null 2>&1; then
    echo "--> homebrew not found, installing it..."
    # The installer prompts for sudo and a confirmation. Export NONINTERACTIVE=1
    # beforehand to skip both when running this unattended.
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # The installer leaves the calling shell untouched, so brew has to be put on
    # PATH here before the bundle below can find it. .zprofile does the same on
    # every login.
    if [[ -r "/opt/homebrew/bin/brew" ]]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    if ! type brew > /dev/null 2>&1; then
      echo "--> homebrew installation failed, skipping packages"
      return
    fi
  fi

  echo "--> installing homebrew packages..."
  # --no-upgrade because `brew bundle` upgrades outdated dependencies by default,
  # and quietly upgrading toolchains like go and node is not what someone running
  # a dotfiles install is asking for. Run `brew bundle upgrade` deliberately.
  brew bundle install --file=./Brewfile --no-upgrade
}

install_all_dotfiles() {
  install_packages

  echo "--> copying dotfiles from $(pwd)..."

  for file in .[^.]*; do
    # Skip git's own metadata. Inside a worktree .git is a file rather than a
    # directory, so it would otherwise be copied and make $HOME look like a repo.
    case "$file" in
      .git | .gitignore) continue ;;
    esac

    if [[ -f "$file" ]]; then
      install_dotfile "$file"
    fi
  done

  install_config_dir "claude" "$HOME/.claude" "settings.json"
  # colima only reads _templates when creating an instance, so this never
  # disturbs an existing VM; it shapes the next one.
  install_config_dir "colima" "$HOME/.colima"
  install_config_dir "docker" "$HOME/.docker" "config.json"
  install_config_dir "kitty" "${XDG_CONFIG_HOME:-$HOME/.config}/kitty"
  install_config_dir "nvim" "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

  source "$HOME/.zprofile"

  echo "--> installation complete!"
}

install_all_dotfiles
