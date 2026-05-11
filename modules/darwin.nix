{ pkgs, config, ... }:

{
  system.stateVersion = 5;

  networking.computerName = "bloodmoon";
  system.primaryUser = "karim";
  nix.settings = {
    trusted-users = [ "karim" ];
    experimental-features = [ "nix-command" "flakes" ];
  };

  programs.zsh.enable = true;

  system.defaults = {
    dock = {
        tilesize = 50;
        orientation = "bottom";
        autohide = false;
    };

    finder = {
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      FXEnableExtensionChangeWarning = false;
      _FXShowPosixPathInTitle = true;
    };

    CustomUserPreferences."com.apple.screencapture" = {
      location = "~/Documents/screenshots";
      type = "png";
    };

    NSGlobalDomain = {
      _HIHideMenuBar = true;
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      AppleShowAllExtensions = true;
      ApplePressAndHoldEnabled = false;
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
