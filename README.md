<div align="center">

#  .dotfiles

**My personal macOS environment as code.**
Terminal, editor, window manager, and shell, provisioned in one shot.

[![macOS](https://img.shields.io/badge/macOS-Apple_Silicon-000000?style=flat-square&logo=apple&logoColor=white)](https://www.apple.com/macos/)
[![Shell](https://img.shields.io/badge/shell-zsh-89e051?style=flat-square&logo=gnubash&logoColor=white)](https://www.zsh.org/)
[![Editor](https://img.shields.io/badge/editor-neovim-57A143?style=flat-square&logo=neovim&logoColor=white)](https://neovim.io/)
[![Provisioner](https://img.shields.io/badge/provisioner-ansible-EE0000?style=flat-square&logo=ansible&logoColor=white)](https://www.ansible.com/)
[![License](https://img.shields.io/badge/license-MIT-blue?style=flat-square)](#license)

</div>

---

## Quick start

```zsh
git clone --recurse-submodules https://github.com/alexcloudstar/.dotfiles ~/.dotfiles
cd ~/.dotfiles
./bootstrap.sh
```

That's it. Grab a coffee, first run takes about 15 minutes. `bootstrap.sh` asks for your sudo password once.

> [!IMPORTANT]
> `claude/` is a private submodule (`git@github.com:alexcloudstar/dotfiles-claude.git`). Without access to it the clone fails, and a clone without `--recurse-submodules` leaves `claude/` empty, so the `claude` role links nothing. If you fork this, point `.gitmodules` at your own repo or drop the `claude` role.

> [!NOTE]
> Apple Silicon only. Homebrew lives at `/opt/homebrew`, and `bootstrap.sh` exits if it detects Rosetta. Intel Macs need manual path changes in `zsh/.zshrc`. Running a shell under Rosetta is unsupported.

## What's inside

| Tool                                   | Purpose                                | Path                            |
| -------------------------------------- | -------------------------------------- | ------------------------------- |
| [**Neovim**](https://neovim.io)        | Editor with full Lua config + plugins  | `nvim/` → `~/.config/nvim`      |
| [**Zsh**](https://www.zsh.org)         | Shell with oh-my-zsh, fzf, eza         | `zsh/` → `~/.zshrc`, `~/.fzf.zsh`, `~/.p10k.zsh` |
| [**tmux**](https://github.com/tmux)    | Terminal multiplexer                   | `tmux/` → `~/.tmux.conf`        |
| [**yabai**](https://github.com/asmvik/yabai) | Tiling window manager       | `yabai/` → `~/.config/yabai`    |
| [**skhd**](https://github.com/asmvik/skhd)   | Hotkey daemon for yabai     | `skhd/` → `~/.config/skhd`      |
| **Git**                                | `.gitconfig` with aliases (`co`, `br`, `ci`, `st`, `lg`) | `gitconfig/` → `~/.gitconfig` |
| **Claude Code**                        | Private config (git submodule): `CLAUDE.md`, settings, guides, mods, skills, hooks | `claude/` → `~/.claude/`, `~/.agents/skills` |
| **Local scripts**                      | `tmux-sessionizer` (`^f` in zsh) and `cht.sh` (`prefix + i` in tmux) | `local/` → `~/.local/bin` |

## Provisioning

`bootstrap.sh` installs Xcode CLT, Homebrew, and Ansible, then runs `ansible/site.yml`, which applies six roles in order:

| Role | Tag | Does |
| --- | --- | --- |
| `homebrew` | `homebrew` | Installs Homebrew itself if missing, updates it |
| `packages` | `packages` | Taps and installs formulae/casks from `ansible/roles/packages/vars/main.yml`, and creates `/usr/local/cli-plugins` (needs sudo) so the Docker Desktop cask can link its plugins. Apps already in `/Applications` are left alone. To hand one to brew, trash it and run `brew install --cask <name>`. The `upkeep` tag (`brew upgrade` + `brew cleanup`) never runs by default |
| `shell` | `shell` | Installs oh-my-zsh + `zsh-autosuggestions` and `zsh-syntax-highlighting`, adds Homebrew zsh to `/etc/shells`, and sets it as the login shell (needs sudo) |
| `languages` | `languages` | Installs nvm + node LTS, bun, rustup (native aarch64 toolchain), global npm packages (`vercel`), and go tools |
| `symlinks` | `symlinks` | Symlinks configs into `~/.config`, `~/.local/bin`, and the home directory directly (no `stow`) |
| `claude` | `claude` | Links `CLAUDE.md`, `settings.json`, `guides`, `mods`, and `skills` into `~/.claude`, `skills` into `~/.agents/skills`, and each `hooks/*.sh` into `~/.claude/hooks`. A real directory already at a link destination is moved to `<name>.pre-dotfiles-bak` first |

Re-run any time to reconverge. `bootstrap.sh` passes `--ask-become-pass`. When you run `ansible-playbook` by hand, add it yourself and use a real terminal: the `packages` and `shell` roles need sudo.

<details>
<summary><strong>Run a subset</strong></summary>

```zsh
cd ansible
ansible-playbook site.yml --tags packages --ask-become-pass
ansible-playbook site.yml --tags symlinks
ansible-playbook site.yml --tags upkeep
```

Every role is a tag, so you can also skip one. `bootstrap.sh` forwards its arguments to `ansible-playbook`:

```zsh
./bootstrap.sh --skip-tags claude              # no access to the private submodule
./bootstrap.sh --skip-tags packages            # keep your own brew setup
./bootstrap.sh --skip-tags claude,packages
```

Skipping `packages` has side effects: the `shell` role expects Homebrew zsh and the `languages` role expects `go` from brew, so install those yourself or skip those roles too.

</details>

## Packages

The `packages` role installs everything below. The source of truth is `ansible/roles/packages/vars/main.yml`, so edit that file and re-run `--tags packages` rather than running `brew install` by hand.

<details>
<summary><strong>Taps</strong></summary>

`asmvik/formulae`, `anomalyco/tap`, `jithin-sabu/tap`, `stripe/stripe-cli`. Formulae from third-party taps are ignored by brew until trusted, so the role runs `brew trust` for `skhd` and `yabai`.

</details>

<details>
<summary><strong>Formulae</strong></summary>

| Group | Packages |
| --- | --- |
| Shell and terminal | `zsh`, `bash`, `tmux`, `fzf`, `eza`, `fd`, `ripgrep`, `tree`, `wget`, `powerlevel10k`, `reattach-to-user-namespace`, `stow` |
| Editors | `neovim`, `vim`, `tree-sitter-cli` |
| Window management | `yabai`, `skhd` |
| Languages and build | `go`, `python@3.14`, `llvm`, `cmake`, `cmake-docs` |
| Dev tools | `ansible`, `gh`, `git-filter-repo`, `colima`, `railway`, `stripe`, `opencode`, `mcp-publisher`, `geckodriver` |
| Media and AI | `ffmpeg`, `ffmpeg-full`, `whisper-cpp` |
| Other | `tor` |

</details>

<details>
<summary><strong>Casks</strong></summary>

| Group | Packages |
| --- | --- |
| Terminals | `iterm2`, `ghostty` |
| Editor | `visual-studio-code` |
| Browser | `google-chrome` |
| AI | `claude`, `chatgpt`, `codex`, `ollama-app` |
| Dev | `docker-desktop` |
| Utilities | `raycast`, `monitorcontrol`, `keycastr`, `obs`, `purge` |
| Fonts | `font-meslo-lg-nerd-font` |

</details>

## Folder structure

```
.dotfiles
├── ansible/       # provisioning playbook
├── claude/        # submodule: private Claude Code config
├── gitconfig/
├── local/         # scripts → ~/.local/bin
├── nvim/          # → ~/.config/nvim
├── skhd/          # → ~/.config/skhd
├── tmux/
├── yabai/         # → ~/.config/yabai
├── zsh/
├── bootstrap.sh
└── LICENSE
```

## Customize

Fork it. Swap themes, plugins, shortcuts. Add formulae, casks, and taps in `ansible/roles/packages/vars/main.yml`. Drop new scripts in `local/` and add them to the script list in the `symlinks` role.

## Contributing

Issues and PRs welcome.

## License

[MIT](LICENSE)
