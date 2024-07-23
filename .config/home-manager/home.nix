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

  # Overlay for nixpkgs with custom/updated build
  nixpkgs.overlays = [
    (final: prev: {
      sayonara = prev.sayonara.overrideAttrs (old: {
        version = "1.10.0-stable1";
        src = prev.fetchFromGitLab {
          owner = "luciocarreras";
          repo = "sayonara-player";
          rev = "1.10.0-stable1";
          hash = "sha256-ZcuWe1dsLJS4/nLXSSKB7wzPU9COFyE4vPSwZIo0bgI=";
        };
      });
    })
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    # Desktop Applications
    anydesk
    barrier
    firefox
    gnumeric
    gthumb
    jetbrains.phpstorm
    lutris
    osu-lazer-bin
    plexamp
    qcachegrind
    sayonara
    telegram-desktop
    ungoogled-chromium

    # CLI Applications
    ansible
    ansible-lint
    btop # htop on steroid
    dust # better `du` alternative
    git-machete
    graphviz
    htop
    imagemagick
    isync
    jq
    keepass
    maestral # Dropbox client
    neofetch
    notmuch
    nixfmt-rfc-style # Nix code formatter
    pass # Unix password manager
    php83
    playerctl
    pigz # Parallel implementation of gzip
    sshpass # SSH password authetication support for ansible
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
    icons = true;
  };

  programs.git = {
    enable = true;
    userName = "zackad";
    userEmail = "zackad.dev@gmail.com";
    signing.key = "5E11F0B6C1EF4843";
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
    pinentryPackage = pkgs.pinentry-curses;
  };

  programs.neomutt = {
    enable = true;
    sidebar.enable = true;
  };

  programs.rofi = {
    enable = true;
    plugins = [ pkgs.rofi-calc ];
    extraConfig = {
      modi = "combi";
      combi-modi = "window,drun";
    };
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
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

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
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
    };
    envExtra = ''
      # Symfony console autocomplete
      PATH="$PATH:$HOME/.config/composer/vendor/bin"
      export PATH
    '';
    initExtraFirst = ''
      export GPG_TTY=$TTY

      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

      fpath=($HOME/.nix-profile/share/zsh/site-functions $fpath)
    '';
    initExtra = ''
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi

      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

      eval "$(symfony-autocomplete)"
    '';
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
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
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Os-Catalina-Night";
    };
    cursorTheme = {
      name = "macOS-BigSur";
    };
    font = {
      name = "San Francisco Display Regular";
      size = 9.0;
    };
  };

  # Wayland, X, etc. support for session vars
  # systemd.user.sessionVariables = config.home-manager.users.zackad.home.sessionVariables;

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
  };

  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    config = {
      fonts = {
        names = [ "San Francisco Display" ];
        style = "Regular";
        size = 9.0;
      };
      modifier = "Mod4";
      terminal = "xfce4-terminal";
      window.border = 1;
      gaps = {
        inner = 0;
        outer = 0;
      };
      keybindings =
        let
          modifier = config.xsession.windowManager.i3.config.modifier;
        in
        lib.mkOptionDefault {
          # rofi keybindings
          "Mod1+space" = "exec --no-startup-id rofi -show combi";
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
