{ self, inputs, ... }:
{
  # This is your standalone home-manager configuration, meant to be used on non-nixos machines
  # with the home-manager command
  flake.homeConfigurations = {
    "nixos" = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      modules = [
        self.homeModules.nixosModule
        {
          home.username = "zackad";
          home.homeDirectory = "/home/zackad";
        }
      ];
    };
  };

  flake.homeModules.nixosModule =
    {
      config,
      pkgs,
      lib,
      ...
    }:

    {
      home.stateVersion = "26.05";

      # Disable systemd reload
      home.activation.systemdReload = lib.mkForce "";

      # Let Home Manager install and manage itself.
      programs.home-manager.enable = true;
      home.packages = with pkgs; [
        # Desktop Applications
        calibre
        finamp
        firefox
        gnumeric
        gthumb
        lmstudio
        lutris
        picard
        plexamp
        # sayonara --broken build
        shutter
        telegram-desktop
        thunar
        wezterm
        winbox

        # CLI Applications
        ansible
        ansible-lint
        apple-cursor
        asciinema
        btop # htop on steroid
        # cbconvert # comicbook converter
        dust # better `du` alternative
        fastfetch
        fd # find replacement
        git-machete
        graphviz
        hyprshot
        htop
        imagemagick
        isync
        jq
        keepass
        linuxConsoleTools # fftest, gamepad rumble tester
        maestral # Dropbox client
        mintotp
        mpv
        notmuch
        nixfmt # Nix code formatter
        pass # Unix password manager
        php83
        playerctl
        pigz # Parallel implementation of gzip
        podman
        pwgen
        qpdf
        ripgrep
        sshpass # SSH password authetication support for ansible
        ueberzugpp # Image preview for yazi on xfce terminal
        unzip
        vim # Code editor
        wineWow64Packages.stable

        # Custom packages
        # (callPackage ../pkgs/cbr2cbz/default.nix { })
        self.packages.${pkgs.stdenv.hostPlatform.system}.media-control
        self.packages.${pkgs.stdenv.hostPlatform.system}.phpstorm-cli-wrapper-nixos
        self.packages.${pkgs.stdenv.hostPlatform.system}.phpstorm-url-handler
      ];

      programs.bat = {
        enable = true;
        config = {
          style = "plain";
        };
      };

      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

      programs.eza = {
        enable = true;
        icons = "auto";
        extraOptions = [
          "--group-directories-first"
          "--header"
        ];
      };

      programs.fzf = {
        enable = true;
        enableZshIntegration = true;
      };

      programs.gpg = {
        enable = true;
        settings = {
          keyid-format = "long";
          with-fingerprint = true;
        };
      };

      services.gpg-agent = {
        enable = true;
        # Workaround to fix integration with powerlevel10k instant-prompt
        enableZshIntegration = false;
        pinentry.package = pkgs.pinentry-curses;
      };

      programs.neomutt = {
        enable = true;
        sidebar.enable = true;
      };

      programs.rofi = {
        enable = true;
        plugins = [
          pkgs.rofi-calc
          pkgs.rofi-emoji
        ];
        extraConfig = {
          modi = "combi";
          combi-modi = "window,drun";
          show-icons = true;
        };
      };

      programs.tmux = {
        enable = true;
        terminal = "xterm-256color";
        mouse = true;
        extraConfig = ''
          # Fix Home/End button
          bind-key -n Home send Escape "OH"
          bind-key -n End send Escape "OF"

          # toggle status bar
          set-option -g status off
          bind-key -n M-s set-option -g status

          # switch panes using Alt-arrow without prefix
          bind-key -n M-Left select-pane -L
          bind-key -n M-Right select-pane -R
          bind-key -n M-Up select-pane -U
          bind-key -n M-Down select-pane -D

          # split pane vertical/horizontal
          bind-key -n M-e split-pane -h -c "#{pane_current_path}"
          bind-key -n M-o split-pane -v -c "#{pane_current_path}"
          unbind '"'
          unbind %

          # kill current pane
          bind-key -n M-w killp

          # swap pane
          bind-key -n S-Up swap-pane -s '{up-of}'
          bind-key -n S-Down swap-pane -s '{down-of}'
          bind-key -n S-Left swap-pane -s '{left-of}'
          bind-key -n S-Right swap-pane -s '{right-of}'
        '';
      };

      programs.yazi = {
        enable = true;
        enableZshIntegration = true;
        shellWrapperName = "yy";
      };

      programs.zed-editor = {
        enable = true;
        userSettings = {
          node = {
            path = lib.getExe pkgs.nodejs;
            npm_path = lib.getExe' pkgs.nodejs "npm";
          };
          theme = "Ayu Dark";
          telemetry = {
            metrics = false;
          };
          ui_font_size = 16;
          buffer_font_size = 14;
          toolbar = {
            breadcrumbs = false;
            quick_actions = false;
          };
          buffer_font_features = {
            calt = false;
          };
          ui_font_features = {
            calt = false;
          };
        };
      };

      programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
        options = [
          "--cmd"
          "cd"
        ];
      };

      dconf = {
        enable = true;
        settings = {
          "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
          };
        };
      };

      gtk = {
        enable = true;
        gtk4.theme = config.gtk.theme;
        theme = {
          name = "Nordic-darker";
          package = null;
        };
        iconTheme = {
          name = "Os-Catalina-Night";
        };
        cursorTheme = {
          name = "macOS";
        };
        font = {
          name = "San Francisco Display Regular";
          size = 11.0;
        };
      };

      # Wayland, X, etc. support for session vars
      # systemd.user.sessionVariables = config.home-manager.users.zackad.home.sessionVariables;

      qt = {
        enable = true;
        platformTheme.name = "gtk4";
        style.name = "Nordic-darker";
      };

    };
}
