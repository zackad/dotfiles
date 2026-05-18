{ inputs, ... }:
{
  imports = [
    # adds home-manager options to flake-parts
    inputs.home-manager.flakeModules.home-manager
  ];

  config.systems = [
    "x86_64-linux"
    "aarch64-linux"
    "x86_64-darwin"
    "aarch64-darwin"
  ];
}
