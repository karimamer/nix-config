{ pkgs, lib, ... }:

{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
    casks = import ./casks.nix { inherit pkgs lib; };
  };

  nix-homebrew = {
    enable = true;
    user = "karim";
    mutableTaps = true;
    autoMigrate = true;
    enableRosetta = true;
  };
}
