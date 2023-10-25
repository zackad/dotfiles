{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "zackad";
  home.homeDirectory = "/home/zackad";

  # Overlay for nixpkgs with custom/updated build
  nixpkgs.overlays = [
    (finas: prev: {
      sayonara = prev.sayonara.overrideAttrs (old: {
        src = prev.fetchFromGitLab {
          owner = "luciocarreras";
          repo = "sayonara-player";
          rev = "1.8.0-beta1";
          sha256 = "f8r8thiWyJ371TPBh1sWrJsewSTdnSXR5djOc1rY9dQ=";
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
    alacritty
    ansible
    ansible-lint
    aria
    barrier
    bat
    chromium
    direnv
    firefox
    git-machete
    htop
    jetbrains.phpstorm
    keepass
    lsd
    nixpkgs-fmt
    pass
    php82
    pigz
    sayonara
    screenfetch
    sshpass
    telegram-desktop
    tmux
    vim
    wine64
    (callPackage ./phpstorm-url-handler/default.nix {})
  ];


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
      core.excludesFile = "~/.gitignore";
      format.pretty = "format:%C(yellow)%ad %Cblue%h %Cgreen%<(7)%aN:%Cred%d %Creset%s";
      init.defaultbranch = "master";
      log.date = "format:%Y-%m-%d %H:%M:%S";
      merge.ff = "no";
      tag.gpgSign = true;
      tag.sort = "version:refname";
    };
    delta = {
      enable = true;
      options = {
        line-numbers = true;
        hunk-header-style = "omit";
      };
    };
  };

  programs.gpg = {
    enable = true;
    settings= {
      keyid-format = "long";
      with-fingerprint = true;
    };
  };

  services.gpg-agent.enable = true;
  services.gpg-agent.pinentryFlavor = "curses";

  programs.vscode ={
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
    extraConfig = ''
    '';
  };
}
