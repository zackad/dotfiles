{ self, inputs, ... }:
{

  # This is your standalone home-manager configuration, meant to be used on non-nixos machines
  # with the home-manager command
  flake.homeConfigurations.macos = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs { system = "aarch64-darwin"; };
    modules = [
      self.homeModules.zackadModule
      {
        home.username = "zackad";
        home.homeDirectory = "/Users/zackad";
      }
    ];
  };

  # This is your home.nix, your module where you configure home-manager
  # It's imported both in standalone configuration above, and in your nixos configuration
  flake.homeModules.zackadModule =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      # This value determines the Home Manager release that your
      # configuration is compatible with. This helps avoid breakage
      # when a new Home Manager release introduces backwards
      # incompatible changes.
      #
      # You can update Home Manager without changing this value. See
      # the Home Manager release notes for a list of state version
      # changes in each release.
      home.stateVersion = "22.11";

      # Let Home Manager install and manage itself.
      programs.home-manager.enable = true;
      home.packages = [
        pkgs.ansible
        pkgs.ansible-lint
        pkgs.aria2
        pkgs.dust
        pkgs.ffmpeg
        pkgs.ghostscript
        pkgs.git-cliff
        pkgs.git-machete
        pkgs.htop
        pkgs.imagemagick
        pkgs.jq
        pkgs.jwt-cli
        pkgs.nixfmt
        pkgs.moreutils
        pkgs.mintotp
        pkgs.opencode
        pkgs.pass
        pkgs.php84
        pkgs.pigz
        pkgs.pinentry-curses
        pkgs.podman
        pkgs.pwgen
        pkgs.openssh
        pkgs.sshpass
        # (pkgs.callPackage ../pkgs/phpstorm-cli-wrapper/default.nix { })
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

      programs.aerospace = {
        enable = true;
        launchd.enable = true;
        launchd.keepAlive = true;
        settings = {
          # Config version for compatibility
          config-version = 2;

          # Startup commands
          after-startup-command = [ ];

          # Normalizations
          enable-normalization-flatten-containers = true;
          enable-normalization-opposite-orientation-for-nested-containers = true;

          # Layout settings
          accordion-padding = 30;
          default-root-container-layout = "tiles";
          default-root-container-orientation = "auto";

          # Callbacks
          on-focused-monitor-changed = [ "move-mouse monitor-lazy-center" ];
          on-focus-changed = [
            "move-mouse window-lazy-center" # Mouse lazily follows any focus (window or workspace)
          ];
          on-window-detected = [
            {
              "if".app-id = "com.jetbrains.PhpStorm";
              run = "move-node-to-workspace 1";
            }

            {
              "if".app-id = "dev.zed.Zed";
              run = "move-node-to-workspace 1";
            }

            {
              "if".app-id = "com.apple.finder";
              run = "move-node-to-workspace 3";
            }

            {
              "if".app-id = "md.obsidian";
              run = "move-node-to-workspace 5";
            }

            {
              "if".app-id = "com.googlecode.iterm2";
              run = "move-node-to-workspace 6";
            }

            {
              "if".app-id = "com.apple.MobileSMS";
              run = "move-node-to-workspace 8";
            }

            {
              "if".app-id = "tv.plex.plexamp";
              run = "move-node-to-workspace 9";
            }

            # Firefox window
            {
              "if".app-id = "org.mozilla.firefox";
              "if".window-title-regex-substring = "Developer — Mozilla Firefox";
              run = "move-node-to-workspace 7";
            }
            {
              "if".app-id = "org.mozilla.firefox";
              run = "move-node-to-workspace 2";
            }
          ];

          automatically-unhide-macos-hidden-apps = false;

          persistent-workspaces = [
            "1"
            "2"
            "3"
            "4"
            "5"
            "6"
            "7"
            "8"
            "9"
          ];

          key-mapping.preset = "qwerty";

          gaps = {
            inner.horizontal = 0;
            inner.vertical = 0;
            outer.left = 0;
            outer.bottom = 0;
            outer.top = 0;
            outer.right = 0;
          };

          mode.main.binding = {
            # Layouts
            "alt-slash" = "layout tiles horizontal vertical";
            "alt-comma" = "layout accordion horizontal vertical";
            "alt-f" = "fullscreen";

            # Focus
            "alt-h" = "focus left";
            "alt-j" = "focus down";
            "alt-k" = "focus up";
            "alt-l" = "focus right";

            # Move
            "alt-shift-h" = "move left";
            "alt-shift-j" = "move down";
            "alt-shift-k" = "move up";
            "alt-shift-l" = "move right";

            # Resize
            "alt-minus" = "resize smart -50";
            "alt-equal" = "resize smart +50";

            # Workspaces
            "alt-1" = "workspace 1";
            "alt-2" = "workspace 2";
            "alt-3" = "workspace 3";
            "alt-4" = "workspace 4";
            "alt-5" = "workspace 5";
            "alt-6" = "workspace 6";
            "alt-7" = "workspace 7";
            "alt-8" = "workspace 8";
            "alt-9" = "workspace 9";

            # Move node to workspace
            "alt-shift-1" = "move-node-to-workspace 1";
            "alt-shift-2" = "move-node-to-workspace 2";
            "alt-shift-3" = "move-node-to-workspace 3";
            "alt-shift-4" = "move-node-to-workspace 4";
            "alt-shift-5" = "move-node-to-workspace 5";
            "alt-shift-6" = "move-node-to-workspace 6";
            "alt-shift-7" = "move-node-to-workspace 7";
            "alt-shift-8" = "move-node-to-workspace 8";
            "alt-shift-9" = "move-node-to-workspace 9";

            "alt-tab" = "workspace-back-and-forth";
            "alt-shift-tab" = "move-workspace-to-monitor --wrap-around next";

            "alt-shift-semicolon" = "mode service";
          };

          mode.service.binding = {
            "esc" = [
              "reload-config"
              "mode main"
            ];
            "r" = [
              "flatten-workspace-tree"
              "mode main"
            ];
            "f" = [
              "layout floating tiling"
              "mode main"
            ];
            "backspace" = [
              "close-all-windows-but-current"
              "mode main"
            ];

            "alt-shift-h" = [
              "join-with left"
              "mode main"
            ];
            "alt-shift-j" = [
              "join-with down"
              "mode main"
            ];
            "alt-shift-k" = [
              "join-with up"
              "mode main"
            ];
            "alt-shift-l" = [
              "join-with right"
              "mode main"
            ];
          };
        };
      };

      programs.bat = {
        enable = true;
        config = {
          style = "plain";
        };
      };

      programs.difftastic = {
        enable = true;
        git.enable = true;
        options = {
          display = "inline";
          background = "dark";
          color = "always";
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
          "--group-directories-first"
          "--header"
        ];
      };

      programs.fzf = {
        enable = true;
        enableZshIntegration = true;
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

      programs.gpg = {
        enable = true;
        settings = {
          keyid-format = "long";
        };
      };

      programs.yazi = {
        enable = true;
        enableZshIntegration = true;
        shellWrapperName = "yy";
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
