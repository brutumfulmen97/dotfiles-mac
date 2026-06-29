{
  description = "Example nix-darwin system flake";

  inputs = {
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };

    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    felixkratz-formulae = {
      url = "github:FelixKratz/homebrew-formulae";
      flake = false;
    };

    aerospace-tap = {
      url = "github:nikitabobko/homebrew-tap";
      flake = false;
    };

    opencode-tap = {
      url = "github:anomalyco/homebrew-tap";
      flake = false;
    };

    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{
    self,
    nix-darwin,
    nixpkgs,
    nix-homebrew,
    homebrew-core,
    homebrew-cask,
    aerospace-tap,
    opencode-tap,
    felixkratz-formulae,
    home-manager,
  }:
  let
    configuration = { pkgs, config, ... }: {
      nixpkgs.config.allowUnfree = true;
      system.primaryUser = "vlatko";
      users.users.vlatko = {
        name = "vlatko";
        home = "/Users/vlatko";
      };

      environment.systemPackages = [
        pkgs.neovim
        pkgs.tmux
        pkgs.ghostty-bin
        pkgs.zed-editor
        pkgs.nodejs_24
        pkgs.pnpm
        pkgs.bun
        pkgs.zoxide
        pkgs.fzf
        pkgs.rustup
        pkgs.go
        pkgs.git
        pkgs.fd
        pkgs.ripgrep
        pkgs.jq
        pkgs.eza
        pkgs.bat
        pkgs.tree
        pkgs.television
        pkgs.lazydocker
        pkgs.lazygit
        pkgs.btop
        pkgs.delta
        pkgs.starship
        pkgs.ollama
      ];

      fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
      ];

      homebrew = {
        enable = true;

        taps = builtins.attrNames config.nix-homebrew.taps;

        casks = [
          "firefox"
          "thebrowsercompany-dia"
          "google-chrome"
          "nikitabobko/tap/aerospace"
          "raycast"
          "orbstack"
          "1password"
          "obsidian"
          "karabiner-elements"
        ];

        brews = [
          "borders"
          "opencode"
        ];

        onActivation.cleanup = "zap";
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
      };

      nix.settings.experimental-features = "nix-command flakes";

      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 6;

      system.defaults = {
        dock.autohide = true;
      };

      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    darwinConfigurations."Vlatkos-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration

        nix-homebrew.darwinModules.nix-homebrew

        {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = "vlatko";

            taps = {
              "homebrew/homebrew-core" = homebrew-core;
              "homebrew/homebrew-cask" = homebrew-cask;
              "nikitabobko/tap" = aerospace-tap;
              "FelixKratz/formulae" = felixkratz-formulae;
              "anomalyco/tap" = opencode-tap;
            };

            mutableTaps = true;
          };
        }

        home-manager.darwinModules.home-manager

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.vlatko =
            import ./home.nix;
        }
      ];
    };
  };
}
