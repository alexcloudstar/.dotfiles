<div align="center">

# .dotfiles

**My macOS environment as code.**
Terminal, editor, window manager, and shell, provisioned with one command.

[![macOS](https://img.shields.io/badge/macOS-Apple_Silicon-000000?style=for-the-badge&logo=apple&logoColor=white)](https://www.apple.com/macos/)
[![Zsh](https://img.shields.io/badge/shell-zsh-89e051?style=for-the-badge&logo=gnubash&logoColor=white)](https://www.zsh.org/)
[![Neovim](https://img.shields.io/badge/editor-neovim-57A143?style=for-the-badge&logo=neovim&logoColor=white)](https://neovim.io/)
[![Ansible](https://img.shields.io/badge/provisioner-ansible-EE0000?style=for-the-badge&logo=ansible&logoColor=white)](https://www.ansible.com/)
[![License](https://img.shields.io/badge/license-MIT-blue?style=for-the-badge)](#license)

[Quick start](#quick-start) ·
[What's inside](#whats-inside) ·
[Provisioning](#provisioning) ·
[Packages](#packages) ·
[Structure](#folder-structure) ·
[Customize](#customize)

</div>

---

## Quick start

```zsh
git clone --recurse-submodules https://github.com/alexcloudstar/.dotfiles ~/.dotfiles
cd ~/.dotfiles
./bootstrap.sh
```

`bootstrap.sh` asks for your sudo password once. The first run takes about 15 minutes.

> [!NOTE]
> **Apple Silicon only.** Homebrew lives at `/opt/homebrew`, and `bootstrap.sh` exits if it detects Rosetta. Intel Macs need manual path changes in `zsh/.zshrc`.

> [!IMPORTANT]
> **`claude/` is a private submodule** (`git@github.com:alexcloudstar/dotfiles-claude.git`). Without access, the clone fails. A clone without `--recurse-submodules` leaves `claude/` empty, so the `claude` role links nothing. If you fork this, point `.gitmodules` at your own repo or skip the role (see [Run a subset](#run-a-subset)).

## What's inside

| Tool | What it is | Lives in | Linked to |
| :--- | :--- | :--- | :--- |
| [**Neovim**](https://neovim.io) | Lua config, plugins via lazy.nvim | `nvim/` | `~/.config/nvim` |
| [**Zsh**](https://www.zsh.org) | oh-my-zsh, fzf, eza | `zsh/` | `~/.zshrc`, `~/.fzf.zsh`, `~/.p10k.zsh` |
| [**tmux**](https://github.com/tmux/tmux) | Terminal multiplexer | `tmux/` | `~/.tmux.conf` |
| [**yabai**](https://github.com/asmvik/yabai) | Tiling window manager | `yabai/` | `~/.config/yabai` |
| [**skhd**](https://github.com/asmvik/skhd) | Hotkey daemon for yabai | `skhd/` | `~/.config/skhd` |
| **Git** | Aliases: `co` `br` `ci` `st` `lg` | `gitconfig/` | `~/.gitconfig` |
| **Local scripts** | `tmux-sessionizer` (`^f` in zsh), `cht.sh` (`prefix + i` in tmux) | `local/` | `~/.local/bin` |
| **Claude Code** | Private submodule: `CLAUDE.md`, settings, guides, mods, skills, hooks | `claude/` | `~/.claude`, `~/.agents/skills` |

## Provisioning

`bootstrap.sh` installs Xcode CLT, Homebrew, and Ansible, then runs `ansible/site.yml`. Six roles run in this order:

| # | Role | What it does |
| :-: | :--- | :--- |
| 1 | `homebrew` | Installs Homebrew if missing, then updates it |
| 2 | `packages` | Installs taps, formulae, and casks from `ansible/roles/packages/vars/main.yml` |
| 3 | `shell` | Installs oh-my-zsh, `zsh-autosuggestions`, and `zsh-syntax-highlighting`. Sets Homebrew zsh as the login shell |
| 4 | `languages` | Installs nvm + node LTS, bun, rustup (native aarch64), global npm packages, and go tools |
| 5 | `symlinks` | Links configs into `~/.config`, `~/.local/bin`, and `~` directly (no `stow`) |
| 6 | `claude` | Links `claude/` into `~/.claude` and `~/.agents/skills` |

Every role is idempotent. Re-run any time to reconverge.

<details>
<summary><strong>Role details</strong></summary>

- **`packages`**
  - Creates `/usr/local/cli-plugins` (needs sudo) so the Docker Desktop cask can link its plugins.
  - Leaves apps already in `/Applications` alone. To hand one to brew, trash it and run `brew install --cask <name>`.
  - The `upkeep` tag (`brew upgrade` + `brew cleanup`) never runs by default.
- **`shell`** adds Homebrew zsh to `/etc/shells` and switches your login shell (needs sudo).
- **`claude`** links `CLAUDE.md`, `settings.json`, `guides`, `mods`, and `skills` into `~/.claude`, `skills` into `~/.agents/skills`, and each `hooks/*.sh` into `~/.claude/hooks`. A real directory already at a link destination is moved to `<name>.pre-dotfiles-bak` first.

</details>

### Run a subset

`bootstrap.sh` passes `--ask-become-pass` and forwards its arguments to `ansible-playbook`. When you call `ansible-playbook` by hand, add the flag yourself and use a real terminal: the `packages` and `shell` roles need sudo.

```zsh
cd ansible
ansible-playbook site.yml --tags packages --ask-become-pass
ansible-playbook site.yml --tags symlinks
ansible-playbook site.yml --tags upkeep
```

Every role is a tag, so you can skip one too:

```zsh
./bootstrap.sh --skip-tags claude              # no access to the private submodule
./bootstrap.sh --skip-tags packages            # keep your own brew setup
./bootstrap.sh --skip-tags claude,packages
```

> [!WARNING]
> Skipping `packages` has side effects. The `shell` role expects Homebrew zsh and the `languages` role expects `go` from brew. Install those yourself or skip those roles too.

## Packages

The source of truth is [`ansible/roles/packages/vars/main.yml`](ansible/roles/packages/vars/main.yml). Edit that file and re-run `--tags packages` instead of running `brew install` by hand.

**Formulae** are command-line tools and libraries. **Casks** are macOS apps and fonts.

<details>
<summary><strong>Taps</strong></summary>

<br>

`asmvik/formulae`, `anomalyco/tap`, `jithin-sabu/tap`, `stripe/stripe-cli`

Brew ignores formulae from third-party taps until they are trusted, so the role runs `brew trust` for `skhd` and `yabai`.

</details>

<details>
<summary><strong>Formulae</strong></summary>

<br>

| Group | Packages |
| :--- | :--- |
| Shell and terminal | `zsh` `bash` `tmux` `fzf` `eza` `fd` `ripgrep` `tree` `wget` `powerlevel10k` `reattach-to-user-namespace` `stow` |
| Editors | `neovim` `vim` `tree-sitter-cli` |
| Window management | `yabai` `skhd` |
| Languages and build | `go` `python@3.14` `llvm` `cmake` `cmake-docs` |
| Dev tools | `ansible` `gh` `git-filter-repo` `colima` `railway` `stripe` `opencode` `mcp-publisher` `geckodriver` |
| Media and AI | `ffmpeg` `ffmpeg-full` `whisper-cpp` |
| Other | `tor` |

</details>

<details>
<summary><strong>Casks</strong></summary>

<br>

| Group | Packages |
| :--- | :--- |
| Terminals | `iterm2` `ghostty` |
| Editor | `visual-studio-code` |
| Browser | `google-chrome` |
| AI | `claude` `chatgpt` `codex` `ollama-app` |
| Dev | `docker-desktop` |
| Utilities | `raycast` `monitorcontrol` `keycastr` `obs` `purge` |
| Fonts | `font-meslo-lg-nerd-font` |

</details>

## Folder structure

```
.dotfiles
├── ansible/
│   ├── roles/           # homebrew, packages, shell, languages, symlinks, claude
│   ├── ansible.cfg
│   ├── inventory
│   ├── requirements.yml
│   └── site.yml         # playbook entry point
├── claude/              # submodule: private Claude Code config
├── gitconfig/           # → ~/.gitconfig
├── local/               # scripts → ~/.local/bin
├── nvim/                # → ~/.config/nvim
├── skhd/                # → ~/.config/skhd
├── tmux/                # → ~/.tmux.conf
├── yabai/               # → ~/.config/yabai
├── zsh/                 # → ~/.zshrc, ~/.fzf.zsh, ~/.p10k.zsh
├── bootstrap.sh         # one-command setup
└── LICENSE
```

## Customize

- **Packages:** add formulae, casks, and taps in `ansible/roles/packages/vars/main.yml`.
- **Scripts:** drop them in `local/` and add them to the script list in the `symlinks` role.
- **Everything else:** swap themes, plugins, and shortcuts in each tool's folder.

## Contributing

Issues and PRs welcome.

## License

[MIT](LICENSE)
