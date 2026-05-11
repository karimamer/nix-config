{ pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;

    # Extensions to install
    extensions = [
      "nix"
      "toml"
      "html"
      "make"
      "python"
      "rust"
      "racket"
      "common-lisp"
    ];

    # Extra packages available to Zed (e.g., formatters, LSPs)
    extraPackages = with pkgs; [
      nixd          # Nix language server
      nixfmt           # Nix formatter
      marksman      # Markdown language server
    ];

    # User settings (maps to ~/.config/zed/settings.json)
    userSettings = {
      # Editor appearance
      buffer_font_family = "JetBrainsMono Nerd Font";
      buffer_font_size = 14;
      buffer_line_height = "comfortable";
      ui_font_size = 16;

      # Active pane styling
      # Note: This only affects inactive panes in split view, NOT full window transparency
      # Zed does not currently support window-level transparency/opacity
      active_pane_modifiers = {
        inactive_opacity = 0.8;
      };

      # Cursor configuration
      cursor_blink = false;
      cursor_shape = "bar";
      current_line_highlight = "all";

      # Scrollbar settings
      scrollbar = {
        show = "auto";
        cursors = true;
        git_diff = true;
        search_results = true;
      };

      # Indentation and formatting
      tab_size = 2;
      hard_tabs = false;
      soft_wrap = "preferred_line_length";
      preferred_line_length = 100;
      indent_guides = {
        enabled = true;
        coloring = "indent_aware";
      };

      # File management
      autosave = "off";
      format_on_save = "on";
      ensure_final_newline_on_save = true;
      remove_trailing_whitespace_on_save = true;

      # Git integration
      git = {
        git_gutter = "tracked_files";
        inline_blame = {
          enabled = true;
          delay_ms = 600;
        };
      };

      # Terminal configuration
      terminal = {
        dock = "bottom";
        font_family = "JetBrainsMono Nerd Font";
        font_size = 14;
        working_directory = "current_project_directory";
        detect_venv = {
          on = {
            activate_script = "default";
          };
        };
      };

      # Tabs configuration
      tabs = {
        file_icons = true;
        git_status = true;
        close_position = "right";
        activate_on_close = "history";
      };

      # LSP settings
      enable_language_server = true;
      lsp = {
        nixd = {
          binary = {
            path_lookup = true;
          };
        };
      };

      # Code completion
      show_completions_on_input = true;
      show_completion_documentation = true;

      # Inlay hints
      inlay_hints = {
        enabled = true;
        show_type_hints = true;
        show_parameter_hints = true;
        show_other_hints = true;
        edit_debounce_ms = 700;
      };

      # Diagnostics
      diagnostics = {
        include_warnings = true;
      };

      # Toolbar and UI
      toolbar = {
        breadcrumbs = true;
        quick_actions = true;
      };

      # Vim mode (set to true if you prefer vim keybindings)
      vim_mode = false;

      # Telemetry
      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      # Project panel
      project_panel = {
        button = true;
        dock = "left";
        git_status = true;
      };

      # Collaboration
      collaboration_panel = {
        button = true;
        dock = "left";
      };

      # Outline panel
      outline_panel = {
        dock = "right";
      };

      # Assistant panel
      assistant = {
        enabled = true;
        button = true;
        dock = "right";
        default_model = {
          provider = "anthropic";
          model = "claude-3-5-sonnet-20241022";
        };
        version = "2";
      };

      # Per-language settings
      languages = {
        Nix = {
          tab_size = 2;
          hard_tabs = false;
          format_on_save = "on";
          formatter = {
            external = {
              command = "nixfmt";
              arguments = [];
            };
          };
        };
        JavaScript = {
          tab_size = 2;
          format_on_save = "on";
        };
        TypeScript = {
          tab_size = 2;
          format_on_save = "on";
        };
        Rust = {
          tab_size = 4;
          format_on_save = "on";
        };
        Python = {
          tab_size = 4;
          format_on_save = "on";
        };
        Markdown = {
          soft_wrap = "preferred_line_length";
          preferred_line_length = 80;
        };
      };

      # File scan exclusions (common directories to ignore)
      file_scan_exclusions = [
        "**/.git"
        "**/.svn"
        "**/.hg"
        "**/CVS"
        "**/.DS_Store"
        "**/Thumbs.db"
        "**/.classpath"
        "**/.settings"
        "**/node_modules"
        "**/.venv"
        "**/.direnv"
        "**/result"
      ];

      # UI behaviors
      confirm_quit = false;
      restore_on_startup = "last_workspace";
      auto_update = false;
      use_autoclose = true;
    };
  };
}
