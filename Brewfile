# Only what the configs in this repo depend on, not a snapshot of the machine.
# See the package table in README.md for what needs each one.
#
# Applied by install.sh with --no-upgrade. Xcode command line tools are assumed
# present for cc/make, which nvim needs to build telescope-fzf-native.

brew "awscli"
brew "colima"
brew "devcontainer"
brew "docker"
brew "docker-compose"
brew "git"
brew "go"
brew "jq"
brew "kubernetes-cli"
brew "libpq"
brew "mise"
brew "neovim"
brew "pnpm"
# Declared explicitly because it is otherwise only present as a transitive
# dependency of an unrelated cask, which would take telescope's grep with it.
brew "ripgrep"
brew "tmux"

cask "font-jetbrains-mono-nerd-font"
cask "kitty"
cask "visual-studio-code"

# postgresql@15 is deliberately absent even though .path adds its bin directory:
# provisioning a database server as a side effect of a dotfiles run would be a
# surprise, and libpq above covers the client tools.
