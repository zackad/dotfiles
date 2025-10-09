{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "zackad";
  home.homeDirectory = "/home/zackad";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

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
    sayonara
    shutter
    telegram-desktop
    wezterm

    # CLI Applications
    ansible
    ansible-lint
    apple-cursor
    asciinema
    btop # htop on steroid
    # cbconvert # comicbook converter
    dust # better `du` alternative
    git-machete
    graphviz
    htop
    imagemagick
    isync
    jq
    keepass
    linuxConsoleTools # fftest, gamepad rumble tester
    maestral # Dropbox client
    mpv
    neofetch
    notmuch
    nixfmt-rfc-style # Nix code formatter
    pass # Unix password manager
    php83
    playerctl
    pigz # Parallel implementation of gzip
    sshpass # SSH password authetication support for ansible
    steam-run
    ueberzugpp # Image preview for yazi on xfce terminal
    unzip
    vim # Code editor
    wineWowPackages.stable

    # Custom packages
    (callPackage ./cbr2cbz/default.nix { })
    (callPackage ./phpstorm-cli-wrapper/default.nix { })
    (callPackage ./phpstorm-url-handler/default.nix { })
  ];

  home.sessionVariables = {
    EDITOR = "vim";
    PAGER = "less -FRX";
    RSYNC_OLD_ARGS = "1"; # workaround for escape introduced by rsync v3.2.4
  };

  home.shellAliases = {
    console = "bin/console";
    gzip = "pigz";
    cat = "bat";
  };

  programs.aria2 = {
    enable = true;
    settings = {
      split = 16;
      min-split-size = "2M";
      max-concurrent-downloads = 16;
      max-concurrent-per-server = 16;
    };
  };

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

  programs.git = {
    enable = true;
    userName = "zackad";
    userEmail = "zackad@zackad.dev";
    signing.key = "C2B91511AE73C825";
    aliases = {
      cm = "checkout master";
      ma = "machete add";
      me = "machete edit";
      md = "machete go down";
      ms = "machete status";
      mu = "machete update";
      l = "log --date=short";
      q = "log --all --decorate --oneline --graph";
    };
    extraConfig = {
      commit.verbose = true;
      core.excludesFile = "~/.gitignore";
      core.pager = "less -FX";
      diff.algorithm = "histogram";
      format.pretty = "format:%C(yellow)%ad %Cblue%h %Cgreen%<(7)%aN:%Cred%d %Creset%s";
      init.defaultbranch = "master";
      log.date = "format:%Y-%m-%d %H:%M:%S";
      merge.ff = "no";
      merge.conflictstyle = "zdiff3";
      tag.gpgSign = true;
      tag.sort = "version:refname";
    };
    difftastic = {
      enable = true;
      display = "inline";
      background = "dark";
      color = "always";
    };
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
  };

  programs.yt-dlp = {
    enable = true;
    settings = {
      restrict-filenames = true;
      downloader = "aria2c";
      downloader-args = "aria2c:'-j 16 -s 16 -x 16 -k 20M'";
      format = "bestvideo[height<=1080]+bestaudio/best[height<=1080]";
    };
    extraConfig = "";
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

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    oh-my-zsh = {
      enable = true;
      extraConfig = ''
        # Uncomment the following line to use case-sensitive completion.
        CASE_SENSITIVE="true"
      '';
      plugins = [
        "git"
        "yarn"
      ];
    };
    envExtra = ''
      # Symfony console autocomplete
      PATH="$PATH:$HOME/.config/composer/vendor/bin"
      export PATH

      export GPG_TTY=$(tty)
    '';

    initContent = lib.mkMerge [
      # Enable powerlevel10k instant prompt
      (lib.mkBefore ''
        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi
      '')

      (''
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
        eval "$(symfony-autocomplete)"
        unalias yy
      '')
    ];
    history = {
      findNoDups = true;
      ignoreAllDups = true;
      ignoreDups = true;
      saveNoDups = true;
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
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
    theme = {
      name = "Nordic-darker";
      package = pkgs.nordic;
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
    platformTheme.name = "gtk";
    style.name = "Nordic-darker";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ./hyprland.conf;
  };

  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3;
    config = {
      fonts = {
        names = [ "San Francisco Display" ];
        style = "Regular";
        size = 9.0;
      };
      modifier = "Mod4";
      terminal = "wezterm";
      window.border = 1;
      gaps = {
        smartBorders = "on";
        smartGaps = true;
        inner = 0;
        outer = 0;
      };
      keybindings =
        let
          modifier = config.xsession.windowManager.i3.config.modifier;
        in
        lib.mkOptionDefault {
          # sensible terminal shortcut
          "Ctrl+Mod1+t" = "exec i3-sensible-terminal";

          "${modifier}+s" = "bar mode toggle";

          # rofi keybindings
          "Mod1+space" = "exec --no-startup-id rofi -show combi";
          "${modifier}+space" = "exec --no-startup-id rofi -modi emoji -show emoji";
          "XF86Calculator" = "exec --no-startup-id rofi -show calc";

          # screenshot utility
          "Print" = "exec --no-startup-id xfce4-screenshooter -f";
          "${modifier}+u" = "exec --no-startup-id xfce4-session-logout";

          # move workspace to different monitor
          "${modifier}+Ctrl+greater" = "move workspace to output right";
          "${modifier}+Ctrl+less" = "move workspace to output left";

          # Pulse Audio Control
          "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume 1 +5%";
          "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume 1 -5%";
          "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute 1 toggle";

          # Media player controls
          "XF86AudioStop" = "exec playerctl stop";
          "XF86AudioPlay" = "exec playerctl play-pause";
          "XF86AudioNext" = "exec playerctl next";
          "XF86AudioPrev" = "exec playerctl previous";
        };
      startup = [
        # No need for monitor layout workaround
        # { command = "~/.screenlayout/fixed-monitor.sh"; }
        { command = "${pkgs.feh}/bin/feh --bg-scale ~/Pictures/ayano.png"; }
      ];
      assigns = {
        "1" = [
          { class = "jetbrains-phpstorm"; }
          { class = "VSCodium"; }
          { class = "dev.zed.Zed"; }
        ];
        "3" = [
          { class = "fmd.exe"; }
          { class = "LM Studio"; }
        ];
        "7" = [ { class = "firefox-dev-profile"; } ];
        "8" = [ { class = "TelegramDesktop"; } ];
        "9" = [ { class = "Lutris"; } ];
        "10" = [ { class = "steam"; } ];
      };
      workspaceAutoBackAndForth = true;
      workspaceOutputAssign =
        let
          primary = "DP-2";
          secondary = "DP-1";
        in
        [
          {
            workspace = "1";
            output = primary;
          }
          {
            workspace = "2";
            output = primary;
          }
          {
            workspace = "3";
            output = primary;
          }
          {
            workspace = "4";
            output = primary;
          }
          {
            workspace = "5";
            output = primary;
          }
          {
            workspace = "6";
            output = secondary;
          }
          {
            workspace = "7";
            output = secondary;
          }
          {
            workspace = "8";
            output = secondary;
          }
          {
            workspace = "9";
            output = secondary;
          }
          {
            workspace = "10";
            output = secondary;
          }
        ];
      bars = [
        {
          extraConfig = "output primary";
          fonts = {
            names = [ "IBM Plex Mono" ];
            style = "Regular";
            size = 10.0;
          };
          position = "top";
          statusCommand = "${pkgs.i3status}/bin/i3status";
          trayOutput = "primary";
        }
        {
          extraConfig = "output nonprimary";
          fonts = {
            names = [ "IBM Plex Mono" ];
            style = "Regular";
            size = 8.0;
          };
          position = "top";
          statusCommand = "${pkgs.i3status}/bin/i3status";
        }
      ];
    };
  };
}
