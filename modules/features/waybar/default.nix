{ inputs, ... }:
{
  flake.homeModules.nixosModule = {
    home.file.".config/waybar/config.jsonc".source = ./config.jsonc;
    home.file.".config/waybar/modules.jsonc".source = ./modules.jsonc;
    home.file.".config/waybar/style.css".source = ./style.css;
    home.file.".config/waybar/power_menu.xml".source = ./power_menu.xml;
  };
}
