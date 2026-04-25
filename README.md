# .dotfiles

My personal dotfiles for macOS. This repo contains my terminal tools, editor configuration, and various environment automations that I use across my machines.

## Included configs

- **Git**
  `.gitconfig` and helper scripts.

- **Neovim**
  Full setup inside `nvim/.config/nvim` including plugins and package configuration.

- **Zsh**
  Zsh config and utilities under `zsh/`, including Powerlevel10k (`.p10k.zsh`).

- **tmux**
  Custom `.tmux.conf` tweaks, window naming, and scripts.

- **yabai**
  Tiling window manager config under `yabai/`, symlinked to `~/.config/yabai`.

- **skhd**
  Hotkey daemon config under `skhd/`, symlinked to `~/.config/skhd`.

- **Claude Code**
  Private config managed as a git submodule (`claude/`). Symlinks `CLAUDE.md`, `settings.json`, `plugins/installed_plugins.json`, and `skills/` into `~/.claude/`.

- **Local scripts**
  Utilities in `local/.local/bin`.

## Installation

One-shot provisioning via Ansible:

```
git clone https://github.com/alexcloudstar/.dotfiles ~/.dotfiles
cd ~/.dotfiles
./bootstrap.sh
```

`bootstrap.sh` installs Xcode CLT, Homebrew, and Ansible, then runs
`ansible/site.yml` to install packages, set up oh-my-zsh, symlink
every config into place, and apply a few macOS defaults.

Apple Silicon is assumed (Homebrew at `/opt/homebrew`). Intel Macs will need
manual path adjustments in `zsh/.zshrc` and `zsh/.fzf.zsh`.

Re-run any time to reconverge. To run a subset:

```
cd ansible
ansible-playbook site.yml --tags packages
ansible-playbook site.yml --tags stow
```

## Folder structure

```
.dotfiles
├── ansible/    # provisioning playbook
├── claude/     # submodule — private Claude Code config
├── gitconfig
├── local       # scripts symlinked to ~/.local/bin
├── nvim        # symlinked to ~/.config/nvim
├── skhd        # symlinked to ~/.config/skhd
├── tmux
├── yabai       # symlinked to ~/.config/yabai
└── zsh
```

## Customization

Feel free to fork and tweak the configs:

- Change themes
- Add/remove plugins
- Modify shortcuts
- Add new scripts in `local/.local/bin`

## Contributing

Suggestions and improvements are welcome. Open an issue or PR.

## License

MIT License.
