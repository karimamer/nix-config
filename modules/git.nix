{ pkgs, ... }:
let
  name = "karimamer";
  email = "karim.amer.sa@gmail.com";
in
{
  programs.git = {
    enable = true;
    userName = name;
    userEmail = email;
    ignores = [ ".DS_Store" ];

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      rebase.autoStash = true;
      credential.helper = if pkgs.stdenv.isDarwin then "osxkeychain" else "cache";
      core = {
        editor = "nvim";
        autocrlf = "input";
      };
    };

    aliases = {
      cl = "clone --depth=1 --filter=blob:none";
    };
  };
}
