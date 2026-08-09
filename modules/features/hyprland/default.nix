{ inputs, ... }:
{
  flake.homeModules.nixosModule =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.waybar
        pkgs.wl-clipboard
      ];

      wayland.windowManager.hyprland = {
        enable = true;
        configType = "hyprlang";
        extraConfig = builtins.readFile ./hyprland.conf;
      };
      xdg.configFile."hypr/hyprland.lua".text = builtins.readFile ./hyprland.lua;
    };
}
