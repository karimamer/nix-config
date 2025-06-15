{ pkgs, config, ... }:

{
  system.stateVersion = 5;

  networking.computerName = "bloodmoon";
  system.primaryUser = "karim";
  nix.settings.trusted-users = [ "karim" ];

  programs.zsh.enable = true;

  system.defaults = {
    dock = {
        tilesize = 50;
        orientation = "bottom";
        autohide = false;
    };


    CustomUserPreferences."com.apple.screencapture" = {
      location = "~/Documents/screenshots";
      type = "png";
    };

    NSGlobalDomain = {
      _HIHideMenuBar = true;
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
    };

    SoftwareUpdate = {
      AutomaticallyInstallMacOSUpdates = false;
    };

    trackpad = {
      Clicking = true;
    };

    loginwindow.LoginwindowText = "Have you been pwned?";
  };
}
