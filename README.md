# Personalized macOS Configuration with Nix

A comprehensive, declarative macOS development environment built with Nix Flakes, nix-darwin, and Home Manager. This configuration provides a complete development setup with modern terminal tools, editors, and applications, all styled with the beautiful Catppuccin theme.

## 🌟 Features

### Core System Management
- **Nix Flakes**: Reproducible dependency management with pinned versions
- **nix-darwin**: Declarative macOS system configuration
- **Home Manager**: User-level package and dotfile management
- **Homebrew Integration**: Seamless installation of macOS applications via nix-homebrew
- **Catppuccin Theme**: Consistent theming across all applications

### Development Environment
- **Modern Shell**: Zsh with Starship prompt, vi-mode, and extensive aliases
- **Terminal Multiplexer**: Tmux with custom configuration and vim-style navigation
- **Terminal Emulators**: WezTerm and Alacritty with matching configurations
- **File Management**: Yazi file manager with Catppuccin theme
- **Version Control**: Git with sensible defaults and macOS keychain integration

### Development Tools & Languages
- **Editor**: Neovim ready for development
- **Rust Development**: Complete Rust toolchain with cargo-watch and cargo-generate
- **Python Development**: Modern Python tooling with uv and pyenv
- **Containerization**: Docker and Docker Compose
- **Database**: SQLite and DuckDB for data work

### Terminal Utilities
- **File Operations**: eza (modern ls), bat (syntax-highlighted cat)
- **Search & Navigation**: fzf (fuzzy finder), ripgrep, zoxide (smart cd)
- **System Information**: fastfetch with custom Nix-themed configuration
- **Text Processing**: jq, jnv (interactive JSON), hunspell

### Applications (via Homebrew)
- **Browsers**: Firefox, Zen Browser
- **Communication**: Discord, Zoom, Chatbox
- **Productivity**: Raycast, Anytype, Obsidian, Spotify
- **Development**: Zed editor, Docker Desktop
- **Security**: Enpass password manager
- **Utilities**: Syncthing file sync

## 📋 Prerequisites

1. **Nix Package Manager** with Flakes enabled
   ```bash
   # Install Nix (if not already installed)
   curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

   # Flakes should be enabled by default with the Determinate installer
   # If using another installer, ensure these settings are in ~/.config/nix/nix.conf:
   echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
   ```

2. **macOS** (tested on Apple Silicon)

## 🚀 Installation

1. **Clone this repository**:
   ```bash
   git clone <your-repo-url>
   cd <repo-directory>
   ```

2. **Personalize the configuration**:

   You **must** update the following before installation:

   **In `flake.nix`**:
   - Change `bloodmoon` to your desired hostname in `darwinConfigurations.bloodmoon`
   - Update `karim` to your username in `home-manager.users.karim` and `users.users.karim`
   - Update the home directory path: `users.users.karim.home = "/Users/karim"`

   **In `modules/darwin.nix`**:
   - Change `networking.computerName = "bloodmoon"`
   - Update `nix.settings.trusted-users = [ "karim" ]`

   **In `modules/git.nix`**:
   - Update the `name` and `email` variables with your Git credentials

3. **Apply the configuration**:
   ```bash
   sudo nix run nix-darwin -- switch --flake .#your-hostname --show-trace
   ```

4. **Restart your terminal** to load the new shell configuration.

## 🔄 Usage

### Applying Configuration Changes
```bash
# Apply current configuration
sudo nix run nix-darwin -- switch --flake .#your-hostname --show-trace

# Update all inputs and apply
nix flake update && sudo nix run nix-darwin -- switch --flake .#bloodmoon --show-trace
```

### Key Bindings & Shortcuts

**Zsh (Vi Mode)**:
- `jj` - Exit insert mode
- `Ctrl+y` - Open Yazi file manager
- `Ctrl+z` - Bring background job to foreground

