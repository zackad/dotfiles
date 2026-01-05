{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "deck";
  home.homeDirectory = "/home/deck";

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
  home.activation.reloadSystemd = lib.mkForce "";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    # CLI Applications
    ansible
    busybox
    cotp
    dust
    git-machete
    imagemagick
    jq
    keepass # password manager to be used by JetBrains IDE
    nixfmt-rfc-style # Nix code formatter
    nodejs
    pass # Unix password manager
    php
    php84Packages.composer
    pigz # Parallel implementation of gzip
    pwgen
    sshpass # SSH password authetication support for ansible
    syncthing
    tailscale
    unzip
    wineWowPackages.base

    # Custom packages
    (callPackage ../pkgs/cbr2cbz/default.nix { })
    (callPackage ../pkgs/phpstorm-cli-wrapper/default.nix { })
    (callPackage ../pkgs/phpstorm-url-handler/default.nix { })
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

  programs.difftastic = {
    enable = true;
    git.enable = true;
    options = {
      display = "inline";
      background = "dark";
      color = "always";
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
      "--header"
      "--group-directories-first"
    ];
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.git = {
    enable = true;
    signing.key = "C2B91511AE73C825";
    settings = {
      user.name = "zackad";
      user.email = "zackad@zackad.dev";
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
      commit.verbose = true;
      core.editor = "vim";
      core.excludesFile = "~/.gitignore";
      diff.algorithm = "histogram";
      format.pretty = "format:%C(yellow)%ad %Cblue%h %Cgreen%<(7)%aN:%Cred%d %Creset%s";
      init.defaultbranch = "master";
      log.date = "format:%Y-%m-%d %H:%M:%S";
      merge.ff = "no";
      merge.conflictstyle = "zdiff3";
      tag.gpgSign = true;
      tag.sort = "version:refname";
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

  programs.rofi = {
    enable = true;
    plugins = [
      pkgs.rofi-calc
      pkgs.rofi-emoji
    ];
    extraConfig = {
      modi = "combi";
      combi-modi = "window,drun,emoji";
      show-icons = true;
    };
  };

  programs.vim = {
    enable = true;
    settings = {
      number = true;
      relativenumber = true;
    };
    extraConfig = ''
      set smartindent
      set showcmd
      au FileType gitcommit setlocal tw=72
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

        plugins=(git yarn)
      '';
    };
    envExtra = ''
      # make sure that nix profile is loaded
      if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
        . $HOME/.nix-profile/etc/profile.d/nix.sh
      fi

      # Symfony console autocomplete
      PATH="$PATH:$HOME/.config/composer/vendor/bin:$HOME/.local/bin"
      export PATH
    '';
    initContent = lib.mkMerge [
      (lib.mkBefore ''
        export GPG_TTY=$TTY

        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi

        fpath=($HOME/.nix-profile/share/zsh/site-functions $fpath)
      '')

      (''
        if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
          . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
        fi

        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

        eval "$(symfony-autocomplete)"
      '')
    ];
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
}
