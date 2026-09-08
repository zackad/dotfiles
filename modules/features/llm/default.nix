{ self, inputs, ... }:
let
  llmModule =
    { lib, pkgs, ... }:
    {
      home.packages = [ pkgs.llama-cpp ];
    };
in
{
  flake.homeModules.nixosModule = llmModule;
}
