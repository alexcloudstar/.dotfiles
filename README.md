# .dotfiles

My personal dotfiles for macOS Linux setups. This repo contains my terminal tools, editor configuration, and various environment automations that I use across my machines.

## Included configs

- **Alacritty**
  Custom Alacritty configuration and themes.

- **Ghostty**
  Tweaked Ghostty configuration for performance and visuals.

- **Git**
  `.gitconfig` and helper scripts.

- **Neovim**
  Full setup inside `nvim/.config/nvim` including plugins and package configuration.

- **Zsh**
  Zsh config and utilities under `zsh/`.

- **tmux**
  Custom `.tmux.conf` tweaks, window naming, and scripts.

- **Local scripts**
  Utilities in `local/.local/bin`.

## Installation (macOS)

One-shot provisioning via Ansible:

```
git clone https://github.com/alexcloudstar/.dotfiles ~/.dotfiles
cd ~/.dotfiles
./bootstrap.sh
```

`bootstrap.sh` installs Xcode CLT, Homebrew, and Ansible, then runs
`ansible/site.yml` to install packages, set up oh-my-zsh, stow every
config package, and apply a few macOS defaults.

Re-run any time to reconverge. To run a subset:

```
cd ansible
ansible-playbook site.yml --tags packages
ansible-playbook site.yml --tags stow
```

## Folder structure

```
.dotfiles
├── ansible/            # provisioning playbook
├── alacritty
├── ghostty
├── gitconfig
├── local/.local/bin
├── nvim/.config/nvim
├── skhd/.config/skhd
├── tmux
├── yabai/.config/yabai
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
