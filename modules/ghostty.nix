{
  programs.ghostty = {
    enable = true;
  };

  home.file = {
    ".config/ghostty" = {
      source = ./configs/ghostty;
    };
  };
}
