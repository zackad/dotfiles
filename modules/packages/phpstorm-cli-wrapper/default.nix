{ inputs, ... }:
{
  perSystem =
    { pkgs, system, ... }:
    let
      unfreePkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      packages.phpstorm-cli-wrapper-nixos = pkgs.writeShellApplication {
        name = "pstorm";
        text = ''
          ${unfreePkgs.steam-run}/bin/steam-run "$HOME"/Applications/PhpStorm/bin/phpstorm "$@" > /dev/null 2>&1 & disown
        '';
      };

      packages.phpstorm-cli-wrapper = pkgs.writeShellApplication {
        name = "pstorm";
        text = ''
          phpstorm "$@" > /dev/null 2>&1 & disown
        '';
      };
    };
}
