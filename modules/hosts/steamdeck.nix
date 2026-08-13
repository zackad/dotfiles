{ self, inputs, ... }:
{
  # This is your standalone home-manager configuration, meant to be used on non-nixos machines
  # with the home-manager command
  flake.homeConfigurations = {
    "steamdeck" = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
      modules = [
        self.homeModules.deckModule
        {
          home.username = "deck";
          home.homeDirectory = "/home/deck";
        }
      ];
    };
  };

  flake.homeModules.deckModule =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      # Disable systemd reload
      home.activation.reloadSystemd = lib.mkForce "";

      home.stateVersion = "22.11";
      # Let Home Manager install and manage itself.
      programs.home-manager.enable = true;
      home.packages = with pkgs; [
        # CLI Applications
        ansible
        cotp
        dust
        git-machete
        imagemagick
        jq
        keepass # password manager to be used by JetBrains IDE
        nixfmt # Nix code formatter
        nodejs
        pass # Unix password manager
        php
        php84Packages.composer
        pigz # Parallel implementation of gzip
        pwgen
        sshpass # SSH password authetication support for ansible
        tailscale
        unzip
        wineWow64Packages.base
        wl-clipboard # required for to copy pass output into clipboard

        # Custom packages
        # (callPackage ../pkgs/cbr2cbz/default.nix { })
        self.packages.${pkgs.stdenv.hostPlatform.system}.phpstorm-cli-wrapper
        self.packages.${pkgs.stdenv.hostPlatform.system}.phpstorm-url-handler
      ];

      programs.gpg = {
        enable = true;
        settings = {
          keyid-format = "long";
          with-fingerprint = true;
        };
      };

      services.gpg-agent = {
        enable = true;
        # Workaround to fix integration with powerlevel10k instant-prompt
        enableZshIntegration = false;
        pinentry.package = pkgs.pinentry-curses;
      };

      programs.rofi = {
        enable = true;
        plugins = [
          pkgs.rofi-calc
          pkgs.rofi-emoji
        ];
        extraConfig = {
          modi = "combi";
          combi-modi = "window,drun,emoji";
          show-icons = true;
        };
      };

      programs.vim = {
        enable = true;
        settings = {
          number = true;
          relativenumber = true;
        };
        extraConfig = ''
          set smartindent
          set showcmd
          au FileType gitcommit setlocal tw=72
        '';
      };

      programs.yazi = {
        enable = true;
        enableZshIntegration = true;
        shellWrapperName = "yy";
      };

    };

}
