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

        # Custom packages
        # (callPackage ../pkgs/cbr2cbz/default.nix { })
        self.packages.${pkgs.stdenv.hostPlatform.system}.phpstorm-cli-wrapper
        self.packages.${pkgs.stdenv.hostPlatform.system}.phpstorm-url-handler
      ];

      home.sessionVariables = {
        EDITOR = "vim";
        PAGER = "less -FRX";
        RSYNC_OLD_ARGS = "1"; # workaround for escape introduced by rsync v3.2.4
      };

      home.shellAliases = {
        console = "bin/console";
        gzip = "pigz";
        cat = "bat";
      };

      programs.aria2 = {
        enable = true;
        settings = {
          split = 16;
          min-split-size = "2M";
          max-concurrent-downloads = 16;
          max-concurrent-per-server = 16;
        };
      };

      programs.bat = {
        enable = true;
        config = {
          style = "plain";
        };
      };

      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

      programs.eza = {
        enable = true;
        icons = "auto";
        extraOptions = [
          "--header"
          "--group-directories-first"
        ];
      };

      programs.fzf = {
        enable = true;
        enableZshIntegration = true;
      };

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

      programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
        options = [
          "--cmd"
          "cd"
        ];
      };

    };

}
