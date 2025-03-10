{ config, pkgs, ... }:
let
  modules = [
    ./bat.nix
    ./git.nix
    ./ssh.nix
    ./pkgs.nix
    ./yazi.nix
    ./zoxide.nix
    ./fastfetch.nix
    ./fzf.nix
    ./nix.nix
    ./eza.nix
    ./zsh.nix
    ./starship.nix
    ./wezterm.nix
    ./alacritty.nix
  ];
in
{
  imports = modules;
  programs.zsh.enable = true;
  xdg.dataHome = "${config.home.homeDirectory}/.local/share";
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";

}
