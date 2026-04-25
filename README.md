<div align="center">

#  .dotfiles

**My personal macOS environment as code.**
Terminal, editor, window manager, and shell — provisioned in one shot.

[![macOS](https://img.shields.io/badge/macOS-Apple_Silicon-000000?style=flat-square&logo=apple&logoColor=white)](https://www.apple.com/macos/)
[![Shell](https://img.shields.io/badge/shell-zsh-89e051?style=flat-square&logo=gnubash&logoColor=white)](https://www.zsh.org/)
[![Editor](https://img.shields.io/badge/editor-neovim-57A143?style=flat-square&logo=neovim&logoColor=white)](https://neovim.io/)
[![Provisioner](https://img.shields.io/badge/provisioner-ansible-EE0000?style=flat-square&logo=ansible&logoColor=white)](https://www.ansible.com/)
[![License](https://img.shields.io/badge/license-MIT-blue?style=flat-square)](#license)

</div>

---

## Quick start

```zsh
git clone https://github.com/alexcloudstar/.dotfiles ~/.dotfiles
cd ~/.dotfiles
./bootstrap.sh
```

That's it. Grab a coffee — first run takes ~15 minutes.

> [!NOTE]
> Apple Silicon assumed (Homebrew at `/opt/homebrew`). Intel Macs need manual path tweaks in `zsh/.zshrc` and `zsh/.fzf.zsh`.

## What's inside

| Tool                                   | Purpose                                | Path                            |
| -------------------------------------- | -------------------------------------- | ------------------------------- |
| [**Neovim**](https://neovim.io)        | Editor — full Lua config + plugins     | `nvim/` → `~/.config/nvim`      |
| [**Zsh**](https://www.zsh.org)         | Shell — oh-my-zsh + Powerlevel10k      | `zsh/`                          |
| [**tmux**](https://github.com/tmux)    | Terminal multiplexer                   | `tmux/`                         |
| [**yabai**](https://github.com/koekeishiya/yabai) | Tiling window manager       | `yabai/` → `~/.config/yabai`    |
| [**skhd**](https://github.com/koekeishiya/skhd)   | Hotkey daemon for yabai     | `skhd/` → `~/.config/skhd`      |
| **Git**                                | `.gitconfig` + helper scripts          | `gitconfig`                     |
| **Claude Code**                        | Private config (git submodule)         | `claude/` → `~/.claude/`        |
| **Local scripts**                      | Personal utilities                     | `local/` → `~/.local/bin`       |

## Provisioning

`bootstrap.sh` installs Xcode CLT, Homebrew, and Ansible, then runs `ansible/site.yml` to:

- Install Brewfile packages
- Set up oh-my-zsh
- Symlink every config into place via `stow`
- Apply a handful of macOS defaults

Re-run any time to reconverge.

<details>
<summary><strong>Run a subset</strong></summary>

```zsh
cd ansible
ansible-playbook site.yml --tags packages
ansible-playbook site.yml --tags stow
```

</details>

## Folder structure

```
.dotfiles
├── ansible/    # provisioning playbook
├── claude/     # submodule: private Claude Code config
├── gitconfig
├── local/      # scripts → ~/.local/bin
├── nvim/       # → ~/.config/nvim
├── skhd/       # → ~/.config/skhd
├── tmux/
├── yabai/      # → ~/.config/yabai
└── zsh/
```

## Customize

Fork it. Swap themes, plugins, shortcuts. Drop new scripts in `local/.local/bin`.

## Contributing

Issues and PRs welcome.

## License

[MIT](LICENSE)
