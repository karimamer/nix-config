{ config, lib, pkgs, ... }:
let
  user = config.home.username;
in
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    includes = lib.mkMerge [
      (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin [
        "/Users/${user}/.ssh/config_external"
      ])
    ];

    matchBlocks = {
      # Default settings for all hosts
      "*" = {
        # Common defaults you want to keep
        serverAliveInterval = 60;
        serverAliveCountMax = 3;
        compression = true;
      };

      "github.com" = {
        identitiesOnly = true;
        identityFile = lib.mkMerge [
          (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin [
            "/Users/${user}/.ssh/id_ed25519"
          ])
        ];
      };
    };
  };
}