**Tmux** (prefix: `Ctrl+a`):
- `Ctrl+a |` - Split window horizontally
- `Ctrl+a -` - Split window vertically
- `Ctrl+a h/j/k/l` - Navigate panes
- `Ctrl+a H/J/K/L` - Resize panes (repeatable)
- `Ctrl+a m` - Maximize/restore pane
- `Ctrl+a r` - Reload configuration
- `Ctrl+a b` - Toggle status bar
- `Ctrl+a s` - Enter scroll/copy mode
- `Alt+p` - Toggle scratchpad popup
- `Alt+Tab` - Switch to last window
- `Alt+1-9` - Switch to window 1-9

**WezTerm**:
- Automatically centers and sizes window on startup
- Integrated with system theme
- Blinking underline cursor
- Custom tab formatting with process icons

## 📁 Project Structure

```
nix/
├── flake.nix              # Main flake configuration
├── flake.lock            # Locked dependency versions
├── modules/              # Configuration modules
│   ├── default.nix       # Home Manager module imports
│   ├── darwin.nix        # macOS system settings
│   ├── pkgs.nix          # Nixpkgs package list
│   ├── casks.nix         # Homebrew cask applications
│   ├── alacritty.nix     # Alacritty terminal config
│   ├── bat.nix           # Bat syntax highlighter
│   ├── eza.nix           # Modern ls replacement
│   ├── fastfetch.nix     # System info tool
│   ├── fonts.nix         # Font packages
│   ├── fzf.nix           # Fuzzy finder
│   ├── git.nix           # Git configuration
│   ├── nix.nix           # Nix settings
│   ├── ssh.nix           # SSH configuration
│   ├── starship.nix      # Shell prompt
│   ├── tmux.nix          # Terminal multiplexer
│   ├── wezterm.nix       # WezTerm terminal
│   ├── yazi.nix          # File manager
│   ├── zoxide.nix        # Smart cd command
│   ├── zsh.nix           # Zsh shell configuration
│   └── configs/          # Static configuration files
│       ├── fastfetch/    # Fastfetch themes
│       ├── ghostty/      # Ghostty terminal config
│       ├── tmux.conf     # Tmux configuration
│       └── wezterm/      # WezTerm Lua configs
└── README.md             # This file
```

## 🎨 Customization

### Adding Packages
- **Nix packages**: Add to `modules/pkgs.nix` in the `home.packages` list
- **Homebrew casks**: Add to `modules/casks.nix` list
- **System packages**: Add to the nix-darwin configuration in `flake.nix`

### Theming
All applications use the Catppuccin Mocha theme. To change:
- Most modules have `catppuccin.flavor = "mocha"` settings
- Available flavors: `latte`, `frappe`, `macchiato`, `mocha`
- Custom colors can be overridden in individual module files

### Application Configuration
Each tool has its own module file where you can:
- Enable/disable features
- Modify key bindings
- Adjust appearance settings
- Add custom configurations

### System Settings
Modify `modules/darwin.nix` to change:
- macOS system preferences
- Dock behavior
- Keyboard settings
- Default applications

## 🛠 Troubleshooting

### Common Issues

**Permission errors during switch**:
```bash
# Ensure you're using sudo for the switch command
sudo nix run nix-darwin -- switch --flake .#your-hostname --show-trace
```

**Homebrew applications not installing**:
```bash
# Check Homebrew is properly integrated
brew doctor
# Manually run Homebrew if needed
brew bundle --file=/opt/homebrew/Library/Taps/nix-community/homebrew-bundle/Brewfile
```

**Shell not changing to zsh**:
```bash
# Manually change default shell
chsh -s /run/current-system/sw/bin/zsh
```

**Fonts not appearing**:
```bash
# Rebuild font cache
fc-cache -f -v
```

### Rollback
If something breaks, you can rollback to the previous generation:
```bash
sudo nix-env --rollback --profile /nix/var/nix/profiles/system
```

## 🤝 Contributing

This is a personal configuration, but feel free to:
1. Fork this repository
2. Adapt it to your needs
3. Share improvements via issues or pull requests
4. Use it as inspiration for your own setup

## 📚 Resources

- [Nix Manual](https://nixos.org/manual/nix/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [nix-darwin Manual](https://github.com/LnL7/nix-darwin)
- [Catppuccin Theme](https://catppuccin.com/)
- [NixOS Wiki](https://nixos.wiki/)
