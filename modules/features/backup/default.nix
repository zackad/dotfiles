{ self, inputs, ... }:
let
  backupModule =
    { lib, pkgs, ... }:
    {
      home.packages = [
        pkgs.borgbackup
        pkgs.restic
        pkgs.resticprofile
      ];

    };
in
{
  flake.homeModules.zackadModule = backupModule;
}
