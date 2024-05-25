{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "zackad";
  home.homeDirectory = "/home/zackad";

  # Overlay for nixpkgs with custom/updated build
  nixpkgs.overlays = [
    (final: prev: {
      sayonara = prev.sayonara.overrideAttrs (old: {
        version = "1.9.0-stable1";
        src = prev.fetchFromGitLab {
          owner = "luciocarreras";
          repo = "sayonara-player";
          rev = "1.9.0-stable1";
          sha256 = "SQMJWxwJoSWopuwC1o9T/SOQRtnBV3PzuMVpBCEdgw4=";
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
    brave
    firefox
    gnumeric
    jetbrains.phpstorm
    qcachegrind
    lutris
    osu-lazer-bin
    plexamp
    polybar
    sayonara
    telegram-desktop

    # CLI Applications
    ansible
    ansible-lint
    aria # CLI download manager
    btop # htop on steroid
    git-machete
    graphviz
    htop
    imagemagick
    jq
    keepass
    lsd
    maestral # Dropbox client
    neofetch
    nil # Nix Language Server
    nixfmt-classic # Nix code formatter
    pass # Unix password manager
    php83
    pigz # Parallel implementation of gzip
    sshpass # SSH password authetication support for ansible
    tmux # Terminal multiplexer
    unzip
    vim # Code editor
    wineWowPackages.stable
    zoxide

    # Custom packages
    (callPackage ./cbr2cbz/default.nix { })
    (callPackage ./phpstorm-cli-wrapper/default.nix { })
    (callPackage ./phpstorm-url-handler/default.nix { })
  ];

  programs.bat = {
    enable = true;
    config = { style = "plain"; };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
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
      format.pretty =
        "format:%C(yellow)%ad %Cblue%h %Cgreen%<(7)%aN:%Cred%d %Creset%s";
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

  services.gpg-agent.enable = true;
  services.gpg-agent.pinentryPackage = pkgs.pinentry-curses;

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
}
