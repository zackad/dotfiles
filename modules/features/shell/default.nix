{ self, inputs, ... }:
let
  zshModule =
    { lib, pkgs, ... }:
    {
      home.packages = [
        self.packages.${pkgs.stdenv.hostPlatform.system}.my-custom-zsh-completions
      ];

      home.sessionVariables = {
        EDITOR = "vim";
        GPG_TTY = "$TTY";
        PAGER = "less -FRX";
        RSYNC_OLD_ARGS = "1"; # workaround for escape introduced by rsync v3.2.4
      };

      home.shellAliases = {
        console = "bin/console";
        gzip = "pigz";
        cat = "bat";
      };

      programs.zsh = {
        enable = true;
        autosuggestion.enable = true;
        oh-my-zsh = {
          enable = true;
          extraConfig = ''
            # Uncomment the following line to use case-sensitive completion.
            CASE_SENSITIVE="true"
          '';
          plugins = [
            "git"
            "yarn"
          ];
        };
        envExtra = ''
          PATH="$PATH:$HOME/.local/bin"
          export PATH

          export GPG_TTY=$(tty)
        '';

        initContent = lib.mkMerge [
          # Enable powerlevel10k instant prompt
          (lib.mkBefore ''
            if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
              source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
            fi
          '')

          (''
            [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
            unalias yy

            fpath=($HOME/.nix-profile/share/zsh/site-functions $fpath)
            autoload -Uz compinit
            compinit
          '')

          # Wrapper for mintotp with password-store integration
          (''
            otp() {
              if [ -z "$1" ]; then
                echo "Usage: otp <path/to/secret>"
                return 1
              fi
              pass "$1" | ${pkgs.mintotp}/bin/mintotp
            }
            compdef _pass otp
          '')

          (''
            # Prepend nix profile
            # Nix
            if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
              . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
            fi

            # home-manager session
            if [ -e $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh ]; then
              . $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
            fi
            # End Nix
          '')
        ];
        history = {
          findNoDups = true;
          ignoreAllDups = true;
          ignoreDups = true;
          saveNoDups = true;
        };
        plugins = [
          {
            name = "powerlevel10k";
            src = pkgs.zsh-powerlevel10k;
            file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
          }
          {
            name = "fzf-tab";
            src = pkgs.zsh-fzf-tab;
            file = "share/fzf-tab/fzf-tab.plugin.zsh";
          }
        ];
      };
    };
in
{
  flake.homeModules.nixosModule = zshModule;
  flake.homeModules.zackadModule = zshModule;
}
