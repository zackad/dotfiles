{ self, inputs, ... }:
let
  downloaderModule =
    { lib, pkgs, ... }:
    {
      programs.aria2 = {
        enable = true;
        settings = {
          split = 16;
          min-split-size = "2M";
          max-concurrent-downloads = 16;
          max-concurrent-per-server = 16;
        };
      };

      programs.yt-dlp = {
        enable = true;
        settings = {
          restrict-filenames = true;
          downloader = "aria2c";
          downloader-args = "aria2c:'-j 16 -s 16 -x 16 -k 20M'";
          format = "bestvideo[height<=1080]+bestaudio/best[height<=1080]";
        };
        extraConfig = "";
      };

    };
in
{
  flake.homeModules.nixosModule = downloaderModule;
  flake.homeModules.zackadModule = downloaderModule;
  flake.homeModules.deckModule = downloaderModule;
}
