{ pkgs, ... }:

let
  fontPackages = import ./fonts.nix { inherit pkgs; };
in
{
  home.packages = with pkgs; [
    # General packages for development and system management
    neovim
    alacritty
    btop
    fastfetch
    openssh
    sqlite
    wget
    zip
    duckdb
    ollama
    claude-code
    # Cloud-related tools and SDKs
    docker
    docker-compose

    # Text and terminal utilities
    hunspell
    jq
    ripgrep
    tree
    tmux
    just
    bat
    zoxide
    eza
    jnv
    aria2

    # Python packages
    pyenv
    uv

    # Rust
    rustup
    cargo-watch
    cargo-generate

    # macOS specific
    dockutil
    # lisp
    # racket-minimal  # Temporarily disabled due to build failure
    chez

    mkalias
  ] ++ fontPackages;
}
