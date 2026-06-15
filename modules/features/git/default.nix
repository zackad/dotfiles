{ self, inputs, ... }:
let
  gitModule =
    { lib, pkgs, ... }:
    {
      programs.delta = {
        enable = true;
        enableGitIntegration = true;
        options = {
          line-numbers = true;
          hunk-header-style = "omit";
        };
      };

      programs.difftastic = {
        enable = false;
        git.enable = true;
        options = {
          display = "inline";
          background = "dark";
          color = "always";
        };
      };

      programs.git = {
        enable = true;
        signing.key = "C2B91511AE73C825";
        signing.format = "openpgp";
        settings = {
          user.name = "zackad";
          user.email = "zackad@zackad.dev";
          commit.verbose = true;
          core.excludesFile = "~/.gitignore";
          diff.algorithm = "histogram";
          format.pretty = "format:%C(yellow)%ad %Cblue%h %Cgreen%<(7)%aN:%Cred%d %Creset%s";
          init.defaultbranch = "master";
          log.date = "format:%Y-%m-%d %H:%M:%S";
          merge.ff = "no";
          merge.conflictstyle = "zdiff3";
          tag.gpgSign = true;
          tag.sort = "-taggerdate";
          aliases = {
            cm = "checkout master";
            l = "log --date=short";
            ma = "machete add";
            md = "machete go down";
            mu = "machete update";
            ms = "machete status";
            q = "log --all --decorate --oneline --graph";
          };
        };
      };

    };
in
{
  flake.homeModules.nixosModule = gitModule;
  flake.homeModules.zackadModule = gitModule;
  flake.homeModules.deckModule = gitModule;
}
