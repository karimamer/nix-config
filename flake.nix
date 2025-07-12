{
  description = "karim's macos config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { nixpkgs, home-manager, darwin, catppuccin, nix-homebrew, homebrew-bundle, homebrew-core, homebrew-cask, ... }: {
    darwinConfigurations = {
      bloodmoon = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./modules/darwin.nix
          home-manager.darwinModules.home-manager
          nix-homebrew.darwinModules.nix-homebrew
          ({ config, pkgs, lib, ... }: {
            # System-level Homebrew configuration
            homebrew = {
              enable = true;
              onActivation = {
                autoUpdate = true;
                cleanup = "uninstall";
                upgrade = true;
              };
              casks = import ./modules/casks.nix { inherit pkgs lib; };
            };
            nixpkgs.config.allowUnfree = true;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.karim = { config, pkgs, ... }: {
              imports = [
                ./modules
                catppuccin.homeModules.catppuccin
              ];
            };

            nix-homebrew = {
              enable = true;
              user = "karim";
              taps = {
                "homebrew/homebrew-core" = homebrew-core;
                "homebrew/homebrew-cask" = homebrew-cask;
                "homebrew/homebrew-bundle" = homebrew-bundle;
              };
              mutableTaps = true;
              autoMigrate = true;
              enableRosetta = true;
            };

            users.users.karim = {
              name = "karim";
              home = "/Users/karim";
            };
          })
        ];
      };
    };
  };
}
