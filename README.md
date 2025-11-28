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

- **SKHD**
  Hotkeys for window management and command shortcuts.

- **Yabai**
  Tiling window manager config.

- **Zsh**
  Zsh config and utilities under `zsh/`.

- **tmux**
  Custom `.tmux.conf` tweaks, window naming, and scripts.

- **Local scripts**
  Utilities in `local/.local/bin`.

## Installation

Clone the repo into your home directory:

```
git clone https://github.com/alexcloudstar/.dotfiles ~/.dotfiles
```

Then run the setup script (if available) or manually symlink the configs:

```
cd ~/.dotfiles
# Example:
ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
ln -s ~/.dotfiles/nvim/.config/nvim ~/.config/nvim
```

If you are using macOS, make sure you have these tools installed:

- Homebrew
- Git
- Neovim or your preferred terminal/editor

## Folder structure

```
.dotfiles
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
