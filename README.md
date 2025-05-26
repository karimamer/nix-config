# Personalized macOS Configuration with Nix

This repository contains a personalized macOS configuration built with Nix, leveraging Nix Flakes, `nix-darwin`, and Home Manager. The primary goal is to create a reproducible, declarative, and customized development environment on macOS.

## Key Features

*   **Nix Flakes:** Utilizes Nix Flakes for precise dependency management, improved reproducibility, and easier sharing of the configuration.
*   **`nix-darwin`:** Leverages `nix-darwin` to manage macOS system-level settings and services declaratively.
*   **Home Manager:** Employs Home Manager for fine-grained, user-specific package management and dotfile organization.
*   **Homebrew Integration:** Seamlessly integrates with Homebrew via `nix-homebrew` to install macOS applications (casks) and other packages not readily available in Nixpkgs.
*   **Comprehensive Tool Configuration:** Includes curated configurations for essential development tools such as Zsh, tmux, WezTerm, Alacritty, Git, and more.
*   **Theming:** Styled with the popular Catppuccin theme for a consistent and aesthetically pleasing look across applications.
*   **Declarative Environment:** Defines the entire system and user environment in code, ensuring consistency and simplifying setup on new machines.

## Prerequisites

Before you can use this configuration, ensure you have the following installed and set up on your macOS system:

