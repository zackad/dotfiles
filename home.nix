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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    # CLI Applications
    dust
    git-machete
    imagemagick
    jq
    nixfmt-rfc-style # Nix code formatter
    pass # Unix password manager
    php83
    pigz # Parallel implementation of gzip
    sshpass # SSH password authetication support for ansible
    unzip

    # Custom packages
    (callPackage ./cbr2cbz/default.nix { })
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
    icons = "auto";
    extraOptions = [
      "--header"
      "--group-directories-first"
    ];
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
      diff.algorithm = "histogram";
      format.pretty = "format:%C(yellow)%ad %Cblue%h %Cgreen%<(7)%aN:%Cred%d %Creset%s";
      init.defaultbranch = "master";
      log.date = "format:%Y-%m-%d %H:%M:%S";
      merge.ff = "no";
      merge.conflictstyle = "zdiff3";
      tag.gpgSign = true;
      tag.sort = "version:refname";
    };
    diff-so-fancy = {
      enable = true;
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
}
