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
    pkgs.aria2
    pkgs.bat
    pkgs.delta
    pkgs.direnv
    pkgs.exa
    pkgs.ffmpeg
    pkgs.git
    pkgs.ghostscript
    pkgs.htop
    pkgs.hugo
    pkgs.imagemagick
    pkgs.jq
    pkgs.rar
    pkgs.wireguard-go
    pkgs.wireguard-tools
  ];
}
