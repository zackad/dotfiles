{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "zackad";
  home.homeDirectory = "/Users/zackad";

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
  home.packages = [
    pkgs.ansible
    pkgs.ansible-lint
    pkgs.aria
    pkgs.direnv
    pkgs.ffmpeg
    pkgs.git-machete
    pkgs.ghostscript
    pkgs.htop
    pkgs.imagemagick
    pkgs.jq
    pkgs.pass
    pkgs.php83
    pkgs.pigz
    pkgs.pinentry-curses
    pkgs.openssh
    pkgs.sshpass
  ];

  programs.bat = {
    enable = true;
    config = {
      style = "plain";
    };
  };

  programs.git = {
    enable = true;
    userName = "zackad";
    userEmail = "zackad.dev@gmail.com";
    signing.key = "5E11F0B6C1EF4843";
    aliases = {
      cm = "checkout master";
      l = "log --date=short";
      ma = "machete add";
      md = "machete go down";
      mu = "machete update";
      ms = "machete status";
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
    settings = {
      keyid-format = "long";
    };
  };

  programs.lsd = {
    enable = true;
    settings = {
      layout = "grid";
      sorting.dir-grouping = "first";
      blocks = ["permission" "user" "size" "name"];
    };
  };
}
