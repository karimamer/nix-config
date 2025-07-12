{ ... }:

{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  catppuccin.yazi = {
    enable = true;
    flavor = "mocha";
  };

}
