{ pkgs, ... }:
let
  name = "karimamer";
  email = "karim.amer.sa@gmail.com";
in
{
  programs.git = {
    enable = true;
    ignores = [ ".DS_Store" ];

    settings = {
      user = {
        name = name;
        email = email;
      };

      init.defaultBranch = "main";
      pull.rebase = true;
      rebase.autoStash = true;
      credential.helper = if pkgs.stdenv.isDarwin then "osxkeychain" else "cache";

      core = {
        editor = "nvim";
        autocrlf = "input";
      };

      alias = {
        cl = "clone --depth=1 --filter=blob:none";
      };
    };
  };
}
