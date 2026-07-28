# dotfiles

Personal machine configuration: zsh, nvim, kitty, tmux, colima, and Claude Code.

## Installation

```sh
./install.sh
```

Installs Homebrew if it is missing, applies the `Brewfile`, then copies configs
into place. Safe to re-run.

- Existing files are moved to `<name>.backup` first.
- `claude/settings.json` and `docker/config.json` are never overwritten.
- Configs are **copied, not symlinked**, so edits under `~/.config` do not flow
  back here, and files deleted from this repo are left behind on disk.
- Outdated formulae are left alone. Run `brew bundle upgrade` to bump them.

## What goes where

| Source    | Destination                            |
| --------- | -------------------------------------- |
| `.*`      | `$HOME`                                |
| `claude/` | `$HOME/.claude`                        |
| `colima/` | `$HOME/.colima`                        |
| `docker/` | `$HOME/.docker`                        |
| `kitty/`  | `$XDG_CONFIG_HOME/kitty` (`~/.config`) |
| `nvim/`   | `$XDG_CONFIG_HOME/nvim` (`~/.config`)  |

## Packages

| Package                         | Needed by                                           |
| ------------------------------- | --------------------------------------------------- |
| `awscli`                        | `.aliases` aws shortcuts, `.functions` `eks auth`   |
| `colima`                        | container runtime, configured by `colima/`          |
| `devcontainer`                  | `.functions` devcontainer wrapper                   |
| `docker`                        | `.functions` docker wrapper, `docker/config.json`   |
| `docker-compose`                | the Compose V2 plugin dir `docker/config.json` adds |
| `git`                           | `.aliases`, `.functions` `clean`, nvim gitsigns     |
| `go`                            | `GOROOT` in `.path`, and nvim's gopls               |
| `jq`                            | `claude/status-line.sh`                             |
| `kubernetes-cli`                | `.aliases` kubectl shortcuts, `.zprompt` context    |
| `libpq`                         | `psql` on `PATH` via `.path`                        |
| `mise`                          | node and ruby toolchains                            |
| `neovim`                        | `nvim/`                                             |
| `pnpm`                          | `PNPM_HOME` in `.path`                              |
| `ripgrep`                       | nvim telescope's `<leader>fg` grep                  |
| `tmux`                          | `.tmux.conf`                                        |
| `font-jetbrains-mono-nerd-font` | `.zprompt` icons, `kitty/kitty.conf` font           |
| `kitty`                         | `kitty/`                                            |
| `visual-studio-code`            | `.aliases` `code -r`                                |