1.  **Nix:** This configuration relies entirely on the Nix package manager.
    *   Installation guide: [nixos.org/download.html](https://nixos.org/download.html)
2.  **Nix Flakes Enabled:** Flakes are a newer feature of Nix and need to be enabled.
    *   If you've just installed Nix, you might need to edit your Nix configuration file (usually `~/.config/nix/nix.conf` or `/etc/nix/nix.conf`) and add or uncomment:
        ```
        experimental-features = nix-command flakes
        ```
    *   Further information on Flakes: [NixOS Wiki on Flakes](https://nixos.wiki/wiki/Flakes)

It's recommended to familiarize yourself with the basics of Nix and Flakes for a smoother experience.

## Getting Started / Installation

1.  **Clone the Repository:**
    ```bash
    git clone https://github.com/your-username/your-repo-name.git # TODO: Replace with your actual repository URL
    cd your-repo-name # TODO: Replace with your actual repository directory
    ```

2.  **Personalize the Configuration (Important!):**
    This configuration is personalized for the user `karim` and the hostname `earlymoon`. You **must** change these to your own username and desired hostname.
    *   **Hostname:**
        *   In `flake.nix`: Change `earlymoon` in `darwinConfigurations.earlymoon` to your desired hostname. Remember this for the `switch` command.
        *   In `modules/darwin.nix`: Change `networking.computerName = "earlymoon";`
    *   **Username:**
        *   In `flake.nix`: Update the username `karim` in `home-manager.users.karim` and `users.users.karim`.
        *   In `flake.nix`: Update the home directory path in `users.users.karim.home = "/Users/karim";`
        *   In `modules/darwin.nix`: Change `nix.settings.trusted-users = [ "karim" ];` (or add your username if you prefer).
    *   Review other files in the `modules/` directory for any hardcoded paths or settings that might be specific to the original author.

3.  **Apply the Configuration:**
    Once personalized, use the command from the "Usage" section:
    ```bash
    nix run nix-darwin -- switch --flake .#your-new-hostname --show-trace
    ```

It's highly recommended to review the files, especially `flake.nix` and those in the `modules/` directory, to understand the setup before applying it.

## Usage

### Applying the Configuration

To apply the configuration to your system, run the following command:

```bash
nix run nix-darwin -- switch --flake .#earlymoon --show-trace
```
This command builds the system configuration defined in the Flake and activates it. The `earlymoon` part refers to the hostname specified in the `flake.nix` output. If you change the hostname, you'll need to update it here accordingly.

### Updating the Configuration

To update the Flake inputs (dependencies) and apply the new configuration:

```bash
nix flake update && nix run nix-darwin -- switch --flake .#earlymoon --show-trace
```
This first updates all the inputs (like `nixpkgs`, `home-manager`, etc.) to their latest versions as specified in `flake.lock` (or updates the lock file if no specific version is pinned), and then rebuilds and switches to the new configuration.

## Project Structure

The repository is organized as follows:

*   `flake.nix`: The heart of the configuration. It defines all inputs (dependencies like `nixpkgs`, `home-manager`, `nix-darwin`, etc.) and outputs the `darwinConfigurations` for your macOS system. Key areas for personalization (username, hostname) are found here.
*   `README.md`: This file – providing an overview and instructions for the project.
*   `modules/`: This directory contains the bulk of the configuration, broken down into logical units:
    *   `default.nix`: Imports most other modules within this directory for Home Manager.
    *   `darwin.nix`: Contains system-level macOS settings managed by `nix-darwin` (e.g., hostname, system defaults, Zsh as default shell).
    *   `pkgs.nix`: A list of packages to be installed via Nixpkgs through Home Manager.
    *   `casks.nix`: A list of macOS applications to be installed as Homebrew Casks via `nix-homebrew`.
    *   `*.nix` (e.g., `alacritty.nix`, `git.nix`, `tmux.nix`, `zsh.nix`): Individual Nix modules that configure specific applications or tools. These are typically imported into Home Manager via `modules/default.nix`.
    *   `configs/`: This subdirectory stores static configuration files that are sourced or linked by the Nix modules. For example:
        *   `fastfetch/config.jsonc`: Configuration for the fastfetch system information tool.
        *   `ghostty/config`: Configuration for the Ghostty terminal.
        *   `tmux.conf`: Configuration for Tmux.
        *   `wezterm/config.lua`: WezTerm terminal emulator configuration.
*   `nix.conf.example`: An example `nix.conf` file. If you don't have an existing Nix configuration at `~/.config/nix/nix.conf` or `/etc/nix/nix.conf`, you might copy this to one of those locations to enable necessary experimental features like Flakes. It's provided as a convenience.
*   `flake.lock`: Automatically generated by Nix, this file pins the exact versions of all inputs, ensuring reproducibility. It should be committed to version control.

Understanding this structure will help you navigate and customize the configuration to your needs.

## Customization

This configuration is designed to be a personal setup but can serve as a robust starting point for your own. Here’s how you can customize it:

1.  **Fork the Repository:** Start by forking this repository to your own GitHub account.

2.  **Personalize `flake.nix`:**
    *   As mentioned in "Getting Started," change the hostname (`earlymoon`) and username (`karim`) to your own.
    *   Adjust inputs in `flake.nix` if you want to use different versions of `nixpkgs`, `home-manager`, or other Flake inputs.

3.  **Manage Packages:**
    *   **Nix Packages:** Edit `modules/pkgs.nix` to add or remove packages installed via `home.packages` from Nixpkgs.
    *   **Homebrew Casks:** Modify `modules/casks.nix` to change the list of macOS applications installed via Homebrew.

4.  **Application Configurations:**
    *   Most application-specific settings are managed in their respective files within the `modules/` directory (e.g., `modules/zsh.nix`, `modules/tmux.nix`, `modules/wezterm.nix`).
    *   Static configuration files (e.g., `modules/configs/tmux.conf`) can be directly edited.
    *   Explore the `catppuccin.palette` options in files where Catppuccin theming is applied if you wish to tweak colors.

5.  **System Settings (`modules/darwin.nix`):**
    *   Adjust macOS system-level settings like key repeat rates, Dock behavior, screenshot location, etc., in `modules/darwin.nix`.

6.  **Add New Modules:**
    *   To configure a new application, you can create a new `your-app.nix` file in the `modules/` directory.
    *   Import this new module in `modules/default.nix` (for Home Manager configurations) or directly in `flake.nix` (for system-wide services or settings not managed by Home Manager).

7.  **Review and Experiment:**
    *   The best way to customize is to explore the existing files, understand how they work, and then carefully make your changes.
    *   After making changes, apply the configuration using the `switch` command to test them.

Remember that Nix allows for atomic updates and rollbacks (if your setup supports it, e.g., via bootloader integration, though `nix-darwin` handles this differently by creating generations), making experimentation relatively safe.
