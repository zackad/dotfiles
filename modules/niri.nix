{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.niri.enable = true;

  # These will be MERGED with configuration.nix
  environment.systemPackages =
    with pkgs;
    [ ]
    ++ lib.optionals config.programs.niri.enable [
      xwayland-satellite
    ];
}
