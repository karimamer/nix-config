{ config, pkgs, lib, ... }:

{
  # Enable Catppuccin theme
  catppuccin = {
    enable = true;
    flavor = "mocha"; # Options: latte, frappe, macchiato, mocha
    accent = "mauve"; # Options: rosewater, flamingo, pink, mauve, red, maroon, peach, yellow, green, teal, sky, sapphire, blue, lavender
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    KEYTIMEOUT = 15;

    XDG_DATA_HOME = "${config.home.homeDirectory}/.local/share";
    XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
    XDG_STATE_HOME = "${config.home.homeDirectory}/.local/state";
    XDG_CACHE_HOME = "${config.home.homeDirectory}/.cache";

    ZDOTDIR = "${config.xdg.configHome}/zsh";

    GOPATH = "${config.xdg.dataHome}/go";

    RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
    CARGO_HOME = "${config.xdg.dataHome}/cargo";

    LESSHISTFILE = "${config.xdg.cacheHome}/less/history";
    NPM_CONFIG_USERCONFIG = "${config.xdg.configHome}/npm/npmrc";
    PYTHONSTARTUP = "${config.xdg.configHome}/python/pythonrc";
    SSH_HOME = "${config.xdg.configHome}/ssh/ssh_config";
    CST_LSP="${config.xdg.configHome}/.local/share/uv/tools/cst-lsp/bin";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    dotDir = "${config.xdg.configHome}/zsh";

    # Enable syntax highlighting with Catppuccin theme
    syntaxHighlighting = {
      enable = true;
    };

    history = {
      path = "${config.xdg.dataHome}/zsh/zsh_history";
      expireDuplicatesFirst = true;
      ignoreSpace = false;
      save = 15000;
      share = true;
      append = true;
      ignoreAllDups = true;
    };

    shellAliases = {
      vi = "vi -i NONE";
      v = "nvim";
      vim = "nvim";

      cat = "bat";
      cp = "cp -iv";
      bc = "bc -ql";

      wget = "wget --no-hsts";

      glg = "${pkgs.serie}/bin/serie";

      ".." = "cd ..";
      "..." = "cd ../../";
    };

    # Use initContent with lib.mkOrder for proper ordering
    initContent = lib.mkMerge [
      # Load before compinit (order 550, before compinit at 600)
      (lib.mkOrder 550 ''
        # Disable flow control (Ctrl-S/Ctrl-Q)
        stty -ixon
      '')
      # Load after compinit (default order)
      ''
        # Register custom zle widgets for history search
        zle -N up-line-or-beginning-search
        zle -N down-line-or-beginning-search

        # Vi-mode key bindings
        bindkey -v '^?' backward-delete-char
        bindkey -M viins 'jj' vi-cmd-mode
        bindkey -s '^y' '^uyazi\n'
        bindkey -s '^z' '^ufg\n'

        # Vi-mode cursor shape configuration
        # Changes cursor shape based on vi mode (beam for insert, block for command)
        function vi-mode-cursor-shape() {
          case $KEYMAP in
            vicmd) echo -ne '\e[1 q' ;;        # Block cursor for command mode
            viins | main) echo -ne '\e[5 q' ;; # Beam cursor for insert mode
          esac
        }

        function vi-mode-init-cursor() {
          zle -K viins                         # Start in insert mode
          echo -ne "\e[5 q"                    # Set beam cursor
        }

        # Register cursor shape functions
        zle -N zle-keymap-select vi-mode-cursor-shape
        zle -N zle-line-init vi-mode-init-cursor

        # Ensure beam cursor on startup and before each command
        echo -ne '\e[5 q'
        preexec() { echo -ne '\e[5 q'; }
      ''
    ];
  };
}
