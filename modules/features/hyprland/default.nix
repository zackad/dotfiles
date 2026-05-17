{ inputs, ... }:
{
  flake.homeModules.nixosModule = {
    wayland.windowManager.hyprland = {
      enable = true;
      extraConfig = builtins.readFile ./hyprland.conf;
    };
  };
}
