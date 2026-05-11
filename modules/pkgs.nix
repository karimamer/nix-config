{ pkgs, ... }:

let
  fontPackages = import ./fonts.nix { inherit pkgs; };
in
{
  home.packages = with pkgs; [
    # General packages for development and system management
    neovim
    btop
    fastfetch
    openssh
    sqlite
    wget
    zip
    duckdb
    ollama
    claude-code
    codex

    # Text and terminal utilities
    hunspell
    jq
    ripgrep
    fd
    tree
    tmux
    just
    bat
    zoxide
    eza
    jnv
    aria2
    hyperfine
    tokei

    # Git utilities
    lazygit
    gh

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
