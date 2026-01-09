{
  description = "NixOS configuration as flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { self, nixpkgs, sops-nix }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };

    in
    {
      nixosConfigurations = {
        NixOS = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
          };
          modules = [
            ./configuration.nix
            sops-nix.nixosModules.sops
          ];
        };
      };
    };
}
